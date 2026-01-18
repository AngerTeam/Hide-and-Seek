using System;
using CraftyVoxelEngine;
using InventoryModule;
using PlayerCameraModule;
using PlayerModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;
using UnityEngine;

namespace Combat
{
	public class AutoAimingController : IDisposable
	{
		private readonly PlayerModelsHolder playerModelsHolder_;

		private readonly MyPlayerStatsModel myPlayerStatsModel_;

		private readonly PlayerCameraManager cameraManager_;

		private readonly PlaymatesActorsHolder actorsHolder_;

		private readonly VoxelEngine voxelEngine_;

		private readonly PersistanceUserSettings userSettings;

		public AutoAimingController()
		{
			SingletonManager.Get<PlayerModelsHolder>(out playerModelsHolder_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			SingletonManager.Get<PlaymatesActorsHolder>(out actorsHolder_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
		}

		public void Dispose()
		{
			cameraManager_.InputModel.autoAimTarget = null;
		}

		public void Update()
		{
			if (userSettings.autoAiming && !myPlayerStatsModel_.stats.IsDead)
			{
				cameraManager_.InputModel.autoAimTarget = FindNearestPosition();
			}
			else
			{
				cameraManager_.InputModel.autoAimTarget = null;
			}
		}

		private Vector3? FindNearestPosition()
		{
			ArtikulsEntries weapon = InventoryModuleController.GetWeapon(myPlayerStatsModel_.stats.SelectedArtikul);
			if ((!myPlayerStatsModel_.stats.Aiming && !weapon.autoaiming_enable) || (myPlayerStatsModel_.stats.Aiming && !weapon.sniper_autoaiming_enable))
			{
				return null;
			}
			float num = cameraManager_.InputModel.autoAimMaxAngle;
			float targetDistance = cameraManager_.TargetDistance;
			Ray ray = new Ray(cameraManager_.Transform.position, cameraManager_.Transform.forward);
			Vector3? result = null;
			float num2 = ((!myPlayerStatsModel_.stats.Aiming) ? weapon.weapon_range : weapon.weapon_range_aim);
			foreach (PlayerStatsModel value in playerModelsHolder_.Models.Values)
			{
				if (!value.visibility.Visible || value.IsDead || value.InMyPlayerTeam || (value.hideAndSeek != null && value.hideAndSeek.IsHidden))
				{
					continue;
				}
				Vector3 position = value.Position;
				if ((position - ray.origin).magnitude > num2 + targetDistance + 1.5f || (position - myPlayerStatsModel_.stats.Position).sqrMagnitude < 0.15f || Vector3.Distance(ray.origin, position) < Vector3.Distance(ray.origin, myPlayerStatsModel_.stats.Position))
				{
					continue;
				}
				PlaymateEntity actor = actorsHolder_.GetActor(value.persId);
				if (actor == null)
				{
					continue;
				}
				Collider[] array = ((actor.Controller.Model.visual.bodyColliders == null) ? null : actor.Controller.Model.visual.bodyColliders);
				if (array == null)
				{
					continue;
				}
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] == null)
					{
						continue;
					}
					Vector3 center = array[i].bounds.center;
					if (voxelEngine_.Manager.RayTest(ray.origin, center, true))
					{
						continue;
					}
					Ray originalRay = new Ray(ray.origin, (center - ray.origin).normalized);
					float num3 = Vector3.Angle(ray.direction, originalRay.direction);
					if (num3 < num)
					{
						RaycastHit raycastHit;
						PlayerStatsModel playerStatsModel = CombatUtils.RaycastHasActor(originalRay, num2 + targetDistance, 16384, weapon.ranged, out raycastHit);
						if (playerStatsModel != null)
						{
							num = num3;
							result = center;
						}
					}
				}
			}
			return result;
		}
	}
}

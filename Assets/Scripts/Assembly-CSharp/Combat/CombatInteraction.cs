using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyVoxelEngine;
using Extensions;
using InventoryModule;
using PlayerModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;
using UnityEngine;

namespace Combat
{
	public class CombatInteraction : Singleton
	{
		public Func<string, PlaymateEntity> getActor;

		private float pushForce_;

		private ArtikulsEntries artikulData_;

		private CameraManager cameraManager_;

		private float hitDistance_;

		private InputManager inputManager_;

		private MyPlayerModuleController myPlayerManager_;

		private MyPlayerStatsModel myPlayerModel_;

		private PlaymatesActorsHolder actorsHolder_;

		private RaycastManager raycastManager_;

		private float voxelDistance_;

		private PlayerModelsHolder playerModelsHolder_;

		private VoxelInteraction voxelInteraction_;

		public RaycastHit currentUnityRaycastHit;

		public VoxelRaycastHit currentVoxelRaycastHit;

		public PlayerStatsModel currentPlayerStatsModel;

		public bool IsRangedWeapon { get; private set; }

		public event Action<string, Vector3> MyPlayerHitEnemy;

		public event Action<int?, Vector3, Vector3[]> MyPlayerProjectileShot;

		public event Action<int, Vector3, string[], List<VoxelKey>> MyPlayerProjectileHit;

		public void UpdateRaycasts()
		{
			currentPlayerStatsModel = RaycastEnemy(out currentUnityRaycastHit, out currentVoxelRaycastHit);
			Quaternion value = CalcScatterRotationOffset();
			RaycastHit raycastHit;
			PlayerStatsModel playerStatsModel = RaycastEnemy(out raycastHit, out currentVoxelRaycastHit, value);
			SetupProjectileType(playerStatsModel, raycastHit);
		}

		public bool CheckIfEnemy()
		{
			return currentPlayerStatsModel != null;
		}

		public override void Dispose()
		{
			myPlayerModel_.stats.SelectedArtikulChanged -= SetWeaponStats;
			myPlayerModel_.stats.AimingChanged -= HandleAimingChanged;
			myPlayerManager_.Fallen -= KillMe;
		}

		public void DoHit(string targetId, int health)
		{
			DoHit(myPlayerModel_.stats.persId, targetId, health);
		}

		public void DoHit(string attackerId, string targetId, int health)
		{
			PlayerStatsModel value;
			if (myPlayerModel_.stats.persId == targetId)
			{
				value = myPlayerModel_.stats;
			}
			else
			{
				playerModelsHolder_.Models.TryGetValue(targetId, out value);
			}
			if (value != null)
			{
				value.AttackerId = attackerId;
				value.HealthCurrent = health;
			}
		}

		public void DoProjectileShot(string persId, Vector3[] trajectory, int clientProjectileId)
		{
			PlaymateEntity actor = actorsHolder_.GetActor(persId);
			if (actor != null)
			{
				actor.Controller.View.SendProjectile(trajectory, clientProjectileId);
			}
		}

		public override void Init()
		{
			SingletonManager.Get<InputManager>(out inputManager_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<MyPlayerModuleController>(out myPlayerManager_);
			SingletonManager.Get<PlaymatesActorsHolder>(out actorsHolder_);
			SingletonManager.Get<RaycastManager>(out raycastManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerModel_);
			SingletonManager.Get<PlayerModelsHolder>(out playerModelsHolder_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
		}

		public override void OnDataLoaded()
		{
			myPlayerModel_.stats.SelectedArtikulChanged += SetWeaponStats;
			myPlayerModel_.stats.AimingChanged += HandleAimingChanged;
			SetWeaponStats(myPlayerModel_.stats.SelectedArtikul);
			myPlayerManager_.Fallen += KillMe;
		}

		public void StartAttack()
		{
		}

		public void StopAttack()
		{
		}

		public void Hit(string persId)
		{
			PlayerStatsModel value;
			playerModelsHolder_.Models.TryGetValue(persId, out value);
			bool flag = value != null;
			if (flag)
			{
				Vector3 forward = cameraManager_.Transform.forward;
				forward.Normalize();
				value.InvokePushPlayer(forward, pushForce_);
				value.InvokeBlinkRed();
				this.MyPlayerHitEnemy.SafeInvoke(value.persId, forward);
			}
			PlayAttackSound(flag);
		}

		public void ProjectileShot(int? artikulId, Vector3 direction, Vector3[] trajectory)
		{
			this.MyPlayerProjectileShot.SafeInvoke(artikulId, direction, trajectory);
			PlayAttackSound(true);
		}

		public void ProjectileHit(int clientProjectileId, Vector3 point, float radius)
		{
			List<string> list = new List<string>();
			foreach (PlayerStatsModel value in playerModelsHolder_.Models.Values)
			{
				if (Vector3.Distance(point, value.Position) < radius)
				{
					list.Add(value.persId);
				}
			}
			if (this.MyPlayerProjectileHit != null)
			{
				List<VoxelKey> arg = ((!voxelInteraction_.model.allowDig) ? new List<VoxelKey>() : raycastManager_.GetVoxelsInSphere(point + new Vector3(0f, 0.1f, 0f), radius));
				this.MyPlayerProjectileHit(clientProjectileId, point, list.ToArray(), arg);
			}
		}

		private void KillMe()
		{
			DoHit(myPlayerModel_.stats.persId, myPlayerModel_.stats.persId, 0);
		}

		private void PlayAttackSound(bool successHit)
		{
			if (artikulData_ != null && !IsRangedWeapon && successHit && artikulData_.sound_group_id > 0)
			{
				SoundProvider.PlayGroupSound2D(artikulData_.sound_group_id, 1f);
			}
		}

		private PlayerStatsModel RaycastEnemy(out RaycastHit raycastHit, out VoxelRaycastHit voxelRaycast, Quaternion? rotationOffset = null)
		{
			voxelRaycast = raycastManager_.VoxelRayCastWrap(hitDistance_, true, rotationOffset);
			Vector3 position = cameraManager_.Transform.position;
			Ray originalRay = cameraManager_.PlayerCamera.ScreenPointToRay(inputManager_.Target);
			if (rotationOffset.HasValue)
			{
				originalRay.direction = Quaternion.LookRotation(originalRay.direction) * rotationOffset.Value * Vector3.forward;
			}
			PlayerStatsModel playerStatsModel = CombatUtils.RaycastHasActor(originalRay, hitDistance_ + cameraManager_.TargetDistance, 16384, IsRangedWeapon, out raycastHit);
			voxelDistance_ = ((!voxelRaycast.success) ? float.MaxValue : Vector3.Distance(voxelRaycast.Point, position));
			float num = ((playerStatsModel == null) ? float.MaxValue : Vector3.Distance(raycastHit.point, position));
			if (num < voxelDistance_ && playerStatsModel != null && !playerStatsModel.IsDead && !playerStatsModel.IsMyPlayer && !playerStatsModel.InMyPlayerTeam)
			{
				return playerStatsModel;
			}
			return null;
		}

		public PlaymateEntity GetActor(string persId)
		{
			return actorsHolder_.GetActor(persId);
		}

		private void SetupProjectileType(PlayerStatsModel playerStatsModel, RaycastHit raycastHit)
		{
			ProjectileModel projectile = myPlayerModel_.stats.projectile;
			PlaymateEntity playmateEntity = null;
			if (playerStatsModel != null)
			{
				playmateEntity = GetActor(playerStatsModel.persId);
			}
			if (playmateEntity != null && playmateEntity.Controller.Model.visual.SpineBone != null)
			{
				projectile.parent = playmateEntity.Controller.Model.visual.SpineBone;
				projectile.target = raycastHit.point;
				projectile.targetKey = null;
				projectile.targetType = ProjectileTargetType.Playmate;
				projectile.targetPersId = playmateEntity.Model.persId;
			}
			else if (currentVoxelRaycastHit.success && voxelDistance_ < hitDistance_)
			{
				projectile.target = currentVoxelRaycastHit.Point;
				projectile.voxelValue = currentVoxelRaycastHit.value;
				projectile.targetKey = currentVoxelRaycastHit.Full;
				projectile.targetType = ProjectileTargetType.Voxel;
				projectile.targetPersId = null;
			}
			else
			{
				Vector3 normalized = (currentVoxelRaycastHit.Point - cameraManager_.Transform.position).normalized;
				projectile.target = cameraManager_.Transform.position + normalized * 500f;
				projectile.targetType = ProjectileTargetType.Sky;
				projectile.targetKey = null;
				projectile.targetPersId = null;
			}
		}

		private void SetWeaponStats(int artikul)
		{
			artikulData_ = InventoryModuleController.GetWeapon(artikul);
			hitDistance_ = ((!myPlayerModel_.stats.Aiming) ? artikulData_.weapon_range : artikulData_.weapon_range_aim);
			IsRangedWeapon = artikulData_.ranged;
			pushForce_ = artikulData_.hit_repulsion_force;
		}

		private void HandleAimingChanged(bool aiming)
		{
			SetWeaponStats(myPlayerModel_.stats.SelectedArtikul);
		}

		private Quaternion CalcScatterRotationOffset()
		{
			float weaponScatter = myPlayerModel_.stats.WeaponScatter;
			float f = weaponScatter * ((float)Math.PI / 180f);
			float num = UnityEngine.Random.Range(Mathf.Cos(f), 1f);
			float f2 = UnityEngine.Random.Range(0f, (float)Math.PI * 2f);
			Vector3 forward = new Vector3(Mathf.Sqrt(1f - num * num) * Mathf.Cos(f2), Mathf.Sqrt(1f - num * num) * Mathf.Sin(f2), num);
			return Quaternion.LookRotation(forward);
		}
	}
}

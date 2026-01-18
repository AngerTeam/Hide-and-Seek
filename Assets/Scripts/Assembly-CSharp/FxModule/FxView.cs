using System;
using System.Collections.Generic;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils.Unity;
using CraftyVoxelEngine;
using CraftyVoxelEngine.FX;
using Extensions;
using PlayerModule;
using ProjectilesModule;
using UnityEngine;

namespace FxModule
{
	public class FxView : IDisposable
	{
		private class FxInstance : IDisposable
		{
			public float destroyMoment;

			public FileHolder fileHolder;

			public FxEntries fx;

			public GameObject gameObject;

			public Vector3? point;

			public void Dispose()
			{
				if (gameObject != null)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
		}

		public static int bloodVoxelAtikulId = 12;

		private readonly GameObject container_;

		private readonly ProjectilesManager projectilesManager_;

		private ProjectileController projectile_;

		private FileHolder projectileFileHolder_;

		private CameraManager cameraManager_;

		private FilesManager filesManager_;

		private List<FxInstance> instances_;

		private QueueManager queueManager_;

		private UnityEvent unityEvent_;

		private VoxelInteractionEffects voxelInteractionEffects_;

		private FileHolder explosionFxFileHolder;

		private FxEntries projectileEntries_;

		private FxEntries[] FxEntries;

		private ProjectilesEntries projectileEntry_;

		private float cooldown_;

		public bool HasProjectile { get; private set; }

		public event Action<string> ProjectileAnimationComplete;

		public FxView(GameObject container, int projectileFxId, FxEntries[] fxEntries, ProjectilesEntries projectileEntry = null, float cooldown = 0f)
		{
			if (!SingletonManager.TryGet<FilesManager>(out filesManager_, 2))
			{
				return;
			}
			container_ = container;
			FxEntries = fxEntries;
			projectileEntry_ = projectileEntry;
			cooldown_ = cooldown;
			HasProjectile = false;
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<QueueManager>(out queueManager_, 2);
			SingletonManager.TryGet<VoxelInteractionEffects>(out voxelInteractionEffects_);
			SingletonManager.TryGet<ProjectilesManager>(out projectilesManager_);
			PreloadFx();
			if (!HasProjectile && projectileFxId > 0)
			{
				if (FxContentMap.Fx != null)
				{
					FxContentMap.Fx.TryGetValue(projectileFxId, out projectileEntries_);
				}
				projectileFileHolder_ = LoadFx(projectileFxId);
				HasProjectile = projectileFileHolder_ != null;
			}
			if (HasProjectile)
			{
				queueManager_.AddTask(SpawnProjectile);
			}
		}

		private void PreloadFx()
		{
			if (FxEntries == null)
			{
				return;
			}
			for (int i = 0; i < FxEntries.Length; i++)
			{
				FxEntries fxEntries = FxEntries[i];
				FileHolder fileHolder = LoadFx(fxEntries.id);
				MomentsEntries value;
				FxContentMap.Moments.TryGetValue(fxEntries.moment_id, out value);
				if (value != null)
				{
					if (value.name == "explosion")
					{
						explosionFxFileHolder = fileHolder;
					}
					else if (value.name == "projectile")
					{
						projectileFileHolder_ = fileHolder;
						projectileEntries_ = fxEntries;
						HasProjectile = true;
					}
				}
			}
		}

		public void Dispose()
		{
			if (projectile_ != null)
			{
				projectile_.CompleteAnimation -= HandleProjectileAnimationComplete;
				projectile_.Dispose();
			}
			if (instances_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
				for (int i = 0; i < instances_.Count; i++)
				{
					instances_[i].Dispose();
				}
				instances_.Clear();
				instances_ = null;
			}
		}

		private FileHolder LoadFx(int fxId)
		{
			FileHolder result = null;
			FxEntries value;
			if (FxContentMap.Fx != null && FxContentMap.Fx.TryGetValue(fxId, out value))
			{
				result = filesManager_.AddLoadBundleTask(value.GetFullBundlePath());
			}
			return result;
		}

		public void HandleMoment(string fxMoment, Vector3? point = null)
		{
			if (FxEntries == null)
			{
				return;
			}
			for (int i = 0; i < FxEntries.Length; i++)
			{
				FxEntries fxEntries = FxEntries[i];
				MomentsEntries value;
				FxContentMap.Moments.TryGetValue(fxEntries.moment_id, out value);
				if (value != null && !(value.name != fxMoment))
				{
					if (instances_ == null)
					{
						instances_ = new List<FxInstance>();
						SingletonManager.Get<UnityEvent>(out unityEvent_, 2);
						unityEvent_.Subscribe(UnityEventType.Update, Update);
					}
					FxInstance fxInstance = new FxInstance
					{
						fx = fxEntries,
						point = point
					};
					instances_.Add(fxInstance);
					fxInstance.fileHolder = LoadFx(fxEntries.id);
					queueManager_.AddTask(delegate
					{
						Spawn(fxInstance);
					});
				}
			}
		}

		public void SendProjectile(ProjectileModel model)
		{
			if (!HasProjectile || projectilesManager_ == null)
			{
				return;
			}
			SpawnProjectileForSend();
			bool resetLayer = projectileEntries_ != null && projectileEntries_.show_on_target == 1;
			ProjectileController currentProjectile = projectile_;
			projectile_.targetPersId = model.targetPersId;
			TrajectoryChain trajectoryChain = null;
			Vector3 lambdaPoint = model.target;
			Quaternion? rotation = null;
			if (lambdaPoint != projectile_.Position)
			{
				rotation = Quaternion.LookRotation((lambdaPoint - projectile_.Position).normalized);
			}
			ushort lambdaValue;
			switch (model.targetType)
			{
			case ProjectileTargetType.Undefined:
				if (projectileEntry_ == null)
				{
					projectile_.Send(null);
				}
				break;
			case ProjectileTargetType.Sky:
			{
				trajectoryChain = CalculateTrajectory(projectile_.Position, lambdaPoint);
				ProjectileController projectileController3 = projectile_;
				TrajectoryChain trajectory = trajectoryChain;
				projectileController3.Send(lambdaPoint, cameraManager_.Transform.rotation, null, null, null, trajectory);
				break;
			}
			case ProjectileTargetType.Playmate:
				lambdaValue = (ushort)bloodVoxelAtikulId;
				trajectoryChain = CalculateTrajectory(projectile_.Position, lambdaPoint);
				projectile_.Send(lambdaPoint, rotation, model.targetKey, delegate
				{
					MakeEffects(currentProjectile, lambdaPoint, lambdaValue, "bodyCollision");
				}, model.parent, trajectoryChain, resetLayer);
				model.parent = null;
				break;
			case ProjectileTargetType.Voxel:
			{
				lambdaValue = model.voxelValue;
				trajectoryChain = CalculateTrajectory(projectile_.Position, lambdaPoint);
				ProjectileController projectileController2 = projectile_;
				TrajectoryChain trajectory = trajectoryChain;
				projectileController2.Send(lambdaPoint, rotation, model.targetKey, delegate
				{
					MakeEffects(currentProjectile, lambdaPoint, lambdaValue, "enviromentCollision");
				}, null, trajectory, resetLayer);
				break;
			}
			case ProjectileTargetType.Item:
			{
				trajectoryChain = CalculateTrajectory(projectile_.Position, lambdaPoint);
				ProjectileController projectileController = projectile_;
				TrajectoryChain trajectory = trajectoryChain;
				projectileController.Send(lambdaPoint, null, null, null, null, trajectory);
				break;
			}
			}
			if (trajectoryChain != null)
			{
				ProjectileController projectile = projectile_;
				projectile_.sync = true;
				projectilesManager_.ReportProjectileShot(Vector3.zero, trajectoryChain.ToArray());
				projectile_.PendingExplosionHappened += delegate(Vector3 pos)
				{
					projectilesManager_.ReportProjectileHit(projectile.clientProjectileId, pos, projectileEntry_.damage_radius);
				};
			}
			projectile_ = null;
		}

		public void SendProjectile(Vector3[] trajectory, int clientProjectileId)
		{
			if (HasProjectile)
			{
				projectile_.clientProjectileId = clientProjectileId;
				ProjectileController projectileController = projectile_;
				TrajectoryChain trajectory2 = new TrajectoryChain(trajectory);
				projectileController.Send(null, null, null, null, null, trajectory2);
			}
		}

		public void SpawnProjectile()
		{
			if (projectileEntries_ != null && projectileEntries_.show_before_shot == 1)
			{
				SpawnProjectileForSend();
			}
		}

		private void SpawnProjectileForSend()
		{
			if (HasProjectile && projectile_ == null && projectilesManager_ != null)
			{
				projectile_ = projectilesManager_.SpawnProjectile(container_, projectileFileHolder_);
				projectile_.View.ExplosionFxFileHolder = explosionFxFileHolder;
				projectile_.CompleteAnimation += HandleProjectileAnimationComplete;
			}
		}

		private TrajectoryChain CalculateTrajectory(Vector3 position, Vector3 target)
		{
			if (!HasProjectile || projectileEntry_ == null)
			{
				return null;
			}
			return projectilesManager_.CalculateTrajectory(position, target, projectileEntry_.starting_speed, projectileEntry_.explosion_time);
		}

		private static void RemoveColliders(GameObject prefabInstance)
		{
			Collider[] componentsInChildren = prefabInstance.GetComponentsInChildren<Collider>();
			if (componentsInChildren != null && componentsInChildren.Length > 0)
			{
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					componentsInChildren[i].enabled = false;
				}
			}
		}

		private void HandleProjectileAnimationComplete(GameObject obj, VoxelKey endKey, string targetPersId)
		{
			this.ProjectileAnimationComplete.SafeInvoke(targetPersId);
		}

		private GameObject Instantiate(Vector3? point, AnchorsEntries anchorsEntry, FileHolder fileHolder)
		{
			GameObject result;
			if (!RenderHierarchyUtils.TryInstansiate(fileHolder.loadedAssetBundle, out result))
			{
				result = (GameObject)fileHolder.Instantiate();
			}
			if (result != null)
			{
				GameObject gameObject = null;
				if (anchorsEntry != null)
				{
					gameObject = GameObjectUtils.FindChild(container_, anchorsEntry.name);
				}
				if (gameObject == null)
				{
					gameObject = container_;
				}
				RemoveColliders(result);
				if (point.HasValue)
				{
					result.transform.position = point.Value;
					result.transform.localRotation = Quaternion.identity;
				}
				else
				{
					result.transform.SetParent(gameObject.transform, false);
					GameObjectUtils.SetLayerRecursive(result, container_.layer);
					result.transform.localPosition = Vector3.zero;
					result.transform.localRotation = Quaternion.identity;
				}
			}
			return result;
		}

		private void MakeEffects(ProjectileController controller, Vector3 point, ushort value, string fxMoment)
		{
			if (voxelInteractionEffects_ != null)
			{
				bool big = cooldown_ >= 1f;
				voxelInteractionEffects_.MakeEffects(point, value, big, false);
			}
			HandleMoment(fxMoment, point);
			if (controller != null && projectileEntries_.show_on_target == 0)
			{
				controller.Dispose();
			}
		}

		private void Spawn(FxInstance fxInstance)
		{
			float num = fxInstance.fx.duration;
			if (num == 0f)
			{
				num = 2f;
			}
			fxInstance.destroyMoment = Time.time + num;
			if (!(container_ == null))
			{
				AnchorsEntries value;
				FxContentMap.Anchors.TryGetValue(fxInstance.fx.anchor_id, out value);
				fxInstance.gameObject = Instantiate(fxInstance.point, value, fxInstance.fileHolder);
			}
		}

		private void Update()
		{
			for (int num = instances_.Count - 1; num >= 0; num--)
			{
				FxInstance fxInstance = instances_[num];
				if (fxInstance.gameObject != null && Time.time > fxInstance.destroyMoment)
				{
					fxInstance.Dispose();
					instances_.RemoveAt(num);
				}
			}
		}
	}
}

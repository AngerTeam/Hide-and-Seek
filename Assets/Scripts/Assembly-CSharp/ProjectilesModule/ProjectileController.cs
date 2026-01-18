using System;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils;
using CraftyEngine.Utils.Unity;
using CraftyVoxelEngine;
using DG.Tweening;
using Extensions;
using FxModule;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectileController : IDisposable
	{
		public bool sync;

		public int clientProjectileId;

		public string targetPersId;

		private readonly UnityTimerManager timerManager_;

		private readonly ProjectileInstance projectileInstance_;

		private readonly ProjectileView view_;

		private TrajectoryMotionController trajectoryMotion_;

		public bool Finished { get; protected set; }

		public Vector3 Position
		{
			get
			{
				return view_.Position;
			}
		}

		public ProjectileView View
		{
			get
			{
				return view_;
			}
		}

		public event Action<GameObject, VoxelKey, string> CompleteAnimation;

		public event Action<Vector3> PendingExplosionHappened;

		public ProjectileController(GameObject container, FileHolder fileHolder)
		{
			PoolsManager singlton;
			SingletonManager.Get<PoolsManager>(out singlton);
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			ObjectPool<ProjectileInstance> pool = singlton.GetPool<ProjectileInstance>(fileHolder.fileGetter.Address, 10);
			int maxAmount = System.Math.Max(10, FxContentMap.FxSettings.projectileAmountMax);
			pool.SetMaxAmount(maxAmount);
			projectileInstance_ = pool.Get();
			projectileInstance_.pool = pool;
			pool.MarkUsed(projectileInstance_);
			if (projectileInstance_.moveTween != null)
			{
				projectileInstance_.moveTween.Kill();
			}
			if (projectileInstance_.timer != null)
			{
				projectileInstance_.timer.Stop();
			}
			view_ = new ProjectileView(container, projectileInstance_, fileHolder);
		}

		public virtual void Dispose()
		{
			projectileInstance_.pool.Release(projectileInstance_);
			if (projectileInstance_.gameObject != null)
			{
				projectileInstance_.gameObject.SetActive(false);
			}
			Finished = true;
		}

		public void Update()
		{
			if (trajectoryMotion_ != null)
			{
				trajectoryMotion_.Update();
			}
		}

		public void Send(Vector3? destination, Quaternion? rotation = null, VoxelKey? destKey = null, TweenCallback onCompleteHandler = null, Transform parent = null, TrajectoryChain trajectory = null, bool resetLayer = true)
		{
			if (projectileInstance_ == null || projectileInstance_.gameObject == null)
			{
				return;
			}
			Transform projectile = projectileInstance_.gameObject.transform;
			float num = 0.75f;
			projectile.SetParent(null, true);
			if (resetLayer)
			{
				GameObjectUtils.SetLayer(projectileInstance_.gameObject, 0);
			}
			float duration;
			Vector3 vector;
			if (trajectory != null)
			{
				duration = trajectory.EndTime - trajectory.StartTime + 1f;
				vector = projectile.position + projectile.forward * 50f;
			}
			else if (destination.HasValue)
			{
				projectileInstance_.pool.MarkFree(projectileInstance_);
				float num2 = Vector3.Distance(projectile.position, destination.Value);
				vector = destination.Value;
				float num3 = num2 / 50f;
				num *= num3;
				duration = num + FxContentMap.FxSettings.projectileDuration;
				if (rotation.HasValue)
				{
					projectile.rotation = rotation.Value;
				}
			}
			else
			{
				projectileInstance_.pool.MarkFree(projectileInstance_);
				duration = num;
				vector = projectile.position + projectile.forward * 50f;
			}
			VoxelKey globalKey = ((!destKey.HasValue) ? new VoxelKey(vector) : destKey.Value);
			projectileInstance_.parent = parent;
			projectileInstance_.timer = timerManager_.SetTimer(duration);
			projectileInstance_.timer.Completeted += delegate
			{
				Finished = true;
			};
			if (trajectory == null)
			{
				projectileInstance_.moveTween = DOTween.To(() => projectile.localPosition, delegate(Vector3 c)
				{
					projectile.localPosition = c;
				}, vector, num).SetEase(Ease.Linear).OnComplete(delegate
				{
					OnComplete(globalKey);
					if (onCompleteHandler != null)
					{
						onCompleteHandler();
					}
				});
				return;
			}
			trajectoryMotion_ = new TrajectoryMotionController(view_, trajectory);
			trajectoryMotion_.TimeOut += delegate
			{
				if (sync)
				{
					this.PendingExplosionHappened.SafeInvoke(projectileInstance_.gameObject.transform.position);
				}
			};
		}

		public void Explode()
		{
			view_.OnExplode();
			Finished = true;
		}

		private void OnComplete(VoxelKey destKey)
		{
			this.CompleteAnimation.SafeInvoke(projectileInstance_.gameObject, destKey, targetPersId);
			try
			{
				if (projectileInstance_.parent != null)
				{
					projectileInstance_.gameObject.transform.SetParent(projectileInstance_.parent, true);
					projectileInstance_.parent = null;
				}
			}
			catch
			{
			}
		}
	}
}

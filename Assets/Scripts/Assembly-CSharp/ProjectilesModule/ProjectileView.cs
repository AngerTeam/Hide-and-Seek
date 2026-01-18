using System;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using CraftyEngine.Utils.Unity;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectileView : IDisposable
	{
		private readonly GameObject container_;

		private readonly ProjectileInstance projectileInstance_;

		private Transform transform_;

		private string PROJECTILE_ACNHOR = "projectileAnchor";

		private string BULLET_ACNHOR = "bulletAnchor";

		public Vector3 Position
		{
			get
			{
				return (!(transform_ != null)) ? Vector3.zero : transform_.position;
			}
			set
			{
				if (transform_ != null)
				{
					transform_.position = value;
				}
			}
		}

		public FileHolder ExplosionFxFileHolder { get; set; }

		public ProjectileView(GameObject container, ProjectileInstance projectileInstance, FileHolder fileHolder)
		{
			ProjectileView projectileView = this;
			container_ = container;
			projectileInstance_ = projectileInstance;
			if (fileHolder == null)
			{
				return;
			}
			if (fileHolder.fileGetter.State == LoadState.Loaded)
			{
				LoadModel(fileHolder);
				return;
			}
			fileHolder.fileGetter.Completed += delegate
			{
				projectileView.LoadModel(fileHolder);
			};
		}

		public void Dispose()
		{
		}

		public void OnHit()
		{
		}

		public void OnStop()
		{
		}

		public void OnExplode()
		{
			if (ExplosionFxFileHolder == null)
			{
				return;
			}
			Vector3 explodePos = Position;
			SoundProvider.PlayGroupSound3D(explodePos, 45, 1f);
			QueueManager singlton;
			SingletonManager.Get<QueueManager>(out singlton);
			singlton.AddTask(ExplosionFxFileHolder.fileGetter);
			singlton.AddTask(delegate
			{
				GameObject instance;
				if (!RenderHierarchyUtils.TryInstansiate(ExplosionFxFileHolder.loadedAssetBundle, out instance))
				{
					instance = (GameObject)ExplosionFxFileHolder.Instantiate();
				}
				if (instance != null)
				{
					instance.transform.position = explodePos;
					instance.transform.localRotation = Quaternion.identity;
					UnityTimerManager singlton2;
					SingletonManager.Get<UnityTimerManager>(out singlton2);
					singlton2.SetTimer(2f).Completeted += delegate
					{
						if (instance != null)
						{
							UnityEngine.Object.Destroy(instance);
						}
					};
				}
			});
		}

		private void LoadModel(FileHolder fileHolder)
		{
			if (fileHolder.fileGetter.State != LoadState.Loaded)
			{
				Log.Error("Unable to create ProjectileInstance of bundle wich is not loaded");
			}
			else
			{
				if (!ActionDebugLocker.projectile)
				{
					return;
				}
				GameObject gameObject = GameObjectUtils.FindChild(container_, PROJECTILE_ACNHOR);
				if (gameObject == null)
				{
					gameObject = GameObjectUtils.FindChild(container_, BULLET_ACNHOR);
				}
				if (gameObject == null)
				{
					gameObject = GameObjectUtils.FindChild(container_, "arrow");
				}
				if (gameObject == null)
				{
					gameObject = container_;
				}
				if (!(gameObject == null))
				{
					if (projectileInstance_.gameObject == null && !RenderHierarchyUtils.TryInstansiate(fileHolder.loadedAssetBundle, out projectileInstance_.gameObject))
					{
						projectileInstance_.gameObject = (GameObject)fileHolder.Instantiate();
					}
					if (!(projectileInstance_.gameObject == null))
					{
						projectileInstance_.gameObject.SetActive(true);
						transform_ = projectileInstance_.gameObject.transform;
						transform_.SetParent(gameObject.transform, false);
						transform_.localScale = Vector3.one;
						transform_.localPosition = Vector3.zero;
						transform_.localRotation = Quaternion.identity;
					}
				}
			}
		}
	}
}

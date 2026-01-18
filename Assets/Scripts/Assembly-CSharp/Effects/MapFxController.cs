using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.Clouds;
using CraftyVoxelEngine.Content;

namespace Effects
{
	public class MapFxController : IDisposable
	{
		private SkyboxManager skyboxManager_;

		private AmbientSoundManager ambientSoundManager_;

		private CloudManager cloudManager_;

		private MapFxModel mapFxModel_;

		private FlareFxController flareFxController_;

		public MapFxController()
		{
			SingletonManager.Get<MapFxModel>(out mapFxModel_);
			SingletonManager.Get<FlareFxController>(out flareFxController_);
		}

		public static void InitModule(int layer)
		{
			SingletonManager.Add<MapFxModel>(layer);
			SingletonManager.Add<FlareFxController>(layer);
		}

		public void Dispose()
		{
			flareFxController_.Unload();
			if (skyboxManager_ != null)
			{
				skyboxManager_.Dispose();
				skyboxManager_ = null;
			}
			if (ambientSoundManager_ != null)
			{
				ambientSoundManager_.Dispose();
				ambientSoundManager_ = null;
			}
			if (cloudManager_ != null)
			{
				cloudManager_.Dispose();
				cloudManager_ = null;
			}
		}

		public void Load(int skyboxId, int ambientSoundId, bool useClouds)
		{
			mapFxModel_.ambientSoundId = ambientSoundId;
			mapFxModel_.skyboxId = skyboxId;
			skyboxManager_ = new SkyboxManager();
			skyboxManager_.Updatekybox();
			ambientSoundManager_ = new AmbientSoundManager();
			ambientSoundManager_.LoadAmbient();
			if (useClouds)
			{
				CameraManager cameraManager = SingletonManager.Get<CameraManager>();
				cloudManager_ = new CloudManager(layer: mapFxModel_.unityLayer, height: VoxelContentMap.VoxelSettings.cloudsHeight, player: cameraManager.Transform.gameObject);
			}
		}

		public void Start()
		{
			flareFxController_.Load();
		}
	}
}

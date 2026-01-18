using System;
using System.Collections.Generic;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Sounds;
using CraftyEngine.Utils.Unity;
using CraftyVoxelEngine;
using UnityEngine;

namespace Effects
{
	public class SkyboxManager : IDisposable
	{
		private CameraManager cameraManager_;

		private List<Transform> children_;

		private MapFxModel mapFxModel_;

		private GameObject skyboxObject_;

		private Vector3 skyboxPosition_;

		private UnityEvent unityEvent_;

		private VoxelEngine voxelEngine_;

		private VoxelLoader voxelLoader_;

		public SkyboxManager()
		{
			SingletonManager.Get<MapFxModel>(out mapFxModel_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<VoxelLoader>(out voxelLoader_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			children_ = new List<Transform>();
			mapFxModel_.SkyboxChanged += Updatekybox;
		}

		public void Dispose()
		{
			SoundProvider.StopAmbient();
			children_.Clear();
			if (skyboxObject_ != null)
			{
				UnityEngine.Object.Destroy(skyboxObject_);
			}
			mapFxModel_.SkyboxChanged -= Updatekybox;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		}

		public ProFlareBatch SetupFlareCamera()
		{
			PrefabsManager singlton;
			SingletonManager.Get<PrefabsManager>(out singlton);
			singlton.Load("MegaAtlas");
			GameObject gameObject = cameraManager_.PlayerCamera.gameObject;
			ProFlareBatch componentInChildren = gameObject.GetComponentInChildren<ProFlareBatch>();
			if (componentInChildren != null)
			{
				UnityEngine.Object.DestroyImmediate(componentInChildren.gameObject);
			}
			GameObject gameObject2 = new GameObject("ProFlareBatch");
			int layer = gameObject.layer;
			gameObject2.layer = layer;
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.localPosition = Vector3.zero;
			gameObject2.transform.localRotation = Quaternion.identity;
			gameObject2.transform.localScale = Vector3.one;
			componentInChildren = gameObject2.AddComponent<ProFlareBatch>();
			componentInChildren.debugMessages = false;
			componentInChildren.FlareCamera = cameraManager_.PlayerCamera;
			componentInChildren.FlareCameraTrans = cameraManager_.PlayerCamera.transform;
			componentInChildren.GameCamera = cameraManager_.PlayerCamera;
			componentInChildren.GameCameraTrans = cameraManager_.PlayerCamera.transform;
			componentInChildren.mode = ProFlareBatch.Mode.SingleCamera;
			componentInChildren.SingleCamera_Mode = true;
			componentInChildren.VR_Mode = false;
			componentInChildren.zPos = 1f;
			componentInChildren.Reset();
			componentInChildren._atlas = Resources.Load<GameObject>("MegaAtlas").GetComponentInChildren<ProFlareAtlas>();
			componentInChildren.mat.mainTexture = componentInChildren._atlas.texture;
			componentInChildren.ForceRefresh();
			return componentInChildren;
		}

		public void Updatekybox()
		{
			if (EffectsContentMap.Skybox == null)
			{
				Log.ContentError("EffectsContentMap not loaded");
				return;
			}
			SkyboxEntries skybox;
			if (!EffectsContentMap.Skybox.TryGetValue(mapFxModel_.skyboxId, out skybox))
			{
				using (Dictionary<int, SkyboxEntries>.ValueCollection.Enumerator enumerator = EffectsContentMap.Skybox.Values.GetEnumerator())
				{
					if (enumerator.MoveNext())
					{
						SkyboxEntries current = enumerator.Current;
						skybox = current;
					}
				}
			}
			if (skybox != null)
			{
				FilesManager.Current.AddLoadBundleTask(skybox.GetFullBundlePath(), delegate(FileHolder file)
				{
					ApplySkybox(file, skybox);
				});
			}
		}

		private void ApplySkybox(FileHolder skyboxHolder, SkyboxEntries skybox)
		{
			children_.Clear();
			if (skyboxObject_ != null)
			{
				UnityEngine.Object.Destroy(skyboxObject_);
			}
			if (mapFxModel_.CurrentFlare != null)
			{
				mapFxModel_.CurrentFlare = null;
			}
			if (!RenderHierarchyUtils.TryInstansiate(skyboxHolder.loadedAssetBundle, out skyboxObject_))
			{
				GameObject original = (GameObject)skyboxHolder.GetBundle();
				skyboxObject_ = UnityEngine.Object.Instantiate(original);
			}
			if (mapFxModel_.unityLayer > 0)
			{
				GameObjectUtils.SetLayerRecursive(skyboxObject_, mapFxModel_.unityLayer);
			}
			skyboxPosition_ = skyboxObject_.transform.position;
			for (int i = 0; i < skyboxObject_.transform.childCount; i++)
			{
				Transform child = skyboxObject_.transform.GetChild(i);
				ProFlare component = child.GetComponent<ProFlare>();
				if (component == null)
				{
					children_.Add(child);
				}
			}
			mapFxModel_.CurrentFlare = skyboxObject_.GetComponentInChildren<ProFlare>();
			Material material = skyboxObject_.GetComponent<MeshRenderer>().material;
			material.shader = Shader.Find(material.shader.name);
			RenderSettings.skybox = material;
			Color sky = ColorUtils.HexToColor(skybox.material_sky_color);
			Color ambient = ColorUtils.HexToColor(skybox.material_ambient_color);
			voxelEngine_.core.settings.SetPowerOfAO(skybox.ambient_occlusion_power);
			voxelLoader_.SetMaterialParameters(skybox.material_normal_power, sky, ambient);
			mapFxModel_.CurrentFlareBatch = SetupFlareCamera();
			if (mapFxModel_.CurrentFlare != null)
			{
				if (mapFxModel_.CurrentFlare._Atlas == null)
				{
					mapFxModel_.CurrentFlare._Atlas = mapFxModel_.CurrentFlareBatch._atlas;
				}
				mapFxModel_.CurrentFlareBatch.AddFlare(mapFxModel_.CurrentFlare);
			}
		}

		private void Update()
		{
			if (skyboxObject_ != null)
			{
				Vector3 position = cameraManager_.Transform.position;
				skyboxObject_.transform.position = skyboxPosition_ + position;
				for (int i = 0; i < children_.Count; i++)
				{
					children_[i].LookAt(position);
				}
			}
		}
	}
}

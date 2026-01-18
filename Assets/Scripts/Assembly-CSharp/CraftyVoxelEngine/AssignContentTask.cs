using System.Text;
using System.Threading;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.Content;
using CraftyVoxelEngine.FX;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class AssignContentTask : AsynchronousTask
	{
		private VoxelEngine engine_;

		private VoxelLoader loader_;

		private FXManager fxManager_;

		private PrefabsManager prefabsManager_;

		public override void Start()
		{
			SingletonManager.Get<VoxelLoader>(out loader_);
			SingletonManager.Get<VoxelEngine>(out engine_);
			SingletonManager.Get<FXManager>(out fxManager_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			string logicRegionSize = VoxelContentMap.VoxelSettings.LogicRegionSize;
			VoxelKey spawnProtectionRegion = VoxelKey.SafeParse(logicRegionSize);
			engine_.Settings.SetSpawnProtectionRegion(spawnProtectionRegion);
			engine_.Settings.SetSeparatetransparent(true);
			Vector2 atlassSize = default(Vector2);
			float num = VoxelContentMap.VoxelSettings.tileSize;
			atlassSize.x = (float)loader_.Atlas.width / num;
			atlassSize.y = (float)loader_.Atlas.width / num;
			engine_.Settings.SetAtlassSize(atlassSize);
			AssignVoxelMaterials();
			engine_.voxelEvents.VoxelDataReady += AssignModelsSafe;
			engine_.core.SetVoxelData(loader_.ContentRawAmf, loader_.AtlasRawJson);
		}

		private void AssignVoxelMaterials()
		{
			GameObject prefab = prefabsManager_.GetPrefab("VoxelMaterialHolder");
			Material[] sharedMaterials = prefab.GetComponent<Renderer>().sharedMaterials;
			Material material = new Material(sharedMaterials[0]);
			Material material2 = new Material(sharedMaterials[1]);
			Material material3 = new Material(sharedMaterials[5]);
			int num = 16;
			if (loader_.AtlasJson2 != null)
			{
				num = loader_.AtlasJson2.tilesXCount;
				float num2 = loader_.Atlas.width;
				int num3 = num * (VoxelContentMap.VoxelSettings.tileSize + loader_.AtlasJson2.padding);
				float num4 = num2 - (float)num3;
				float num5 = 1f - num4 / num2;
				material3.mainTextureScale = new Vector2(num5, num5);
				ParticleHolder.tilesRate = num5;
				ParticleHolder.tilesOffset = (float)(-loader_.AtlasJson2.padding) / 2f / num2;
			}
			else if (loader_.Atlas.width == 1024)
			{
				num = 32;
			}
			ParticleHolder.SetTileSize(num, num);
			fxManager_.InitParticleMaterial(material3);
			material.mainTexture = loader_.Atlas;
			material2.mainTexture = loader_.Atlas;
			Color sky = ColorUtils.HexToColor(VoxelContentMap.VoxelSettings.materialSkyColor);
			Color ambient = ColorUtils.HexToColor(VoxelContentMap.VoxelSettings.materialAmbientColor);
			loader_.solidMaterial = material;
			loader_.transMaterial = material2;
			loader_.SetMaterialParameters(VoxelContentMap.VoxelSettings.materialNormalPower, sky, ambient);
			engine_.ViewManager.solidMaterial = material;
			engine_.ViewManager.transMaterial = material2;
			VoxelControllerManager singleton;
			if (SingletonManager.TryGet<VoxelControllerManager>(out singleton))
			{
				singleton.SetCracksMaterial(new Material(sharedMaterials[3]));
			}
		}

		private void AssignModels()
		{
			if (loader_.Models != null)
			{
				for (int i = 0; i < loader_.Models.Count; i++)
				{
					VoxelModelHolder voxelModelHolder = loader_.Models[i];
					byte[] bytes = Encoding.UTF8.GetBytes(voxelModelHolder.holder.loadedText);
					bool splitBySides = (voxelModelHolder.Entry.flags & 1) != 0;
					engine_.Settings.AddMesh(bytes, bytes.Length, voxelModelHolder.id, splitBySides);
				}
			}
			UnityEvent unityEvent = SingletonManager.Get<UnityEvent>();
			unityEvent.Subscribe(UnityEventType.Update, base.Complete, true);
		}

		private void AssignModelsSafe(MessageVoxelDataReady args)
		{
			engine_.voxelEvents.VoxelDataReady -= AssignModelsSafe;
			Thread thread = new Thread(AssignModels);
			thread.Start();
		}
	}
}

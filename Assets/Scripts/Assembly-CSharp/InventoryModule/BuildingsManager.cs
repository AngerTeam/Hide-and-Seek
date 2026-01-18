using System.Collections.Generic;
using CraftyVoxelEngine;
using InventoryViewModule;
using WindowsModule;

namespace InventoryModule
{
	public class BuildingsManager : Singleton
	{
		public Dictionary<VoxelKey, BuildingModel> buildings;

		private CraftManager craftManager_;

		public override void Init()
		{
			SingletonManager.Get<CraftManager>(out craftManager_);
			buildings = new Dictionary<VoxelKey, BuildingModel>();
		}

		public void OpenBuilding(VoxelKey globalKey)
		{
			BuildingModel value;
			if (buildings.TryGetValue(globalKey, out value))
			{
				if (value.BuildingType == 1)
				{
					craftManager_.SetBuilding(value.RefId, value);
					WindowsManagerShortcut.ToggleWindow<CraftWindow>();
					craftManager_.CallBuildingChanged();
				}
			}
			else
			{
				Log.Info(string.Format("No building {0} found", globalKey.ToString()));
			}
		}

		public void AddBuilding(int buildingType, VoxelKey globalKey)
		{
			BuildingModel value = new BuildingModel(GenerateBuildingRefId(globalKey), buildingType, globalKey);
			buildings[globalKey] = value;
		}

		public void RemoveBuilding(int buildingType, VoxelKey globalKey)
		{
			if (buildings.ContainsKey(globalKey))
			{
				buildings.Remove(globalKey);
			}
			else
			{
				Log.Warning(string.Format("No building {0} to remove", globalKey.ToString()));
			}
		}

		private string GenerateBuildingRefId(VoxelKey globalKey)
		{
			return string.Format("{0}_{1}_{2}", globalKey.x, globalKey.y, globalKey.z);
		}
	}
}

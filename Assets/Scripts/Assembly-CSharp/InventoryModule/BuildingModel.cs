using CraftyVoxelEngine;

namespace InventoryModule
{
	public class BuildingModel
	{
		public int BuildingType { get; private set; }

		public VoxelKey GlobalKey { get; private set; }

		public string RefId { get; private set; }

		public BuildingModel(string refId, int buildingType, VoxelKey globalKey)
		{
			RefId = refId;
			BuildingType = buildingType;
			GlobalKey = globalKey;
		}
	}
}

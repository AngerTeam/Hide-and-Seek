using System;

namespace CraftyVoxelEngine
{
	public class InteractiveVoxelArgs : EventArgs
	{
		public int BuildingType { get; private set; }

		public VoxelKey GlobalKey { get; private set; }

		public InteractiveVoxelArgs(int buildingType, VoxelKey globalKey)
		{
			BuildingType = buildingType;
			GlobalKey = globalKey;
		}
	}
}

using System;

namespace CraftyVoxelEngine
{
	[Serializable]
	public class VoxelAtlasMetaData
	{
		public VoxelAtlasTileMetaData[] tiles;

		public int padding;

		public int tilesXCount;

		public int tilesYCount;
	}
}

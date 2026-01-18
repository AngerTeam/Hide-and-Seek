namespace CraftyVoxelEngine
{
	public struct RegionEventArgs
	{
		public VoxelRegion region;

		public RegionEventArgs(VoxelRegion reg)
		{
			region = reg;
		}
	}
}

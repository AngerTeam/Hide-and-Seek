namespace HideAndSeek
{
	public class HideVoxelData
	{
		public HideVoxelsEntries entry;

		public int count;

		public int index;

		public int voxelId;

		public HideVoxelData(HideVoxelsEntries entry, int index)
		{
			this.entry = entry;
			this.index = index;
			voxelId = entry.voxel_id;
		}
	}
}

namespace CraftyVoxelEngine
{
	public class VoxelEventArgs
	{
		public bool allowLootSpawn;

		public int Sequence { get; private set; }

		public ushort ArticulId { get; private set; }

		public byte Rotation { get; private set; }

		public ushort PreviousValue { get; private set; }

		public ushort CurrentValue { get; private set; }

		public VoxelKey GlobalKey { get; private set; }

		public VoxelEventArgs(VoxelKey globalKey, ushort currentValue, ushort previousValue, byte rotation = 0, ushort articulId = 0)
		{
			allowLootSpawn = true;
			Sequence = 0;
			ArticulId = articulId;
			Rotation = rotation;
			CurrentValue = currentValue;
			GlobalKey = globalKey;
			PreviousValue = previousValue;
		}

		public VoxelEventArgs(int sequence, VoxelKey globalKey, ushort currentValue, ushort previousValue, byte rotation = 0, ushort articulId = 0)
		{
			Sequence = sequence;
			ArticulId = articulId;
			Rotation = rotation;
			CurrentValue = currentValue;
			GlobalKey = globalKey;
			PreviousValue = previousValue;
			allowLootSpawn = true;
		}

		internal void Invalidate()
		{
			GlobalKey = VoxelKey.zero;
			PreviousValue = 0;
		}
	}
}

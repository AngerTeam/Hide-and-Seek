using System;

namespace CraftyVoxelEngine
{
	public class MessageChunkChanged : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public VoxelKey chunkKey;

		public int chunkState;

		public IntPtr solidHolder;

		public IntPtr transHolder;

		public MessageChunkChanged()
		{
			MESSAGE_ID = 5014;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			chunkKey = buffer.ReadVoxelKey();
			chunkState = buffer.ReadInt();
			solidHolder = new IntPtr(buffer.ReadLong());
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteVoxelKey(chunkKey);
			buffer.WriteInt(chunkState);
			buffer.WriteLong(solidHolder.ToInt64());
			buffer.WriteLong(transHolder.ToInt64());
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} chunkKey: {3} chunkState: {4} solidHolder: {5} transHolder: {6}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, chunkKey, chunkState, solidHolder, transHolder);
		}
	}
}

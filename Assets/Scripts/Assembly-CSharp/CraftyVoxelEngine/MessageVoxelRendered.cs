using System;

namespace CraftyVoxelEngine
{
	public class MessageVoxelRendered : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public IntPtr meshHolder;

		public MessageVoxelRendered()
		{
			MESSAGE_ID = 5007;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			meshHolder = new IntPtr(buffer.ReadLong());
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteLong(meshHolder.ToInt64());
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} meshHolder: {3}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, meshHolder);
		}
	}
}

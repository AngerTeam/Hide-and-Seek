namespace CraftyVoxelEngine
{
	public class MessageInteractiveVoxelChanged : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public VoxelKey globalKey;

		public ushort oldValue;

		public ushort newValue;

		public MessageInteractiveVoxelChanged()
		{
			MESSAGE_ID = 5012;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			globalKey = buffer.ReadVoxelKey();
			oldValue = buffer.ReadUshort();
			newValue = buffer.ReadUshort();
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteVoxelKey(globalKey);
			buffer.WriteUshort(oldValue);
			buffer.WriteUshort(newValue);
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} globalKey: {3} oldValue: {4} newValue: {5}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, globalKey, oldValue, newValue);
		}
	}
}

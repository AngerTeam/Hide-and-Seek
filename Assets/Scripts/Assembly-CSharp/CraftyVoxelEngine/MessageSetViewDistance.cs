namespace CraftyVoxelEngine
{
	public class MessageSetViewDistance : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public float rendDistance;

		public float viewDistance;

		public MessageSetViewDistance()
		{
			MESSAGE_ID = 5004;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			rendDistance = buffer.ReadFloat();
			viewDistance = buffer.ReadFloat();
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteFloat(rendDistance);
			buffer.WriteFloat(viewDistance);
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} rendDistance: {3} viewDistance: {4}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, rendDistance, viewDistance);
		}
	}
}

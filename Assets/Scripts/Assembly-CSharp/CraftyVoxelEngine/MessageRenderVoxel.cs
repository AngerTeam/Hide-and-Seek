namespace CraftyVoxelEngine
{
	public class MessageRenderVoxel : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public int voxelID;

		public bool textureScale;

		public MessageRenderVoxel()
		{
			MESSAGE_ID = 5006;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			voxelID = buffer.ReadInt();
			textureScale = buffer.ReadBool();
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteInt(voxelID);
			buffer.WriteBool(textureScale);
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} voxelID: {3} textureScale: {4}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, voxelID, textureScale);
		}
	}
}

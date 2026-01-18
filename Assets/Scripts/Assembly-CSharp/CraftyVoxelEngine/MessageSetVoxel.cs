using UnityEngine;

namespace CraftyVoxelEngine
{
	public class MessageSetVoxel : DataSerializable
	{
		public int MESSAGE_ID;

		public int MESSAGE_SEQ;

		public int MESSAGE_STATUS;

		public VoxelKey globalKey;

		public ushort value;

		public byte rotation;

		public bool useHit;

		public Vector3 point;

		public byte side;

		public bool isPlayer;

		public MessageSetVoxel()
		{
			MESSAGE_ID = 5002;
			MESSAGE_SEQ = 0;
			MESSAGE_STATUS = 0;
		}

		public override void Deserialize(DataBuffer buffer)
		{
			MESSAGE_ID = buffer.ReadInt();
			MESSAGE_SEQ = buffer.ReadInt();
			MESSAGE_STATUS = buffer.ReadInt();
			globalKey = buffer.ReadVoxelKey();
			value = buffer.ReadUshort();
			rotation = buffer.ReadByte();
			useHit = buffer.ReadBool();
			point = buffer.ReadVector3();
			side = buffer.ReadByte();
			isPlayer = buffer.ReadBool();
		}

		public override void Serialize(DataBuffer buffer)
		{
			buffer.WriteInt(MESSAGE_ID);
			buffer.WriteInt(MESSAGE_SEQ);
			buffer.WriteInt(MESSAGE_STATUS);
			buffer.WriteVoxelKey(globalKey);
			buffer.WriteUshort(value);
			buffer.WriteByte(rotation);
			buffer.WriteBool(useHit);
			buffer.WriteVector3(point);
			buffer.WriteByte(side);
			buffer.WriteBool(isPlayer);
		}

		public override string ToString()
		{
			return string.Format("MESSAGE_ID: {0} MESSAGE_SEQ: {1} MESSAGE_STATUS: {2} globalKey: {3} value: {4} rotation: {5} useHit: {6} point: {7} side: {8} isPlayer: {9}", MESSAGE_ID, MESSAGE_SEQ, MESSAGE_STATUS, globalKey, value, rotation, useHit, point, side, isPlayer);
		}
	}
}

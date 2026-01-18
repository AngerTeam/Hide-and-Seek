using System;
using System.Text;
using CraftyEngine;
using CraftyVoxelEngine;
using UnityEngine;

public class DataBuffer
{
	private int offset_;

	public byte[] buffer_;

	public int length
	{
		get
		{
			return (buffer != null) ? buffer.Length : 0;
		}
		set
		{
			offset_ = ((buffer != null) ? Mathf.Min(buffer.Length, value) : 0);
		}
	}

	public byte[] buffer
	{
		get
		{
			return buffer_;
		}
	}

	public DataBuffer(int len)
	{
		Rescale(len);
	}

	public string Dump(string prefix = null)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (string.IsNullOrEmpty(prefix))
		{
			stringBuilder.Append("Buffer:");
		}
		else
		{
			stringBuilder.Append(string.Format("[{0}] Buffer:", prefix));
		}
		for (int i = 0; i < offset_; i++)
		{
			stringBuilder.AppendFormat(" {0:x2}", (int)buffer_[i]);
		}
		stringBuilder.AppendLine();
		return stringBuilder.ToString();
	}

	public void Reset()
	{
		offset_ = 0;
	}

	public void Rescale(int len)
	{
		offset_ = 0;
		buffer_ = new byte[len];
	}

	public static byte[] StringToBytes(string value)
	{
		return Encoding.UTF8.GetBytes(value);
	}

	public static string BytesToString(byte[] value)
	{
		return Encoding.UTF8.GetString(value, 0, value.Length);
	}

	protected byte[] ReadBytes(int len)
	{
		byte[] array = new byte[len];
		Array.Copy(buffer_, offset_, array, 0, len);
		offset_ += len;
		return array;
	}

	public bool ReadBool()
	{
		bool result = buffer_[offset_] != 0;
		offset_++;
		return result;
	}

	public byte ReadByte()
	{
		byte result = buffer_[offset_];
		offset_++;
		return result;
	}

	public short ReadShort()
	{
		short result = BitConverter.ToInt16(buffer_, offset_);
		offset_ += 2;
		return result;
	}

	public ushort ReadUshort()
	{
		ushort result = BitConverter.ToUInt16(buffer_, offset_);
		offset_ += 2;
		return result;
	}

	public int ReadInt()
	{
		int result = BitConverter.ToInt32(buffer_, offset_);
		offset_ += 4;
		return result;
	}

	public uint ReadUint()
	{
		uint result = BitConverter.ToUInt32(buffer_, offset_);
		offset_ += 4;
		return result;
	}

	public long ReadLong()
	{
		long result = BitConverter.ToInt64(buffer_, offset_);
		offset_ += 8;
		return result;
	}

	public ulong ReadUlong()
	{
		ulong result = BitConverter.ToUInt64(buffer_, offset_);
		offset_ += 8;
		return result;
	}

	public float ReadFloat()
	{
		float result = BitConverter.ToSingle(buffer_, offset_);
		offset_ += 4;
		return result;
	}

	protected void WriteBytes(byte[] data)
	{
		Array.Copy(data, 0, buffer_, offset_, data.Length);
		offset_ += data.Length;
	}

	public void WriteBool(bool value)
	{
		buffer_[offset_] = (byte)(value ? 1u : 0u);
		offset_++;
	}

	public void WriteByte(byte value)
	{
		buffer_[offset_] = value;
		offset_++;
	}

	public void WriteShort(short value)
	{
		MemoryMapper.map.shortValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		offset_ += 2;
	}

	public void WriteUshort(ushort value)
	{
		MemoryMapper.map.uShortValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		offset_ += 2;
	}

	public void WriteInt(int value)
	{
		MemoryMapper.map.intValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		buffer_[offset_ + 2] = MemoryMapper.map.byteValue2;
		buffer_[offset_ + 3] = MemoryMapper.map.byteValue3;
		offset_ += 4;
	}

	public void WriteUint(uint value)
	{
		MemoryMapper.map.uIntValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		buffer_[offset_ + 2] = MemoryMapper.map.byteValue2;
		buffer_[offset_ + 3] = MemoryMapper.map.byteValue3;
		offset_ += 4;
	}

	public void WriteLong(long value)
	{
		MemoryMapper.map.longValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		buffer_[offset_ + 2] = MemoryMapper.map.byteValue2;
		buffer_[offset_ + 3] = MemoryMapper.map.byteValue3;
		buffer_[offset_ + 4] = MemoryMapper.map.byteValue4;
		buffer_[offset_ + 5] = MemoryMapper.map.byteValue5;
		buffer_[offset_ + 6] = MemoryMapper.map.byteValue6;
		buffer_[offset_ + 7] = MemoryMapper.map.byteValue7;
		offset_ += 8;
	}

	public void WriteUlong(ulong value)
	{
		MemoryMapper.map.uLongValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		buffer_[offset_ + 2] = MemoryMapper.map.byteValue2;
		buffer_[offset_ + 3] = MemoryMapper.map.byteValue3;
		buffer_[offset_ + 4] = MemoryMapper.map.byteValue4;
		buffer_[offset_ + 5] = MemoryMapper.map.byteValue5;
		buffer_[offset_ + 6] = MemoryMapper.map.byteValue6;
		buffer_[offset_ + 7] = MemoryMapper.map.byteValue7;
		offset_ += 8;
	}

	public void WriteFloat(float value)
	{
		MemoryMapper.map.floatValue = value;
		buffer_[offset_] = MemoryMapper.map.byteValue0;
		buffer_[offset_ + 1] = MemoryMapper.map.byteValue1;
		buffer_[offset_ + 2] = MemoryMapper.map.byteValue2;
		buffer_[offset_ + 3] = MemoryMapper.map.byteValue3;
		offset_ += 4;
	}

	public string ReadString()
	{
		int len = ReadInt();
		byte[] value = ReadBytes(len);
		return BytesToString(value);
	}

	public Vector2 ReadVector2()
	{
		Vector2 result = default(Vector2);
		result.x = ReadFloat();
		result.y = ReadFloat();
		return result;
	}

	public Vector3 ReadVector3()
	{
		Vector3 result = default(Vector3);
		result.x = ReadFloat();
		result.y = ReadFloat();
		result.z = ReadFloat();
		return result;
	}

	public VoxelKey ReadVoxelKey()
	{
		VoxelKey result = default(VoxelKey);
		result.x = ReadInt();
		result.y = ReadInt();
		result.z = ReadInt();
		return result;
	}

	public Color32 ReadColor32()
	{
		Color32 result = new Color32(buffer_[offset_], buffer_[offset_ + 1], buffer_[offset_ + 2], buffer_[offset_ + 3]);
		offset_ += 4;
		return result;
	}

	public void WriteString(string value)
	{
		byte[] array = StringToBytes(value);
		WriteInt(array.Length);
		WriteBytes(array);
	}

	public void WriteVector2(Vector2 value)
	{
		WriteFloat(value.x);
		WriteFloat(value.y);
	}

	public void WriteVector3(Vector3 value)
	{
		WriteFloat(value.x);
		WriteFloat(value.y);
		WriteFloat(value.z);
	}

	public void WriteVoxelKey(VoxelKey value)
	{
		WriteInt(value.x);
		WriteInt(value.y);
		WriteInt(value.z);
	}

	public void WtiteColor32(Color32 color)
	{
		buffer_[offset_] = color.r;
		buffer_[offset_ + 1] = color.g;
		buffer_[offset_ + 2] = color.b;
		buffer_[offset_ + 3] = color.a;
		offset_ += 4;
	}

	public T[] ReadArray<T>() where T : DataSerializable
	{
		int num = ReadInt();
		T[] array = new T[num];
		for (int i = 0; i < num; i++)
		{
			array[i].Deserialize(this);
		}
		return array;
	}

	public void WriteArray<T>(T[] value) where T : DataSerializable
	{
		WriteInt(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			value[i].Serialize(this);
		}
	}
}

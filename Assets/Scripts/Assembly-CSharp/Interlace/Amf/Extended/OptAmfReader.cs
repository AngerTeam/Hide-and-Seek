using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Xml;

namespace Interlace.Amf.Extended
{
	public class OptAmfReader : IDisposable
	{
		private class MemoryBox
		{
			public byte[] buffer;

			public MemoryStream stream;

			public MemoryBox()
			{
				buffer = new byte[streamBufferSize];
				stream = new MemoryStream(buffer);
			}

			public void FillBuffer(byte[] data)
			{
				int num = data.Length;
				int num2 = buffer.Length;
				if (num2 < num)
				{
					while (num2 < num)
					{
						num2 *= 2;
					}
					Log.Temp("Expand stream buffer to " + num2);
					buffer = new byte[num2];
					stream = new MemoryStream(buffer);
				}
				Array.Copy(data, 0, buffer, 0, data.Length);
				stream.Seek(0L, SeekOrigin.Begin);
			}
		}

		private sealed class ByteArrayBuffer
		{
			public byte[] buffer;

			private static ObjectPool<ByteArrayBuffer> _pool = new ObjectPool<ByteArrayBuffer>();

			public static ByteArrayBuffer Get()
			{
				return _pool.Get();
			}

			public static void Release(ByteArrayBuffer buffer)
			{
				_pool.Release(buffer);
			}
		}

		public static Encoding EncUTF8;

		public static int streamBufferSize;

		private static ThreadObjectPool<MemoryBox> stremPool_;

		private static Dictionary<MemoryStream, MemoryBox> memoryBoxs_;

		private ByteArrayBuffer _buffer;

		private BinaryReader _reader;

		private List<string> _stringTable;

		private List<object> _objectTable;

		private List<AmfTraits> _traitsTable;

		private static readonly DateTime _amfEpoch;

		public OptAmfReader(BinaryReader reader, AmfRegistry registry)
		{
			_reader = reader;
			_buffer = ByteArrayBuffer.Get();
			_stringTable = new List<string>();
			_objectTable = new List<object>();
			_traitsTable = new List<AmfTraits>();
		}

		static OptAmfReader()
		{
			EncUTF8 = Encoding.UTF8;
			streamBufferSize = 131072;
			_amfEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
			stremPool_ = new ThreadObjectPool<MemoryBox>();
			memoryBoxs_ = new Dictionary<MemoryStream, MemoryBox>();
		}

		public static void Clear()
		{
			stremPool_.Dispose();
			stremPool_ = new ThreadObjectPool<MemoryBox>();
			memoryBoxs_.Clear();
		}

		private byte[] GetBuffer(int length)
		{
			if (_buffer.buffer == null || _buffer.buffer.Length < length)
			{
				int num;
				for (num = 2; num < length; num *= 2)
				{
				}
				_buffer.buffer = new byte[num];
			}
			return _buffer.buffer;
		}

		public static MemoryStream GetMemoryStream(byte[] encodedBytes)
		{
			MemoryBox memoryBox = stremPool_.Get();
			memoryBox.FillBuffer(encodedBytes);
			memoryBoxs_.Add(memoryBox.stream, memoryBox);
			return memoryBox.stream;
		}

		public static void ReleaseMemoryStream(MemoryStream stream)
		{
			MemoryBox value;
			if (memoryBoxs_.TryGetValue(stream, out value))
			{
				memoryBoxs_.Remove(stream);
				stremPool_.Release(value);
			}
		}

		private void ResetTables()
		{
			_stringTable.Clear();
			_objectTable.Clear();
			_traitsTable.Clear();
		}

		public void Dispose()
		{
			ByteArrayBuffer.Release(_buffer);
			_buffer = null;
			if (_reader != null)
			{
				_reader = null;
			}
			ResetTables();
		}

		public static object Read(AmfRegistry registry, byte[] encodedBytes)
		{
			MemoryStream memoryStream = GetMemoryStream(encodedBytes);
			object result = Read(registry, memoryStream);
			ReleaseMemoryStream(memoryStream);
			return result;
		}

		public static object Read(AmfRegistry registry, Stream stream)
		{
			using (OptAmfReader optAmfReader = new OptAmfReader(new BinaryReader(stream), registry))
			{
				return optAmfReader.Read();
			}
		}

		public object Read()
		{
			switch (_reader.ReadByte())
			{
			case 0:
				throw new NotImplementedException();
			case 1:
				return null;
			case 2:
				return false;
			case 3:
				return true;
			case 4:
				return PackedInt.Read(_reader);
			case 5:
				return ReadNetworkDouble();
			case 6:
				return ReadString();
			case 7:
				throw new NotImplementedException();
			case 8:
				return ReadDate();
			case 9:
				return ReadArray();
			case 10:
				return ReadObject();
			case 11:
				return ReadXml();
			case 12:
				return ReadByteArray();
			default:
				throw new NotImplementedException();
			}
		}

		private bool ReadFlaggedInteger(out int value)
		{
			int num = PackedInt.Read(_reader);
			value = num >> 1;
			return (num & 1) == 1;
		}

		private double ReadNetworkDouble()
		{
			return OptConverter.Int64BitsToDouble(IPAddress.NetworkToHostOrder(_reader.ReadInt64()));
		}

		private string ReadString()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				int num = value;
				byte[] buffer = GetBuffer(num);
				int num2 = _reader.Read(buffer, 0, num);
				if (num2 < num)
				{
					throw new EndOfStreamException();
				}
				string value2;
				if (!OptAmfVoxelDiffs.CheckString(buffer, num, out value2))
				{
					value2 = EncUTF8.GetString(buffer, 0, num);
				}
				if (!string.IsNullOrEmpty(value2))
				{
					_stringTable.Add(value2);
				}
				return value2;
			}
			return _stringTable[value];
		}

		private DateTime ReadDate()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				double value2 = ReadNetworkDouble();
				DateTime dateTime = _amfEpoch + TimeSpan.FromMilliseconds(value2);
				_objectTable.Add(dateTime);
				return dateTime;
			}
			return (DateTime)_objectTable[value];
		}

		private void ReadPropertyList(IDictionary<string, object> dictionary)
		{
			while (true)
			{
				string text = ReadString();
				if (text == string.Empty)
				{
					break;
				}
				object value = Read();
				dictionary[text] = value;
			}
		}

		private AmfArray ReadArray()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				AmfArray amfArray = new OptAmfArray();
				_objectTable.Add(amfArray);
				ReadPropertyList(amfArray.AssociativeElements);
				for (int i = 0; i < value; i++)
				{
					object item = Read();
					amfArray.DenseElements.Add(item);
				}
				return amfArray;
			}
			return (AmfArray)_objectTable[value];
		}

		private AmfTraits ReadObjectTraits(int argument)
		{
			bool flag = (argument & 1) == 1;
			int num = argument >> 1;
			if (flag)
			{
				string className = ReadString();
				bool flag2 = (num & 1) == 1;
				int num2 = num >> 1;
				AmfTraits amfTraits;
				if (flag2)
				{
					amfTraits = new AmfTraits(className, AmfTraitsKind.Externalizable, new string[0]);
				}
				else
				{
					bool flag3 = (num2 & 1) == 1;
					int num3 = num2 >> 1;
					string[] array = new string[num3];
					for (int i = 0; i < num3; i++)
					{
						array[i] = ReadString();
					}
					amfTraits = new AmfTraits(className, flag3 ? AmfTraitsKind.Dynamic : AmfTraitsKind.Static, array);
				}
				_traitsTable.Add(amfTraits);
				return amfTraits;
			}
			return _traitsTable[num];
		}

		private object ReadObject()
		{
			AmfTraits amfTraits = null;
			OptAmfObject optAmfObject = null;
			try
			{
				int value;
				if (ReadFlaggedInteger(out value))
				{
					amfTraits = ReadObjectTraits(value);
					if (amfTraits.Kind == AmfTraitsKind.Externalizable)
					{
						throw new NotImplementedException();
					}
					optAmfObject = new OptAmfObject();
					_objectTable.Add(optAmfObject);
					string[] memberNames = amfTraits.MemberNames;
					for (int i = 0; i < memberNames.Length; i++)
					{
						object value2 = Read();
						optAmfObject.Properties[memberNames[i]] = value2;
					}
					if (amfTraits.Kind == AmfTraitsKind.Dynamic)
					{
						while (true)
						{
							string text = ReadString();
							if (text == string.Empty)
							{
								break;
							}
							object value3 = Read();
							optAmfObject.Properties[text] = value3;
						}
					}
					return optAmfObject;
				}
				return _objectTable[value];
			}
			catch (Exception ex)
			{
				if (_objectTable == null)
				{
					Log.Error("OptAmfReader::ReadObject::_objectTable = null");
				}
				else if (amfTraits == null)
				{
					Log.Error("OptAmfReader::ReadObject::traits = null");
				}
				else if (optAmfObject == null)
				{
					Log.Error("OptAmfReader::ReadObject::newObject = null");
				}
				throw ex;
			}
		}

		private XmlDocument ReadXml()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				int num = value;
				byte[] buffer = GetBuffer(num);
				int num2 = _reader.Read(buffer, 0, num);
				if (num2 < num)
				{
					throw new EndOfStreamException();
				}
				string @string = EncUTF8.GetString(buffer, 0, num);
				XmlDocument xmlDocument = new XmlDocument();
				xmlDocument.XmlResolver = null;
				xmlDocument.LoadXml(@string);
				_objectTable.Add(xmlDocument);
				return xmlDocument;
			}
			return (XmlDocument)_objectTable[value];
		}

		private byte[] ReadByteArray()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				byte[] array = _reader.ReadBytes(value);
				if (array.Length < value)
				{
					throw new EndOfStreamException();
				}
				_objectTable.Add(array);
				return array;
			}
			return (byte[])_objectTable[value];
		}
	}
}

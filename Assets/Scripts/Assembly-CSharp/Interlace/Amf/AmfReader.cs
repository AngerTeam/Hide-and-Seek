using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Xml;

namespace Interlace.Amf
{
	public class AmfReader : IDisposable
	{
		private BinaryReader _reader;

		private AmfRegistry _registry;

		private List<string> _stringTable;

		private List<object> _objectTable;

		private List<AmfTraits> _traitsTable;

		private static readonly DateTime _amfEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

		public AmfReader(BinaryReader reader, AmfRegistry registry)
		{
			_reader = reader;
			_registry = registry;
			_stringTable = new List<string>();
			_objectTable = new List<object>();
			_traitsTable = new List<AmfTraits>();
		}

		public static object Read(AmfRegistry registry, byte[] encodedBytes)
		{
			using (MemoryStream stream = new MemoryStream(encodedBytes))
			{
				return Read(registry, stream);
			}
		}

		public static object Read(AmfRegistry registry, Stream stream)
		{
			using (AmfReader amfReader = new AmfReaderWithMap(new BinaryReader(stream), registry))
			{
				return amfReader.Read();
			}
		}

		private void ResetTables()
		{
			_stringTable.Clear();
			_objectTable.Clear();
			_traitsTable.Clear();
		}

		private double ReadNetworkDouble()
		{
			return BitConverter.Int64BitsToDouble(IPAddress.NetworkToHostOrder(_reader.ReadInt64()));
		}

		private int ReadPackedInteger()
		{
			int num = 0;
			byte b = _reader.ReadByte();
			num = 0x7F & b;
			if ((b & 0x80) == 0)
			{
				return num;
			}
			byte b2 = _reader.ReadByte();
			num = (num << 7) | (0x7F & b2);
			if ((b2 & 0x80) == 0)
			{
				return num;
			}
			byte b3 = _reader.ReadByte();
			num = (num << 7) | (0x7F & b3);
			if ((b3 & 0x80) == 0)
			{
				return num;
			}
			byte b4 = _reader.ReadByte();
			return (num << 8) | b4;
		}

		private bool ReadFlaggedInteger(out int value)
		{
			int num = ReadPackedInteger();
			value = num >> 1;
			return (num & 1) == 1;
		}

		private bool ReadFlaggedInteger()
		{
			int num = ReadPackedInteger();
			return (num & 1) == 1;
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
				return ReadPackedInteger();
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

		private string ReadString()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				byte[] array = _reader.ReadBytes(value);
				if (array.Length < value)
				{
					throw new EndOfStreamException();
				}
				string @string = Encoding.UTF8.GetString(array);
				CheckString(@string, array);
				if (@string != string.Empty)
				{
					_stringTable.Add(@string);
				}
				return @string;
			}
			return _stringTable[value];
		}

		protected virtual void CheckString(string value, byte[] data)
		{
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

		private Dictionary<string, object> ReadPropertyList()
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
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
			return dictionary;
		}

		private AmfArray ReadArray()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				AmfArray amfArray = new AmfArray();
				_objectTable.Add(amfArray);
				Dictionary<string, object> dictionary = ReadPropertyList();
				List<object> list = new List<object>();
				for (int i = 0; i < value; i++)
				{
					object item = Read();
					list.Add(item);
				}
				foreach (KeyValuePair<string, object> item2 in dictionary)
				{
					amfArray.AssociativeElements.Add(item2);
				}
				{
					foreach (object item3 in list)
					{
						amfArray.DenseElements.Add(item3);
					}
					return amfArray;
				}
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
			int value;
			if (ReadFlaggedInteger(out value))
			{
				AmfTraits amfTraits = ReadObjectTraits(value);
				if (amfTraits.Kind == AmfTraitsKind.Externalizable)
				{
					throw new NotImplementedException();
				}
				IAmfClassDescriptor byAlias = _registry.GetByAlias(amfTraits.ClassName);
				object obj = byAlias.BeginDeserialization(amfTraits);
				_objectTable.Add(obj);
				Dictionary<string, object> dictionary = new Dictionary<string, object>();
				string[] memberNames = amfTraits.MemberNames;
				foreach (string key in memberNames)
				{
					object value2 = Read();
					dictionary[key] = value2;
				}
				Dictionary<string, object> dictionary2 = null;
				if (amfTraits.Kind == AmfTraitsKind.Dynamic)
				{
					dictionary2 = new Dictionary<string, object>();
					while (true)
					{
						string text = ReadString();
						if (text == string.Empty)
						{
							break;
						}
						object value3 = Read();
						dictionary2[text] = value3;
					}
				}
				byAlias.EndDeserialization(amfTraits, obj, dictionary, dictionary2);
				return obj;
			}
			return _objectTable[value];
		}

		private XmlDocument ReadXml()
		{
			int value;
			if (ReadFlaggedInteger(out value))
			{
				byte[] array = _reader.ReadBytes(value);
				if (array.Length < value)
				{
					throw new EndOfStreamException();
				}
				string @string = Encoding.UTF8.GetString(array);
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

		public void Dispose()
		{
			if (_reader != null)
			{
				_reader = null;
			}
		}
	}
}

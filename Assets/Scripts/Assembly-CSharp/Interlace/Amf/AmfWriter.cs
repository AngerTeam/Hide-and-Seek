using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;

namespace Interlace.Amf
{
	public class AmfWriter : IDisposable
	{
		public const byte Object = 10;

		private BinaryWriter _writer;

		private AmfRegistry _registry;

		private Dictionary<string, int> _stringTable;

		private ObjectIDGenerator _idGenerator;

		private Dictionary<DateTime, int> _dateTimeTable;

		private Dictionary<long, int> _objectTable;

		private Dictionary<long, int> _traitsTable;

		private static Dictionary<Type, int> _typeMap;

		private static readonly DateTime _amfEpoch;

		public AmfWriter(BinaryWriter writer, AmfRegistry registry)
		{
			_writer = writer;
			_registry = registry;
			_stringTable = new Dictionary<string, int>();
			_idGenerator = new ObjectIDGenerator();
			_dateTimeTable = new Dictionary<DateTime, int>();
			_objectTable = new Dictionary<long, int>();
			_traitsTable = new Dictionary<long, int>();
		}

		static AmfWriter()
		{
			_amfEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
			_typeMap = new Dictionary<Type, int>();
			_typeMap[typeof(bool)] = 3;
			_typeMap[typeof(int)] = 4;
			_typeMap[typeof(double)] = 5;
			_typeMap[typeof(string)] = 6;
			_typeMap[typeof(DateTime)] = 8;
			_typeMap[typeof(AmfArray)] = 9;
			_typeMap[typeof(XmlDocument)] = 11;
			_typeMap[typeof(byte[])] = 12;
		}

		public static byte[] Write(AmfRegistry registry, object value)
		{
			using (MemoryStream memoryStream = new MemoryStream())
			{
				using (AmfWriter amfWriter = new AmfWriter(new BinaryWriter(memoryStream), registry))
				{
					amfWriter.Write(value);
					return memoryStream.ToArray();
				}
			}
		}

		private void WritePackedInteger(int value)
		{
			if (value < 0)
			{
				throw new AmfException("An attempt was made to serialize a negative integer.");
			}
			if (value < 128)
			{
				_writer.Write((byte)value);
				return;
			}
			if (value < 16384)
			{
				_writer.Write((byte)(0x80u | ((uint)(value >> 7) & 0x7Fu)));
				_writer.Write((byte)((uint)value & 0x7Fu));
				return;
			}
			if (value < 2097152)
			{
				_writer.Write((byte)(0x80u | ((uint)(value >> 14) & 0x7Fu)));
				_writer.Write((byte)(0x80u | ((uint)(value >> 7) & 0x7Fu)));
				_writer.Write((byte)((uint)value & 0x7Fu));
				return;
			}
			if (value < 1073741824)
			{
				_writer.Write((byte)(0x80u | ((uint)(value >> 22) & 0x7Fu)));
				_writer.Write((byte)(0x80u | ((uint)(value >> 15) & 0x7Fu)));
				_writer.Write((byte)(0x80u | ((uint)(value >> 8) & 0x7Fu)));
				_writer.Write((byte)((uint)value & 0xFFu));
				return;
			}
			throw new AmfException("An integer too large to serialize was serialized.");
		}

		private void WriteFlaggedInteger(int value, bool flag)
		{
			WritePackedInteger((value << 1) | (flag ? 1 : 0));
		}

		private void WriteNetworkDouble(double value)
		{
			_writer.Write(IPAddress.HostToNetworkOrder(BitConverter.DoubleToInt64Bits(value)));
		}

		private void WriteNull()
		{
			_writer.Write((byte)1);
		}

		private void Write(bool value)
		{
			if (value)
			{
				_writer.Write((byte)3);
			}
			else
			{
				_writer.Write((byte)2);
			}
		}

		private void Write(int value)
		{
			_writer.Write((byte)4);
			WritePackedInteger(value);
		}

		private void Write(double value)
		{
			_writer.Write((byte)5);
			WriteNetworkDouble(value);
		}

		private void WriteBareString(string value)
		{
			if (_stringTable.ContainsKey(value))
			{
				int value2 = _stringTable[value];
				WriteFlaggedInteger(value2, false);
				return;
			}
			if (value != string.Empty)
			{
				_stringTable[value] = _stringTable.Count;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(value);
			WriteFlaggedInteger(bytes.Length, true);
			_writer.Write(bytes);
		}

		private void Write(string value)
		{
			_writer.Write((byte)6);
			WriteBareString(value);
		}

		private void Write(DateTime value)
		{
			_writer.Write((byte)8);
			if (_dateTimeTable.ContainsKey(value))
			{
				int value2 = _dateTimeTable[value];
				WriteFlaggedInteger(value2, false);
				return;
			}
			_dateTimeTable[value] = _dateTimeTable.Count + _objectTable.Count;
			double totalMilliseconds = (value - _amfEpoch).TotalMilliseconds;
			WriteFlaggedInteger(0, true);
			WriteNetworkDouble(totalMilliseconds);
		}

		private void Write(AmfArray value)
		{
			_writer.Write((byte)9);
			bool firstTime;
			long id = _idGenerator.GetId(value, out firstTime);
			if (!firstTime)
			{
				WriteFlaggedInteger(_objectTable[id], false);
				return;
			}
			_objectTable[id] = _objectTable.Count + _dateTimeTable.Count;
			WriteFlaggedInteger(value.DenseElements.Count, true);
			foreach (KeyValuePair<string, object> associativeElement in value.AssociativeElements)
			{
				WriteBareString(associativeElement.Key);
				Write(associativeElement.Value);
			}
			WriteBareString(string.Empty);
			foreach (object denseElement in value.DenseElements)
			{
				Write(denseElement);
			}
		}

		private void Write(byte[] value)
		{
			_writer.Write((byte)12);
			bool firstTime;
			long id = _idGenerator.GetId(value, out firstTime);
			if (!firstTime)
			{
				WriteFlaggedInteger(_objectTable[id], false);
				return;
			}
			_objectTable[id] = _objectTable.Count + _dateTimeTable.Count;
			WriteFlaggedInteger(value.Length, true);
			_writer.Write(value);
		}

		private void WriteObjectTraits(AmfTraits traits)
		{
			bool firstTime;
			long id = _idGenerator.GetId(traits, out firstTime);
			if (!firstTime)
			{
				int value = (_traitsTable[id] << 2) | 1;
				WritePackedInteger(value);
				return;
			}
			_traitsTable[id] = _traitsTable.Count;
			if (traits.Kind == AmfTraitsKind.Externalizable)
			{
				throw new NotImplementedException();
			}
			int num = (traits.MemberNames.Length << 4) | 3;
			if (traits.Kind == AmfTraitsKind.Dynamic)
			{
				num |= 8;
			}
			WritePackedInteger(num);
			WriteBareString(traits.ClassName);
			string[] memberNames = traits.MemberNames;
			foreach (string value2 in memberNames)
			{
				WriteBareString(value2);
			}
		}

		private void WriteObject(Type valueType, object value)
		{
			_writer.Write((byte)10);
			bool firstTime;
			long id = _idGenerator.GetId(value, out firstTime);
			if (!firstTime)
			{
				WriteFlaggedInteger(_objectTable[id], false);
				return;
			}
			_objectTable[id] = _objectTable.Count + _dateTimeTable.Count;
			IAmfClassDescriptor byType = _registry.GetByType(valueType);
			AmfTraits traits;
			IDictionary<string, object> staticMembers;
			IDictionary<string, object> dynamicMembers;
			byType.SerializeObject(value, out traits, out staticMembers, out dynamicMembers);
			WriteObjectTraits(traits);
			string[] memberNames = traits.MemberNames;
			foreach (string key in memberNames)
			{
				Write(staticMembers[key]);
			}
			if (traits.Kind != AmfTraitsKind.Dynamic)
			{
				return;
			}
			foreach (KeyValuePair<string, object> item in dynamicMembers)
			{
				WriteBareString(item.Key);
				Write(item.Value);
			}
			WriteBareString(string.Empty);
		}

		public void Write(object value)
		{
			if (value == null)
			{
				WriteNull();
				return;
			}
			Type type = value.GetType();
			int value2;
			if (_typeMap.TryGetValue(type, out value2))
			{
				switch (value2)
				{
				case 3:
					Write((bool)value);
					break;
				case 4:
					Write((int)value);
					break;
				case 5:
					Write((double)value);
					break;
				case 6:
					Write((string)value);
					break;
				case 8:
					Write((DateTime)value);
					break;
				case 9:
					Write((AmfArray)value);
					break;
				case 12:
					Write((byte[])value);
					break;
				default:
					throw new NotImplementedException();
				}
			}
			else
			{
				WriteObject(type, value);
			}
		}

		public void Dispose()
		{
			if (_writer != null)
			{
				_writer.Close();
				_writer = null;
			}
		}
	}
}

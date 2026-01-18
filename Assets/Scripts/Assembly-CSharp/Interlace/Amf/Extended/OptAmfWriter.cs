using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;

namespace Interlace.Amf.Extended
{
	public class OptAmfWriter : IDisposable
	{
		public const byte Object = 10;

		private BinaryWriter _writer;

		private Dictionary<string, int> _stringTable;

		private ObjectIDGenerator _idGenerator;

		private Dictionary<DateTime, int> _dateTimeTable;

		private Dictionary<long, int> _objectTable;

		private Dictionary<long, int> _traitsTable;

		private static Dictionary<Type, int> _typeMap;

		private static AmfTraits _serializationTraits;

		private static readonly DateTime _amfEpoch;

		public OptAmfWriter(BinaryWriter writer, AmfRegistry registry)
		{
			_writer = writer;
			_idGenerator = new ObjectIDGenerator();
			_stringTable = AmfOptimizationPools.StringIntDictionary.Get();
			_dateTimeTable = AmfOptimizationPools.DateIntDictionary.Get();
			_objectTable = AmfOptimizationPools.LongIntDictionary.Get();
			_traitsTable = AmfOptimizationPools.LongIntDictionary.Get();
		}

		static OptAmfWriter()
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
			_serializationTraits = new AmfTraits(string.Empty, AmfTraitsKind.Dynamic, new string[0]);
		}

		public void Dispose()
		{
			_stringTable.Clear();
			_dateTimeTable.Clear();
			_objectTable.Clear();
			_traitsTable.Clear();
			AmfOptimizationPools.StringIntDictionary.Release(_stringTable);
			AmfOptimizationPools.DateIntDictionary.Release(_dateTimeTable);
			AmfOptimizationPools.LongIntDictionary.Release(_objectTable);
			AmfOptimizationPools.LongIntDictionary.Release(_traitsTable);
			_writer = null;
		}

		public static byte[] Write(AmfRegistry registry, object value)
		{
			using (MemoryStream memoryStream = new MemoryStream())
			{
				using (OptAmfWriter optAmfWriter = new OptAmfWriter(new BinaryWriter(memoryStream), registry))
				{
					optAmfWriter.Write(value);
					return memoryStream.ToArray();
				}
			}
		}

		private void WriteFlaggedInteger(int value, bool flag)
		{
			PackedInt.Write(_writer, (value << 1) | (flag ? 1 : 0));
		}

		private void WriteNetworkDouble(double value)
		{
			_writer.Write(IPAddress.HostToNetworkOrder(OptConverter.DoubleToInt64Bits(value)));
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
			PackedInt.Write(_writer, value);
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
			IEnumerator<KeyValuePair<string, object>> enumerator = value.AssociativeElements.GetEnumerator();
			while (enumerator.MoveNext())
			{
				KeyValuePair<string, object> current = enumerator.Current;
				WriteBareString(current.Key);
				Write(current.Value);
			}
			enumerator.Dispose();
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
				PackedInt.Write(_writer, value);
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
			PackedInt.Write(_writer, num);
			WriteBareString(traits.ClassName);
			for (int i = 0; i < traits.MemberNames.Length; i++)
			{
				WriteBareString(traits.MemberNames[i]);
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
			AmfTraits serializationTraits = _serializationTraits;
			AmfObject amfObject = value as AmfObject;
			IDictionary<string, object> properties = amfObject.Properties;
			WriteObjectTraits(serializationTraits);
			for (int i = 0; i < serializationTraits.MemberNames.Length; i++)
			{
				WriteBareString(serializationTraits.MemberNames[i]);
			}
			if (serializationTraits.Kind == AmfTraitsKind.Dynamic)
			{
				IEnumerator<KeyValuePair<string, object>> enumerator = properties.GetEnumerator();
				while (enumerator.MoveNext())
				{
					KeyValuePair<string, object> current = enumerator.Current;
					WriteBareString(current.Key);
					Write(current.Value);
				}
				WriteBareString(string.Empty);
			}
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
	}
}

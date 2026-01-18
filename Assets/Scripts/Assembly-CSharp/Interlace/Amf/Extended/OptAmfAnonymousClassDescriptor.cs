using System.Collections.Generic;

namespace Interlace.Amf.Extended
{
	public class OptAmfAnonymousClassDescriptor : IAmfClassDescriptor
	{
		private AmfTraits _serializationTraits;

		public string Alias
		{
			get
			{
				return string.Empty;
			}
		}

		internal OptAmfAnonymousClassDescriptor()
		{
			_serializationTraits = new AmfTraits(string.Empty, AmfTraitsKind.Dynamic, new string[0]);
		}

		public object BeginDeserialization(AmfTraits traits)
		{
			return new OptAmfObject();
		}

		public void EndDeserialization(AmfTraits traits, object deserializingTo, IDictionary<string, object> staticMembers, IDictionary<string, object> dynamicMembers)
		{
			OptAmfObject optAmfObject = deserializingTo as OptAmfObject;
			if (optAmfObject == null)
			{
				return;
			}
			IEnumerator<KeyValuePair<string, object>> enumerator = staticMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				KeyValuePair<string, object> current = enumerator.Current;
				optAmfObject.Properties[current.Key] = current.Value;
			}
			enumerator.Dispose();
			if (dynamicMembers != null)
			{
				enumerator = dynamicMembers.GetEnumerator();
				while (enumerator.MoveNext())
				{
					KeyValuePair<string, object> current2 = enumerator.Current;
					optAmfObject.Properties[current2.Key] = current2.Value;
				}
				enumerator.Dispose();
			}
		}

		public void SerializeObject(object value, out AmfTraits traits, out IDictionary<string, object> staticMembers, out IDictionary<string, object> dynamicMembers)
		{
			AmfObject amfObject = value as AmfObject;
			traits = _serializationTraits;
			staticMembers = null;
			dynamicMembers = amfObject.Properties;
		}
	}
}

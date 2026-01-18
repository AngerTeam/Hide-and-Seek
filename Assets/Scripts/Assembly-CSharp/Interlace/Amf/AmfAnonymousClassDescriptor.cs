using System.Collections.Generic;

namespace Interlace.Amf
{
	public class AmfAnonymousClassDescriptor : IAmfClassDescriptor
	{
		private AmfTraits _serializationTraits;

		public string Alias
		{
			get
			{
				return string.Empty;
			}
		}

		internal AmfAnonymousClassDescriptor()
		{
			_serializationTraits = new AmfTraits(string.Empty, AmfTraitsKind.Dynamic, new string[0]);
		}

		public object BeginDeserialization(AmfTraits traits)
		{
			return new AmfObject();
		}

		public void EndDeserialization(AmfTraits traits, object deserializingTo, IDictionary<string, object> staticMembers, IDictionary<string, object> dynamicMembers)
		{
			AmfObject amfObject = deserializingTo as AmfObject;
			foreach (KeyValuePair<string, object> staticMember in staticMembers)
			{
				amfObject.Properties[staticMember.Key] = staticMember.Value;
			}
			if (dynamicMembers == null)
			{
				return;
			}
			foreach (KeyValuePair<string, object> dynamicMember in dynamicMembers)
			{
				amfObject.Properties[dynamicMember.Key] = dynamicMember.Value;
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

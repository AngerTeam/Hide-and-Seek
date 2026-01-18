using System.Collections.Generic;

namespace Interlace.Amf
{
	public interface IAmfClassDescriptor
	{
		string Alias { get; }

		object BeginDeserialization(AmfTraits traits);

		void EndDeserialization(AmfTraits traits, object deserializingTo, IDictionary<string, object> staticMembers, IDictionary<string, object> dynamicMembers);

		void SerializeObject(object value, out AmfTraits traits, out IDictionary<string, object> staticMembers, out IDictionary<string, object> dynamicMembers);
	}
}

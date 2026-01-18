using System.Collections.Generic;
using System.Reflection;

namespace Interlace.Amf
{
	public class AmfPropertyDescriptor
	{
		private readonly PropertyInfo _property;

		private readonly string _serializedName;

		public AmfPropertyDescriptor(PropertyInfo property, AmfPropertyAttribute attribute)
		{
			_property = property;
			if (attribute.SerializedName == null)
			{
				_serializedName = _property.Name;
			}
			else
			{
				_serializedName = attribute.SerializedName;
			}
		}

		internal string[] GetUsedPropertyNames(AmfClassDescriptor descriptor)
		{
			return new string[1] { _serializedName };
		}

		internal void DeserializeProperty(AmfClassDescriptor classDescriptor, object obj, IDictionary<string, object> staticMembers)
		{
			object value;
			if (staticMembers.TryGetValue(_serializedName, out value))
			{
				_property.SetValue(obj, value, null);
				return;
			}
			throw new AmfException(string.Format("The class registered for the alias \"{0}\" was received but was missing an expected property (\"{1}\").", classDescriptor.Alias, _serializedName));
		}

		internal void SerializeProperty(AmfClassDescriptor classDescriptor, object obj, IDictionary<string, object> staticMembers)
		{
			staticMembers[_serializedName] = _property.GetValue(obj, null);
		}
	}
}

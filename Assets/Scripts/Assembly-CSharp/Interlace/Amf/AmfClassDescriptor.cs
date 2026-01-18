using System;
using System.Collections.Generic;
using System.Reflection;

namespace Interlace.Amf
{
	public class AmfClassDescriptor : IAmfClassDescriptor
	{
		private Type _type;

		private AmfClassAttribute _classAttribute;

		private List<AmfPropertyDescriptor> _properties;

		private AmfTraits _serializationTraits;

		public string Alias
		{
			get
			{
				return _classAttribute.Alias;
			}
		}

		public AmfClassDescriptor(Type type)
		{
			_type = type;
			object[] customAttributes = type.GetCustomAttributes(typeof(AmfClassAttribute), true);
			if (customAttributes.Length != 1)
			{
				throw new ArgumentException("The specified type is not marked with the AmfClassAttribute.", "type");
			}
			_classAttribute = customAttributes[0] as AmfClassAttribute;
			_properties = new List<AmfPropertyDescriptor>();
			PropertyInfo[] properties = type.GetProperties();
			foreach (PropertyInfo propertyInfo in properties)
			{
				object[] customAttributes2 = propertyInfo.GetCustomAttributes(typeof(AmfPropertyAttribute), true);
				if (customAttributes2.Length != 0)
				{
					AmfPropertyDescriptor item = new AmfPropertyDescriptor(propertyInfo, customAttributes2[0] as AmfPropertyAttribute);
					_properties.Add(item);
				}
			}
		}

		public object BeginDeserialization(AmfTraits traits)
		{
			return Activator.CreateInstance(_type);
		}

		public void EndDeserialization(AmfTraits traits, object deserializingTo, IDictionary<string, object> staticMembers, IDictionary<string, object> dynamicMembers)
		{
			if (traits.Kind == AmfTraitsKind.Dynamic)
			{
				if (!(deserializingTo is AmfObject))
				{
					throw new AmfException(string.Format("The AMF decoder received a dynamic object but the registered class for the object (\"{0}\") does not support dynamic properties (it does not inherit from AmfObject).", Alias));
				}
				AmfObject amfObject = deserializingTo as AmfObject;
				foreach (KeyValuePair<string, object> dynamicMember in dynamicMembers)
				{
					amfObject.Properties[dynamicMember.Key] = dynamicMember.Value;
				}
			}
			if (_properties.Count != staticMembers.Count)
			{
				Dictionary<string, bool> dictionary = new Dictionary<string, bool>();
				foreach (string key in staticMembers.Keys)
				{
					dictionary[key] = true;
				}
				foreach (AmfPropertyDescriptor property in _properties)
				{
					string[] usedPropertyNames = property.GetUsedPropertyNames(this);
					foreach (string text in usedPropertyNames)
					{
						if (!dictionary.ContainsKey(text))
						{
							throw new AmfException(string.Format("The class registered for the alias \"{0}\" was received but was has an unexpected property (\"{1}\").", Alias, text));
						}
					}
				}
			}
			foreach (AmfPropertyDescriptor property2 in _properties)
			{
				property2.DeserializeProperty(this, deserializingTo, staticMembers);
			}
		}

		public void SerializeObject(object value, out AmfTraits traits, out IDictionary<string, object> staticMembers, out IDictionary<string, object> dynamicMembers)
		{
			if (_serializationTraits == null)
			{
				List<string> list = new List<string>();
				foreach (AmfPropertyDescriptor property in _properties)
				{
					list.AddRange(property.GetUsedPropertyNames(this));
				}
				_serializationTraits = new AmfTraits(_classAttribute.Alias, _type.IsSubclassOf(typeof(AmfObject)) ? AmfTraitsKind.Dynamic : AmfTraitsKind.Static, list.ToArray());
			}
			traits = _serializationTraits;
			if (_serializationTraits.Kind == AmfTraitsKind.Dynamic)
			{
				dynamicMembers = (value as AmfObject).Properties;
			}
			else
			{
				dynamicMembers = null;
			}
			staticMembers = new Dictionary<string, object>();
			foreach (AmfPropertyDescriptor property2 in _properties)
			{
				property2.SerializeProperty(this, value, staticMembers);
			}
		}
	}
}

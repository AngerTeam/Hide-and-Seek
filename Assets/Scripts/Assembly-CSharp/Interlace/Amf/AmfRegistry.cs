using System;
using System.Collections.Generic;

namespace Interlace.Amf
{
	public class AmfRegistry
	{
		protected Dictionary<string, IAmfClassDescriptor> _aliases;

		protected Dictionary<Type, IAmfClassDescriptor> _types;

		public AmfRegistry()
		{
			_aliases = new Dictionary<string, IAmfClassDescriptor>();
			_types = new Dictionary<Type, IAmfClassDescriptor>();
			AmfAnonymousClassDescriptor value = new AmfAnonymousClassDescriptor();
			_aliases[string.Empty] = value;
			_types[typeof(AmfObject)] = value;
		}

		public virtual void RegisterClassAlias(Type type)
		{
			AmfClassDescriptor amfClassDescriptor = new AmfClassDescriptor(type);
			_aliases[amfClassDescriptor.Alias] = amfClassDescriptor;
			_types[type] = amfClassDescriptor;
		}

		public virtual IAmfClassDescriptor GetByAlias(string name)
		{
			if (!_aliases.ContainsKey(name))
			{
				throw new AmfException(string.Format("No class has been registered for the class alias \"{0}\".", name));
			}
			return _aliases[name];
		}

		internal virtual IAmfClassDescriptor GetByType(Type valueType)
		{
			if (!_types.ContainsKey(valueType))
			{
				throw new AmfException(string.Format("No class has been registered for the type \"{0}\".", valueType.Name));
			}
			return _types[valueType];
		}
	}
}

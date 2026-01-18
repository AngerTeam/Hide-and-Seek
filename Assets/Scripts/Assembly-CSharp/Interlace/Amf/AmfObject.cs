using System.Collections.Generic;

namespace Interlace.Amf
{
	public class AmfObject
	{
		protected Dictionary<string, object> _properties;

		public IDictionary<string, object> Properties
		{
			get
			{
				return _properties;
			}
		}

		public AmfObject()
		{
			_properties = new Dictionary<string, object>();
		}

		public AmfObject(bool init)
		{
			if (init)
			{
				_properties = new Dictionary<string, object>();
			}
		}
	}
}

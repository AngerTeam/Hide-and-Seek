using System;

namespace Interlace.Amf
{
	[AttributeUsage(AttributeTargets.Property)]
	public class AmfPropertyAttribute : Attribute
	{
		private string _serializedName;

		public string SerializedName
		{
			get
			{
				return _serializedName;
			}
		}

		public AmfPropertyAttribute()
		{
			_serializedName = null;
		}

		public AmfPropertyAttribute(string serializedName)
		{
			_serializedName = serializedName;
		}
	}
}

using System;

namespace Interlace.Amf
{
	[AttributeUsage(AttributeTargets.Class)]
	public class AmfClassAttribute : Attribute
	{
		private string _alias;

		public string Alias
		{
			get
			{
				return _alias;
			}
		}

		public AmfClassAttribute(string alias)
		{
			_alias = alias;
		}
	}
}

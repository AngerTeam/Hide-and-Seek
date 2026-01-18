using System;
using System.Runtime.Serialization;

namespace Interlace.Amf
{
	[Serializable]
	public class AmfException : Exception
	{
		public AmfException()
		{
		}

		public AmfException(string message)
			: base(message)
		{
		}

		public AmfException(string message, Exception inner)
			: base(message, inner)
		{
		}

		protected AmfException(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
		}
	}
}

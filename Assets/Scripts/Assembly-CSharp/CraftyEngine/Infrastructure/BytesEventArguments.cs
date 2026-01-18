using System;

namespace CraftyEngine.Infrastructure
{
	public class BytesEventArguments : EventArgs
	{
		public string Name { get; private set; }

		public byte[] Bytes { get; private set; }

		public BytesEventArguments(string name, byte[] bytes)
		{
			Name = name;
			Bytes = bytes;
		}
	}
}

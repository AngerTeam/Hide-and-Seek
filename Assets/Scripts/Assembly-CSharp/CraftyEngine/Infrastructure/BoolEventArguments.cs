using System;

namespace CraftyEngine.Infrastructure
{
	public class BoolEventArguments : EventArgs
	{
		public bool Value { get; private set; }

		public BoolEventArguments(bool value)
		{
			Value = value;
		}
	}
}

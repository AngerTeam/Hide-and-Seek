using System;

namespace CraftyEngine.Infrastructure
{
	public class UnityEventArgs : EventArgs
	{
		public bool value;

		public UnityEventType Type { get; private set; }

		public UnityEventArgs(UnityEventType type)
		{
			Type = type;
		}
	}
}

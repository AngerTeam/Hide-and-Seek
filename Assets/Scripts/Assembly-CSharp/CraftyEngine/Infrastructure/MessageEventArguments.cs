using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class MessageEventArguments : EventArgs
	{
		public MessageType type;

		public float position;

		public bool isCritical;

		public int fontSize;

		public Color? color;

		public string Message { get; private set; }

		public MessageEventArguments(string message)
		{
			Message = message;
		}
	}
}

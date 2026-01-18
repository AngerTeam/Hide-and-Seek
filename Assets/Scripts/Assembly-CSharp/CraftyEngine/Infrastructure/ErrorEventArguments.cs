using System;

namespace CraftyEngine.Infrastructure
{
	public class ErrorEventArguments : EventArgs
	{
		public bool handled;

		public string Message { get; private set; }

		public int ErrorCode { get; private set; }

		public ErrorEventArguments(string message, int errorCode = -1)
		{
			Message = message;
			ErrorCode = errorCode;
			handled = false;
		}
	}
}

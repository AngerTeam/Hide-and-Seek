using System;

namespace CraftyNetworkEngine.Chat
{
	public class MessageStruct
	{
		public DateTime timestamp;

		public string message;

		public MessageStruct(string chatMessage, DateTime messageTimestamp)
		{
			message = chatMessage;
			timestamp = messageTimestamp;
		}
	}
}

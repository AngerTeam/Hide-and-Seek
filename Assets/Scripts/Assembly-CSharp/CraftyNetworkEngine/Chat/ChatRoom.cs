using System;
using System.Collections.Generic;
using System.Diagnostics;
using RemoteData.Chat;

namespace CraftyNetworkEngine.Chat
{
	public class ChatRoom
	{
		public ChannelMessage data;

		public List<ChatMessageMessage> Messages;

		public ChatRoom(ChannelMessage roomData)
		{
			data = roomData;
			Messages = new List<ChatMessageMessage>();
			if (data.messages != null)
			{
				ChatMessageMessage[] messages = data.messages;
				foreach (ChatMessageMessage item in messages)
				{
					Messages.Add(item);
				}
			}
		}

		public void AddMessage(ChatMessageMessage message)
		{
			Messages.Add(message);
		}

		public void SortMessagesList()
		{
			Messages.Sort(delegate(ChatMessageMessage first, ChatMessageMessage second)
			{
				double value = first.ts - second.ts;
				return (!(Math.Abs(value) < 0.01)) ? Math.Sign(value) : 0;
			});
		}

		public override string ToString()
		{
			StackTrace stackTrace = new StackTrace();
			return string.Format("Chat: Channel {0} {1} {2}\n{3}", data.id, data.name, data.type, stackTrace);
		}

		public void Dispose()
		{
			data = null;
			Messages.Clear();
			Messages = null;
		}
	}
}

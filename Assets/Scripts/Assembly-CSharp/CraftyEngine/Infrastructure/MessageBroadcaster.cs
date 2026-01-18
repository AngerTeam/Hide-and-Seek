using System;
using System.Collections.Generic;
using System.Text;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class MessageBroadcaster : Singleton
	{
		private static MessageBroadcaster instance;

		private Queue<MessageEventArguments> queue_;

		private Dictionary<object, string> information_;

		private static StringBuilder stringBuilder = new StringBuilder();

		public event Action<MessageEventArguments> MessageAdded;

		public MessageBroadcaster()
		{
			instance = this;
			information_ = new Dictionary<object, string>();
		}

		public override void Init()
		{
			queue_ = new Queue<MessageEventArguments>();
			UnityEvent unityEvent = SingletonManager.Get<UnityEvent>();
			unityEvent.Subscribe(UnityEventType.Update, UnityUpdate);
		}

		private void UnityUpdate()
		{
			while (queue_.Count > 0)
			{
				MessageEventArguments param = queue_.Dequeue();
				this.MessageAdded.SafeInvoke(param);
			}
		}

		internal static string RenderInformation()
		{
			stringBuilder.Length = 0;
			foreach (KeyValuePair<object, string> item in instance.information_)
			{
				stringBuilder.AppendLine(item.Key.ToString());
				stringBuilder.AppendLine(item.Value);
			}
			return stringBuilder.ToString();
		}

		internal static void UpdateInformation(object source, string information)
		{
			instance.information_[source] = information;
		}

		internal void ReportMessage(string message, MessageType type, float position = 0f, bool isCritical = true, int fontSize = 0, Color? color = null)
		{
			if (!string.IsNullOrEmpty(message))
			{
				if (type == MessageType.Error)
				{
					Log.Error("Report Error {0}", message);
				}
				else
				{
					Log.Info("Report Info {0}", message);
				}
				MessageEventArguments messageEventArguments = new MessageEventArguments(message);
				messageEventArguments.type = type;
				MessageEventArguments messageEventArguments2 = messageEventArguments;
				messageEventArguments2.fontSize = fontSize;
				messageEventArguments2.position = position;
				messageEventArguments2.isCritical = isCritical;
				messageEventArguments2.color = color;
				queue_.Enqueue(messageEventArguments2);
			}
		}

		public static void ReportInfo(object source, float position = 0f, int fontSize = 0, Color? color = null)
		{
			instance.ReportMessage(source.ToString(), MessageType.Info, position, false, fontSize, color);
		}

		public static void ReportError(string message, bool isCritical = true)
		{
			MessageBroadcaster messageBroadcaster = instance;
			bool isCritical2 = isCritical;
			messageBroadcaster.ReportMessage(message, MessageType.Error, 0f, isCritical2);
		}
	}
}

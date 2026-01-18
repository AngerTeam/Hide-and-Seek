using System.Collections.Generic;
using System.Timers;
using UnityEngine;

namespace LogSystem
{
	public class LogTargetUnityConsole : Log.LogTarget
	{
		private struct Message
		{
			public Log.LogCategory category;

			public string message;
		}

		private Queue<Message> messages_;

		public LogTargetUnityConsole()
		{
			unityNative = true;
			messages_ = new Queue<Message>();
			Timer timer = new Timer(2.0);
			timer.Elapsed += Flush;
			timer.Start();
		}

		private void Flush(object sender, ElapsedEventArgs e)
		{
			if (messages_.Count > 0)
			{
				Message message = messages_.Dequeue();
				FlushMessage(message.category, message.message);
			}
		}

		private static void FlushMessage(Log.LogCategory category, string message)
		{
			switch (category)
			{
			default:
				Debug.Log("cLog: " + message);
				break;
			case Log.LogCategory.Warning:
				Debug.LogWarning("cLog: " + message);
				break;
			case Log.LogCategory.Error:
				Debug.LogError("cLog: " + message);
				break;
			}
		}

		public override void AddMessage(Log.LogCategory category, string message)
		{
			FlushMessage(category, message);
		}
	}
}

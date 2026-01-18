using CraftyEngine;
using CraftyEngine.Infrastructure;
using RemoteData;
using UnityEngine;

namespace HttpNetwork
{
	public class HttpService : Singleton
	{
		private UnityThreadQueue queue_;

		private QueueManager queueManager_;

		private static string secret_ = "??????";

		public string defaultServerUrl;

		public HttpService()
		{
			secret_ = "Tu3wMUt6";
		}

		public override void Init()
		{
			GetSingleton<QueueManager>(out queueManager_);
			queue_ = queueManager_.AddUnityThreadQueue();
		}

		public static void SessionRequest(RemoteCommand command)
		{
			command.ts = ContentStandart.GetUnixTimeStamp().ToString();
			command.sig = ContentStandart.Md5Sum(command.cmd + command.ts + secret_);
		}

		internal HttpCommandTask Send(RemoteCommand command)
		{
			return Send(command, defaultServerUrl);
		}

		internal HttpCommandTask Send(RemoteCommand command, string serverUrl)
		{
			SessionRequest(command);
			return Send(AmfHelper.Write(command.Serialize()), serverUrl);
		}

		internal HttpCommandTask Send(byte[] postData, string serverUrl)
		{
			HttpCommandTask httpCommandTask = new HttpCommandTask(serverUrl, postData);
			queueManager_.AddTask(httpCommandTask, queue_);
			return httpCommandTask;
		}

		internal HttpWWWFormTask Send(WWWForm form, string serverUrl)
		{
			HttpWWWFormTask httpWWWFormTask = new HttpWWWFormTask(serverUrl, form);
			queueManager_.AddTask(httpWWWFormTask, queue_);
			return httpWWWFormTask;
		}
	}
}

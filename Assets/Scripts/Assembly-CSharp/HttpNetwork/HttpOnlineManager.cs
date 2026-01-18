using System;
using Authorization;
using CraftyEngine;
using Extensions;
using Interlace.Amf;
using RemoteData;

namespace HttpNetwork
{
	public class HttpOnlineManager : Singleton
	{
		private const int SUCCESS = 0;

		private HttpService httpService_;

		private HttpOnlineModel model_;

		public static void InitHttp(int layer)
		{
			SingletonManager.Add<HttpService>(layer);
			SingletonManager.Add<HttpOnlineManager>(layer);
			SingletonManager.Add<HttpOnlineModel>(layer);
		}

		public override void Init()
		{
			GetSingleton<HttpService>(out httpService_);
			GetSingleton<HttpOnlineModel>(out model_);
		}

		public void Send(RemoteCommand command, string url = null, bool silent = false)
		{
			RemoteLuaCommand remoteLuaCommand = command as RemoteLuaCommand;
			if (model_.userId != 0 && remoteLuaCommand != null)
			{
				if (string.IsNullOrEmpty(model_.sessionId))
				{
					Log.Warning("Attempt to send command {0} wihtout sessoin", command);
					return;
				}
				remoteLuaCommand.userId = model_.userId;
				remoteLuaCommand.persId = model_.persId;
				remoteLuaCommand.sid = model_.sessionId;
			}
			if (string.IsNullOrEmpty(url) && model_ != null)
			{
				url = model_.gameServerUrl;
			}
			if (string.IsNullOrEmpty(url))
			{
				Log.Warning("Attemt to send {0} to null url", command);
				return;
			}
			HttpCommandTask task = httpService_.Send(command, url);
			task.silent = silent;
			task.Completed += delegate
			{
				HandleTaskCompleted(task, command);
			};
		}

		public void Send<T>(RemoteCommand command, Action<RemoteMessageEventArgs> evt, string url = null, bool silent = false) where T : RemoteMessage, new()
		{
			Send(command, url, silent);
			command.AddResponce(delegate(T data)
			{
				ReportEvent(data, command, evt);
			});
		}

		private void HandleTaskCompleted(HttpCommandTask task, RemoteCommand request)
		{
			if (task.bytes == null || task.bytes.Length == 0)
			{
				request.ReportResponceNotRecieved();
				return;
			}
			AmfObject amfObject;
			try
			{
				amfObject = AmfHelper.ReadObject(task.bytes);
			}
			catch (Exception data)
			{
				Exc.Report(3110, task, data);
				request.ReportResponceNotRecieved();
				return;
			}
			if (amfObject.Properties.ContainsKey("status"))
			{
				int num = (int)amfObject.Properties["status"];
				if (num == 0)
				{
					request.ReportResponceRecieved(amfObject);
					return;
				}
				task.error = (string)amfObject.Properties["error"];
				Exc.Report(num, task, task.error);
				request.ReportResponceNotRecieved();
			}
		}

		private void ReportEvent<T1, T2>(T1 data, T2 command, Action<RemoteMessageEventArgs> evt) where T1 : RemoteMessage where T2 : RemoteCommand
		{
			if (data != null)
			{
				evt.SafeInvoke(new RemoteMessageEventArgs(data));
			}
		}
	}
}

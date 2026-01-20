using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace HttpNetwork
{
	public class HttpCommandTask : ProgressableTask, IDisposable
	{
		public WWW www;

		public byte[] bytes;

		public string error;

		public bool silent;

		private byte[] postData_;

		private UnityEvent unityEvent_;

		protected string url_;

		public HttpCommandTask(string url, byte[] postData)
		{
			url_ = url;
			postData_ = postData;
		}

		public virtual void Dispose()
		{
			www.Dispose();
			www = null;
		}

		public override void Start()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			CreateWWW();
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
		}

		public virtual void CreateWWW()
		{
			www = new WWW(url_, postData_);
		}

		private void UnityUpdate()
		{
			if (www.isDone)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
				if (string.IsNullOrEmpty(www.error))
				{
					bytes = www.bytes;
					Complete();
				}
				else
				{
					if (!silent)
					{
						Debug.LogError(www.url);
						Exc.Report(3111, url_, www.error);
					}
					if (!string.IsNullOrEmpty(CreateCallStack))
					{
						Log.Error("at {0}", CreateCallStack);
					}
					CompleteWithError(www.error, 100500);
				}
				ReportProgress(1f);
			}
			else
			{
				ReportProgress(www.uploadProgress * 0.2f + www.progress * 0.8f);
			}
		}
	}
}

using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using Extensions;
using Interlace.Amf;

namespace RemoteData
{
	public class RemoteCommand : RemoteRequest
	{
		public string cmd;

		public int repetTries;

		public int seq;

		public string sig;

		public string ts;

		private static Dictionary<string, ThreadObjectPool<AmfObject>> amfPool_ = new Dictionary<string, ThreadObjectPool<AmfObject>>();

		private UnityTimer timer_;

		public bool ResponseNeeded { get; private set; }

		public event Action<RemoteCommand> ResponceNotRecieved;

		public event Action<AmfObject> ResponceRecieved
		{
			add
			{
				this.responceRecieved_ = (Action<AmfObject>)Delegate.Combine(this.responceRecieved_, value);
				ResponseNeeded = true;
			}
			remove
			{
				this.responceRecieved_ = (Action<AmfObject>)Delegate.Remove(this.responceRecieved_, value);
			}
		}

		private event Action<AmfObject> responceRecieved_;

		public void ReleaseAmf(AmfObject amfObject)
		{
			amfPool_[cmd].Release(amfObject);
		}

		public void ReportResponceNotRecieved()
		{
			StopTimer();
			this.ResponceNotRecieved.SafeInvoke(this);
		}

		public void ReportResponceRecieved(AmfObject obj)
		{
			StopTimer();
			if (this.responceRecieved_ != null)
			{
				this.responceRecieved_(obj);
			}
		}

		internal void AddResponce<T>(Action<T> action) where T : RemoteMessage, new()
		{
			ResponceRecieved += delegate(AmfObject data)
			{
				T message;
				RemoteMessage.TryRead<T>(data, out message);
				action(message);
			};
			this.ResponceNotRecieved = (Action<RemoteCommand>)Delegate.Combine(this.ResponceNotRecieved, (Action<RemoteCommand>)delegate
			{
				action((T)null);
			});
		}

		internal void Clear()
		{
			this.responceRecieved_ = null;
			this.ResponceNotRecieved = null;
		}

		internal void StartTimer()
		{
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			timer_ = unityTimerManager.SetTimer(2f);
			timer_.Completeted += ReportResponceNotRecieved;
		}

		internal void StopTimer()
		{
			if (timer_ != null)
			{
				timer_.Stop();
				timer_ = null;
			}
		}

		protected object GetAmfArray<T>(T[] array)
		{
			AmfArray amfArray = new AmfArray();
			for (int i = 0; i < array.Length; i++)
			{
				amfArray.DenseElements.Add(array[i]);
			}
			return amfArray;
		}

		protected object GetMessageAmfArray<T>(T[] array) where T : RemoteMessage
		{
			AmfArray amfArray = new AmfArray();
			for (int i = 0; i < array.Length; i++)
			{
				amfArray.DenseElements.Add(array[i].Serialize());
			}
			return amfArray;
		}

		protected override AmfObject GetAmfObject()
		{
			return amfPool_.GetOrSet(cmd).Get();
		}
	}
}

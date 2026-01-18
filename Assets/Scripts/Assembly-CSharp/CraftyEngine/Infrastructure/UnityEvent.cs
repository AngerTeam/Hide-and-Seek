using System;
using System.Collections.Generic;
using System.Threading;
using CraftyEngine.Utils;

namespace CraftyEngine.Infrastructure
{
	public abstract class UnityEvent : Singleton
	{
		public bool enabled;

		private Dictionary<Action, UnityEventType> asyncAdd_;

		private Dictionary<Action, UnityEventType> asyncRemove_;

		private Dictionary<int, List<Action>> listeners_;

		private bool needToClear_;

		private bool syncLock_;

		private Exception lastException_;

		public bool HasFocus { get; private set; }

		public bool Paused { get; private set; }

		protected bool Disposed { get; private set; }

		protected UnityEvent()
		{
			enabled = true;
			HasFocus = true;
			Paused = false;
			Disposed = false;
			syncLock_ = false;
			listeners_ = new Dictionary<int, List<Action>>();
			asyncRemove_ = new Dictionary<Action, UnityEventType>();
			asyncAdd_ = new Dictionary<Action, UnityEventType>();
			UnityEventType[] array = (UnityEventType[])Enum.GetValues(typeof(UnityEventType));
			for (int i = 0; i < array.Length + 1; i++)
			{
				listeners_.Add(i, new List<Action>());
			}
		}

		internal static void OnNextUpdate(Action delayedAction)
		{
			UnityEvent singleton;
			if (SingletonManager.TryGet<UnityEvent>(out singleton))
			{
				singleton.Subscribe(UnityEventType.Update, delayedAction, true);
			}
		}

		public void ClearAllSubscribtions()
		{
			if (syncLock_)
			{
				needToClear_ = true;
				return;
			}
			foreach (KeyValuePair<int, List<Action>> item in listeners_)
			{
				if (item.Key != UnityEventType2Int.ApplicationQuit)
				{
					item.Value.Clear();
				}
			}
			needToClear_ = false;
		}

		public override void Dispose()
		{
			if (Disposed)
			{
				Exc.Report(3002, this, "UnityEvent Disposed TWICE!!!");
			}
			Disposed = true;
			ClearAllSubscribtions();
		}

		public virtual void Subscribe(UnityEventType eventType, Action handler)
		{
			if (Disposed)
			{
				return;
			}
			if (syncLock_)
			{
				try
				{
					Monitor.Enter(asyncAdd_);
					if (!asyncAdd_.ContainsKey(handler))
					{
						asyncAdd_.Add(handler, eventType);
					}
					else
					{
						Log.Warning("{0} for {1} is already in queue for add", handler, eventType);
					}
					return;
				}
				finally
				{
					Monitor.Exit(asyncAdd_);
				}
			}
			Add(eventType, handler);
		}

		public void Subscribe(UnityEventType eventType, Action handler, bool once)
		{
			if (Disposed)
			{
				Exc.Report(3002, this, string.Format("Subscribe of {0} ({1}) failed since UnityEvent is disposed", eventType, handler.Method.Name));
			}
			else if (once)
			{
				Action tempHandler = null;
				tempHandler = delegate
				{
					Unsubscribe(eventType, tempHandler);
					handler();
				};
				Subscribe(eventType, tempHandler);
			}
			else
			{
				Subscribe(eventType, handler);
			}
		}

		public virtual void Unsubscribe(UnityEventType eventType, Action handler)
		{
			if (Disposed)
			{
				return;
			}
			if (syncLock_)
			{
				try
				{
					Monitor.Enter(asyncRemove_);
					if (!asyncRemove_.ContainsKey(handler))
					{
						asyncRemove_.Add(handler, eventType);
					}
					else
					{
						Log.Warning("{0} for {1} is already in queue for removal", handler, eventType);
					}
					return;
				}
				finally
				{
					Monitor.Exit(asyncRemove_);
				}
			}
			Remove(eventType, handler);
		}

		protected virtual void Add(UnityEventType eventType, Action handler)
		{
			List<Action> list = listeners_[UnityEventType2Int.Enum2Int(eventType)];
			list.Add(handler);
		}

		protected void HandleBoolEvent(UnityEventType type, bool value)
		{
			if (type == UnityEventType.ApplicationFocus)
			{
				HasFocus = value;
			}
			if (type == UnityEventType.ApplicationPause)
			{
				Paused = value;
			}
			HandleUnityEventRecieved(type);
		}

		protected void HandleNullEvent(UnityEventType type)
		{
			HandleUnityEventRecieved(type);
		}

		protected void HandleUnityEventRecieved(UnityEventType type)
		{
			if (!Disposed)
			{
				syncLock_ = true;
				Dispatch(type);
				syncLock_ = false;
				if (needToClear_)
				{
					ClearAllSubscribtions();
				}
				else
				{
					AsyncSubscribe();
				}
			}
		}

		protected virtual void Remove(UnityEventType eventType, Action handler)
		{
			listeners_[UnityEventType2Int.Enum2Int(eventType)].Remove(handler);
		}

		private void AsyncSubscribe()
		{
			try
			{
				Monitor.Enter(asyncRemove_);
				if (asyncRemove_.Count > 0)
				{
					foreach (KeyValuePair<Action, UnityEventType> item in asyncRemove_)
					{
						Unsubscribe(item.Value, item.Key);
					}
					asyncRemove_.Clear();
				}
			}
			finally
			{
				Monitor.Exit(asyncRemove_);
			}
			try
			{
				Monitor.Enter(asyncAdd_);
				if (asyncAdd_.Count <= 0)
				{
					return;
				}
				foreach (KeyValuePair<Action, UnityEventType> item2 in asyncAdd_)
				{
					Subscribe(item2.Value, item2.Key);
				}
				asyncAdd_.Clear();
			}
			finally
			{
				Monitor.Exit(asyncAdd_);
			}
		}

		protected virtual void Dispatch(UnityEventType type)
		{
			if (Disposed)
			{
				return;
			}
			List<Action> list = listeners_[UnityEventType2Int.Enum2Int(type)];
			int i = 0;
			for (int count = list.Count; i < count; i++)
			{
				if (needToClear_)
				{
					break;
				}
				if (Disposed)
				{
					break;
				}
				Action action = list[i];
				if (action == null || action.Method == null)
				{
					Exc.Report(3002, this, string.Format("Unable to execute action {0}! Action is null!\nAll actions:{1}", i, ArrayUtils.ArrayToString(list)));
					continue;
				}
				try
				{
					Execute(type, action);
				}
				catch (Exception ex)
				{
					if (lastException_ == null || !(lastException_.Message == ex.Message))
					{
						lastException_ = ex;
						Exc.Report(3002, this, ex);
					}
				}
			}
		}

		protected void Execute(UnityEventType type, Action handler)
		{
			try
			{
				handler();
			}
			catch (InvalidOperationException ex)
			{
				string text = string.Format("Invocation of event {0} was interrupdated at {1}. This message is harmless", type, handler.Method.Name);
				if (Disposed)
				{
					Log.Info(text + "\n" + ex.Message + "\n" + ex.StackTrace);
				}
				else
				{
					Exc.Report(3002, this, text);
				}
			}
		}
	}
}

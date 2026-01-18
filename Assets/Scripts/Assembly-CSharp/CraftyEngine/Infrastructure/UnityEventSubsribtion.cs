using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class UnityEventSubsribtion : IDisposable
	{
		private static Dictionary<string, UnityEventType> allClassesList_ = new Dictionary<string, UnityEventType>();

		private static int lastReportedCount_;

		public bool active;

		public long avarageDuration;

		public int callCount;

		public string className;

		public Action<UnityEventType, Action> execute;

		public Action handler;

		public string title;

		public UnityEventType type;

		private IUnityEventComponent component_;

		private GameObject gameObject_;

		private List<Action> handlers_;

		public UnityEventSubsribtion(UnityEventType eventType, Action handler)
		{
			type = eventType;
			this.handler = handler;
			active = true;
			title = TextUtils.GetActionName(handler);
		}

		public UnityEventSubsribtion(UnityEventType eventType, string title, Action<UnityEventType, Action> execute)
		{
			type = eventType;
			this.title = title;
			this.execute = execute;
			className = TextUtils.ToCamelCase(title);
			handlers_ = new List<Action>();
			if (!allClassesList_.ContainsKey(className))
			{
				allClassesList_.Add(className, type);
			}
		}

		public void AddHandler(Action action)
		{
			handlers_.Add(action);
		}

		public void Dispose()
		{
			handlers_ = null;
			component_.Clear();
			UnityEngine.Object.Destroy(gameObject_);
			if (lastReportedCount_ != allClassesList_.Count)
			{
				lastReportedCount_ = allClassesList_.Count;
				Debug.Log("All Unity Event Subsribtions:\n" + ArrayUtils.DictionaryToString(allClassesList_, ":", "\n"));
			}
		}

		public void Init(Transform parent)
		{
			gameObject_ = new GameObject(className);
			gameObject_.transform.SetParent(parent);
			component_ = gameObject_.AddComponent<UnityEventComponent>();
			switch (type)
			{
			case UnityEventType.FixedUpdate:
				component_.NullEvent += ExecuteFixedUpdate;
				break;
			case UnityEventType.Update:
				component_.NullEvent += ExecuteUpdate;
				break;
			case UnityEventType.LateUpdate:
				component_.NullEvent += ExecuteLateUpdate;
				break;
			}
		}

		public void RemoveHandler(Action action)
		{
			handlers_.Remove(action);
		}

		private void Execude(UnityEventType obj)
		{
			if (handlers_ == null)
			{
				return;
			}
			for (int i = 0; i < handlers_.Count; i++)
			{
				execute(obj, handlers_[i]);
				if (handlers_ == null)
				{
					break;
				}
			}
		}

		private void ExecuteFixedUpdate(UnityEventType eventType)
		{
			if (eventType == UnityEventType.FixedUpdate)
			{
				Execude(eventType);
			}
		}

		private void ExecuteLateUpdate(UnityEventType eventType)
		{
			if (eventType == UnityEventType.LateUpdate)
			{
				Execude(eventType);
			}
		}

		private void ExecuteUpdate(UnityEventType eventType)
		{
			if (eventType == UnityEventType.Update)
			{
				Execude(eventType);
			}
		}
	}
}

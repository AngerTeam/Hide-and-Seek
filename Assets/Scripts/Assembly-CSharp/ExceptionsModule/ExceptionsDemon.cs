using System;
using System.Collections.Generic;
using System.Reflection;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace ExceptionsModule
{
	public class ExceptionsDemon : Singleton
	{
		private UnityEvent unityEvent_;

		private List<int> exceptions_;

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		}

		public override void Init()
		{
			exceptions_ = new List<int>();
			Type typeFromHandle = typeof(ExcMap);
			FieldInfo[] fields = typeFromHandle.GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.FlattenHierarchy);
			foreach (FieldInfo fieldInfo in fields)
			{
				if (fieldInfo.IsLiteral && !fieldInfo.IsInitOnly)
				{
					exceptions_.Add((int)fieldInfo.GetValue(null));
				}
			}
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			if ((double)UnityEngine.Random.value > 0.99)
			{
				int index = UnityEngine.Random.Range(0, exceptions_.Count);
				Exc.Report(exceptions_[index], null, "demon!");
			}
		}
	}
}

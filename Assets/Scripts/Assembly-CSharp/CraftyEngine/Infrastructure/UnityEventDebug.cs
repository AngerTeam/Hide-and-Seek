using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure
{
	public class UnityEventDebug : UnityEventRuntimeConductor
	{
		public List<UnityEventSubsribtion> subsribtions;

		public bool active;

		public UnityEventDebug()
		{
			subsribtions = new List<UnityEventSubsribtion>();
			active = true;
		}

		protected override void Add(UnityEventType eventType, Action handler)
		{
			UnityEventSubsribtion item = new UnityEventSubsribtion(eventType, handler);
			subsribtions.Add(item);
		}

		protected override void Remove(UnityEventType eventType, Action handler)
		{
			for (int i = 0; i < subsribtions.Count; i++)
			{
				if (subsribtions[i].handler == handler)
				{
					subsribtions.RemoveAt(i);
					break;
				}
			}
		}

		protected override void Dispatch(UnityEventType type)
		{
			if (!active || base.Disposed)
			{
				return;
			}
			int i = 0;
			for (int count = subsribtions.Count; i < count; i++)
			{
				if (base.Disposed)
				{
					break;
				}
				UnityEventSubsribtion unityEventSubsribtion = subsribtions[i];
				if (unityEventSubsribtion.active && unityEventSubsribtion.type == type)
				{
					long ticks = DateTime.Now.Ticks;
					Execute(type, unityEventSubsribtion.handler);
					long ticks2 = DateTime.Now.Ticks;
					long num = ticks2 - ticks;
					long num2 = unityEventSubsribtion.avarageDuration * unityEventSubsribtion.callCount;
					num2 += num;
					unityEventSubsribtion.callCount++;
					unityEventSubsribtion.avarageDuration = num2 / unityEventSubsribtion.callCount;
				}
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			subsribtions.Clear();
		}
	}
}

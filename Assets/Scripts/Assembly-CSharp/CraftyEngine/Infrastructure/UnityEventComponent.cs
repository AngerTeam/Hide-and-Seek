using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class UnityEventComponent : MonoBehaviour, IUnityEventComponent
	{
		public event Action<UnityEventType> NullEvent;

		public event Action<UnityEventType, bool> BoolEvent;

		private void Update()
		{
			if (this.NullEvent != null)
			{
				this.NullEvent(UnityEventType.Update);
			}
		}

		private void FixedUpdate()
		{
			if (this.NullEvent != null)
			{
				this.NullEvent(UnityEventType.FixedUpdate);
			}
		}

		private void LateUpdate()
		{
			if (this.NullEvent != null)
			{
				this.NullEvent(UnityEventType.LateUpdate);
			}
		}

		private void OnApplicationQuit()
		{
			if (this.NullEvent != null)
			{
				this.NullEvent(UnityEventType.ApplicationQuit);
			}
		}

		private void OnApplicationFocus(bool focus)
		{
			if (this.BoolEvent != null)
			{
				this.BoolEvent(UnityEventType.ApplicationFocus, focus);
			}
		}

		private void OnApplicationPause(bool pause)
		{
			if (this.BoolEvent != null)
			{
				this.BoolEvent(UnityEventType.ApplicationPause, pause);
			}
		}

		public void Clear()
		{
			this.NullEvent = null;
			this.BoolEvent = null;
		}
	}
}

using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class UnityEventRuntimeConductor : UnityEvent
	{
		private UnityEventComponent component_;

		public override void Init()
		{
			base.Init();
			GameObject gameObject = new GameObject("EventProxy " + Layer);
			Object.DontDestroyOnLoad(gameObject);
			component_ = gameObject.AddComponent<UnityEventComponent>();
			component_.NullEvent += base.HandleNullEvent;
			component_.BoolEvent += base.HandleBoolEvent;
		}

		public override void Dispose()
		{
			base.Dispose();
			Object.Destroy(component_.gameObject);
		}
	}
}

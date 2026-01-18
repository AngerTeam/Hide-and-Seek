using System;

namespace CraftyEngine.Infrastructure
{
	public interface IUnityEventComponent
	{
		event Action<UnityEventType> NullEvent;

		void Clear();
	}
}

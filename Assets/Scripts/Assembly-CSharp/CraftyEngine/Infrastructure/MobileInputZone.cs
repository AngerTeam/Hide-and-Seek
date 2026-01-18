using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class MobileInputZone
	{
		public Rect rect = new Rect(0f, 0f, 0.25f, 0.5f);

		public Rect rectPixels;

		public MobileInputType Type;

		public bool useDeltaCorrection;

		private UnityScreenSizeTracker unityScreenSizeTracker_;

		public MobileInputZone(Rect rect, MobileInputType type)
		{
			Type = type;
			this.rect = rect;
			SingletonManager.Get<UnityScreenSizeTracker>(out unityScreenSizeTracker_);
			Resize();
		}

		public void Resize()
		{
			rectPixels = Multiply(rect, unityScreenSizeTracker_.Size);
		}

		private Rect Multiply(Rect rect, Vector2 vector)
		{
			return new Rect(rect.xMin * vector.x, rect.yMin * vector.y, rect.xMax * vector.x, rect.yMax * vector.y);
		}
	}
}

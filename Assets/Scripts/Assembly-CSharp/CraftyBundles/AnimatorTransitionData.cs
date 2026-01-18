using System;

namespace CraftyBundles
{
	[Serializable]
	public class AnimatorTransitionData
	{
		public int id;

		public int fromState;

		public int toState;

		public float duration;

		public float exitTime;

		public bool hasExitTime;

		public float offset;
	}
}

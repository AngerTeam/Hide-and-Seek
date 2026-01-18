using System;

namespace CraftyBundles
{
	[Serializable]
	public class AnimatorLayerData
	{
		public string name;

		public AnimatorTransitionData[] transitions;

		public AnimatorStateData[] states;
	}
}

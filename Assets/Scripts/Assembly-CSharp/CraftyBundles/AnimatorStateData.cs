using System;

namespace CraftyBundles
{
	[Serializable]
	public class AnimatorStateData
	{
		public int id;

		public string name;

		public int clip;

		public int[] transitions;
	}
}

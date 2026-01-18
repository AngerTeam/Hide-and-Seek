using System;
using UnityEngine;

namespace CraftyBundles
{
	[Serializable]
	public class AnimatorData
	{
		public string name;

		public AnimatorLayerData[] layers;

		public AnimatorClipData[] clips;

		public override string ToString()
		{
			return JsonUtility.ToJson(this, true);
		}
	}
}

using System;
using UnityEngine;

namespace CraftyBundles
{
	[Serializable]
	public class AnimatorClipData
	{
		[NonSerialized]
		public string stateName;

		public int id;

		public string name;

		public float duration;

		public AnimatorEventData[] events;

		public AnimationClip clip;

		public string dynamicStateA;

		public string dynamicStateB;

		public bool a;
	}
}

using System;
using Extensions;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class AnimatorIKEventsHandler : MonoBehaviour
	{
		public event Action<int> OnAnimatorIKEvent;

		private void OnAnimatorIK(int layerIndex)
		{
			this.OnAnimatorIKEvent.SafeInvoke(layerIndex);
		}
	}
}

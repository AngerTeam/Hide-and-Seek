using System;
using Animations;
using ArticulViewModule;
using Extensions;

namespace PlayerModule
{
	public class PlayerVisualModelByCamera
	{
		public bool enabled;

		public AnimatedItemView[] views;

		public AnimatedItemView BodyAsc;

		public AnimatedItemView ProjectileAsc;

		public ArticulViewBase ProjectileArticulView;

		public string pendingAnimation;

		public event Action Updated;

		public PlayerVisualModelByCamera()
		{
			enabled = true;
		}

		public void ReportUpdated()
		{
			this.Updated.SafeInvoke();
		}
	}
}

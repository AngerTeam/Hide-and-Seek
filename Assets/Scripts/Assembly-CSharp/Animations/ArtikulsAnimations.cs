using System;
using Extensions;

namespace Animations
{
	public class ArtikulsAnimations
	{
		public float attackDuration;

		public float contactMoment;

		public float flauntDuration;

		public float idleDuration;

		public float menuDuration;

		public string[] flauntStates;

		public event Action Updated;

		public void Update()
		{
			this.Updated.SafeInvoke();
		}
	}
}

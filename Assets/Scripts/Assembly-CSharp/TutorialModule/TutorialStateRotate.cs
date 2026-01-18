using UnityEngine;

namespace TutorialModule
{
	public class TutorialStateRotate : TutorialStatePlayerControl
	{
		private const float rotationDistanceClamp = 30f;

		public TutorialStateRotate()
		{
			title = "Prompt_TutorialLook";
			label.itemId = 14;
			label.anchor = TutorialAnchor.Left;
		}

		public override void OnStart()
		{
			start = myPlayerStatsModel_.stats.Rotation;
			base.OnStart();
		}

		protected override void Update()
		{
			float num = Vector3.Distance(start, myPlayerStatsModel_.stats.Rotation);
			if (num > 30f)
			{
				Complete();
			}
		}
	}
}

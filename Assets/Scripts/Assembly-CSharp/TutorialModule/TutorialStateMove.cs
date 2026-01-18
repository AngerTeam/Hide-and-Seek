using UnityEngine;

namespace TutorialModule
{
	public class TutorialStateMove : TutorialStatePlayerControl
	{
		private const float POSITION_DISTANCE_CLAMP = 2f;

		public TutorialStateMove()
		{
			title = "Prompt_TutorialMove";
			label.itemId = 1;
			label.anchor = TutorialAnchor.Left;
		}

		public override void OnStart()
		{
			start = myPlayerStatsModel_.stats.Position;
			base.OnStart();
		}

		protected override void Update()
		{
			float num = Vector3.Distance(start, myPlayerStatsModel_.stats.Position);
			if (num > 2f)
			{
				Complete();
			}
		}
	}
}

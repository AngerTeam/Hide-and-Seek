using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class InputClickUtility : ClickUtility<InputInstance>
	{
		protected override bool InsideThreshold
		{
			get
			{
				return Vector2.Distance(instance.StartPressPosition, instance.CurrentPosition) < model.clickDistanceTreshold;
			}
		}

		public InputClickUtility(InputInstance instance)
			: base(instance)
		{
		}
	}
}

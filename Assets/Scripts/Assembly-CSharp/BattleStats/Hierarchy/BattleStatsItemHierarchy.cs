using UnityEngine;

namespace BattleStats.Hierarchy
{
	public class BattleStatsItemHierarchy : MonoBehaviour
	{
		public UISprite icon;

		public UILabel label;

		public UILabel title;

		internal void Set(bool enableTitle)
		{
			if (enableTitle)
			{
				if (icon != null)
				{
					Object.Destroy(icon.gameObject);
				}
				if (label != null)
				{
					Object.Destroy(label.gameObject);
				}
			}
			else if (title != null)
			{
				Object.Destroy(title.gameObject);
			}
		}
	}
}

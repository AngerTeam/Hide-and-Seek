using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelSelectorColors
	{
		public static readonly Color colorSelectNoLight = new Color(0f, 0f, 0f, 0.05f);

		public static readonly Color colorSelectHiLight = new Color(0f, 0f, 0f, 0.4f);

		public static readonly Color colorHoldNoLight = new Color(0.2f, 0.2f, 0.8f, 0.05f);

		public static readonly Color colorHoldHiLight = new Color(0.2f, 0.2f, 0.8f, 0.4f);

		public static readonly Color colorRegionNoLight = new Color(0.5f, 0.8f, 0f, 0.05f);

		public static readonly Color colorRegionHiLight = new Color(0.5f, 0.8f, 0f, 0.4f);

		public static readonly Color colorTriggerNoLight = new Color(0.8f, 0.2f, 0f, 0.05f);

		public static readonly Color colorTriggerHiLight = new Color(0.8f, 0.2f, 0f, 0.4f);

		public static Color GetColor(int regionType, bool light)
		{
			Color result = colorSelectNoLight;
			switch (regionType)
			{
			case 0:
				result = ((!light) ? colorSelectNoLight : colorSelectHiLight);
				break;
			case 1:
				result = ((!light) ? colorRegionNoLight : colorRegionHiLight);
				break;
			case 2:
				result = ((!light) ? colorTriggerNoLight : colorTriggerHiLight);
				break;
			case 3:
				result = ((!light) ? colorHoldNoLight : colorHoldHiLight);
				break;
			}
			return result;
		}
	}
}

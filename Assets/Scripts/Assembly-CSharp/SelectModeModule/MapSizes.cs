namespace SelectModeModule
{
	public class MapSizes
	{
		public const int S = 1;

		public const int M = 2;

		public const int L = 3;

		public const int XL = 4;

		public static string ToTitleText(int size)
		{
			return string.Format("{0}:[00FF00]{1}[-]", Localisations.Get("UI_MapSizeTitle"), ToText(size));
		}

		public static string ToText(int size)
		{
			switch (size)
			{
			case 1:
				return Localisations.Get("UI_MapSize1");
			case 2:
				return Localisations.Get("UI_MapSize2");
			case 3:
				return Localisations.Get("UI_MapSize3");
			case 4:
				return Localisations.Get("UI_MapSize4");
			default:
				return "NAN";
			}
		}
	}
}

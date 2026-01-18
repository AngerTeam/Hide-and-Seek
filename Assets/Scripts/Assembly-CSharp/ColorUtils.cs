using System.Globalization;
using UnityEngine;

public class ColorUtils
{
	public static string ColorToHex(Color32 color)
	{
		return color.r.ToString("X2") + color.g.ToString("X2") + color.b.ToString("X2") + color.a.ToString("X2");
	}

	public static Color HexToColor(string hex)
	{
		float num = (int)byte.Parse(hex.Substring(0, 2), NumberStyles.HexNumber);
		float num2 = (int)byte.Parse(hex.Substring(2, 2), NumberStyles.HexNumber);
		float num3 = (int)byte.Parse(hex.Substring(4, 2), NumberStyles.HexNumber);
		float num4 = ((hex.Length != 8) ? 256f : ((float)(int)byte.Parse(hex.Substring(6, 2), NumberStyles.HexNumber)));
		return new Color(num / 255f, num2 / 255f, num3 / 255f, num4 / 255f);
	}
}

using System.Collections.Generic;
using CraftyEngine.Content;

namespace FxModule
{
	public class FxContentMap : ContentMapBase
	{
		public static FxSettingsEntries FxSettings;

		public static Dictionary<int, AnchorsEntries> Anchors;

		public static Dictionary<int, ArtikulFxEntries> ArtikulFx;

		public static Dictionary<int, FxEntries> Fx;

		public static Dictionary<int, MomentsEntries> Moments;

		public override void Deserialize()
		{
			FxContentKeys.Deserialize();
			FxSettings = FillSettings<FxSettingsEntries>("settings");
			Anchors = ReadInt<AnchorsEntries>(FxContentKeys.anchors);
			ArtikulFx = ReadInt<ArtikulFxEntries>(FxContentKeys.artikul_fx);
			Fx = ReadInt<FxEntries>(FxContentKeys.fx);
			Moments = ReadInt<MomentsEntries>(FxContentKeys.moments);
			base.Deserialize();
		}
	}
}

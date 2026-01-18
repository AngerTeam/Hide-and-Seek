using System.Collections.Generic;
using CraftyEngine.Content;

namespace HideAndSeek
{
	public class HideAndSeekContentMap : ContentMapBase
	{
		public static HideSeekSettingsEntries HideSeekSettings;

		public static Dictionary<int, HideVoxelsEntries> HideVoxels;

		public override void Deserialize()
		{
			HideAndSeekContentKeys.Deserialize();
			HideSeekSettings = FillSettings<HideSeekSettingsEntries>("settings");
			HideVoxels = ReadInt<HideVoxelsEntries>(HideAndSeekContentKeys.hide_voxels);
			base.Deserialize();
		}
	}
}

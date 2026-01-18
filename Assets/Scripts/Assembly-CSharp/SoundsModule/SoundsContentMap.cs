using System.Collections.Generic;
using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundsContentMap : ContentMapBase
	{
		public static SoundSettingsEntries SoundSettings;

		public static Dictionary<int, SoundsEntries> Sounds;

		public static Dictionary<int, SoundGroupsEntries> SoundGroups;

		public static Dictionary<int, SoundGroupLinksEntries> SoundGroupLinks;

		public override void Deserialize()
		{
			SoundsContentKeys.Deserialize();
			SoundSettings = FillSettings<SoundSettingsEntries>("settings");
			Sounds = ReadInt<SoundsEntries>(SoundsContentKeys.sounds);
			SoundGroups = ReadInt<SoundGroupsEntries>(SoundsContentKeys.sound_groups);
			SoundGroupLinks = ReadInt<SoundGroupLinksEntries>(SoundsContentKeys.sound_group_links);
			base.Deserialize();
		}
	}
}

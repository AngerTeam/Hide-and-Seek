using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundGroupLinksEntries : ContentItem
	{
		public int id;

		public int group_id;

		public int sound_id;

		public override void Deserialize()
		{
			id = TryGetInt(SoundsContentKeys.id);
			intKey = id;
			group_id = TryGetInt(SoundsContentKeys.group_id);
			sound_id = TryGetInt(SoundsContentKeys.sound_id);
			base.Deserialize();
		}
	}
}

using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundsEntries : ContentItem
	{
		public int id;

		public string title;

		public string filename;

		public string filename_mobile;

		public string GetFullnamePath()
		{
			return SoundsContentKeys.GetFullnamePath18 + filename;
		}

		public string GetFullnameMobilePath()
		{
			return SoundsContentKeys.GetFullnameMobilePath19 + filename_mobile;
		}

		public override void Deserialize()
		{
			id = TryGetInt(SoundsContentKeys.id);
			intKey = id;
			title = TryGetString(SoundsContentKeys.title, string.Empty);
			filename = TryGetString(SoundsContentKeys.filename, string.Empty);
			filename_mobile = TryGetString(SoundsContentKeys.filename_mobile, string.Empty);
			base.Deserialize();
		}
	}
}

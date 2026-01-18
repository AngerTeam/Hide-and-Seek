using CraftyEngine.Content;

namespace ArticulView
{
	public class SkinsEntries : ContentItem
	{
		public int id;

		public string title;

		public int gender;

		public int selectable;

		public int exporter;

		public int hand_anchor;

		public float sort_val;

		public string picture;

		public string preview_picture;

		public string large_icon_preview;

		public int money_type;

		public int money_cnt;

		public int sale_on;

		public string bundle;

		public string GetFullPicturePath()
		{
			return ArticulViewContentKeys.GetFullPicturePath15 + picture;
		}

		public string GetFullPreviewPicturePath()
		{
			return ArticulViewContentKeys.GetFullPreviewPicturePath16 + preview_picture;
		}

		public string GetFullBundlePath()
		{
			return ArticulViewContentKeys.GetFullBundlePath17 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(ArticulViewContentKeys.id);
			intKey = id;
			title = TryGetString(ArticulViewContentKeys.title, string.Empty);
			gender = TryGetInt(ArticulViewContentKeys.gender);
			selectable = TryGetInt(ArticulViewContentKeys.selectable);
			exporter = TryGetInt(ArticulViewContentKeys.exporter);
			hand_anchor = TryGetInt(ArticulViewContentKeys.hand_anchor);
			sort_val = TryGetFloat(ArticulViewContentKeys.sort_val);
			picture = TryGetString(ArticulViewContentKeys.picture, string.Empty);
			preview_picture = TryGetString(ArticulViewContentKeys.preview_picture, string.Empty);
			large_icon_preview = TryGetString(ArticulViewContentKeys.large_icon_preview, string.Empty);
			money_type = TryGetInt(ArticulViewContentKeys.money_type);
			money_cnt = TryGetInt(ArticulViewContentKeys.money_cnt);
			sale_on = TryGetInt(ArticulViewContentKeys.sale_on);
			bundle = TryGetString(ArticulViewContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}

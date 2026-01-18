using CraftyEngine.Content;

namespace NewsModule
{
	public class NewsEntries : ContentItem
	{
		public int id;

		public string adt_title;

		public string adt_text;

		public string news_title;

		public string news_text;

		public string icon;

		public string picture;

		public string link;

		public string news_date;

		public float sort_val;

		public int deploy_on;

		public string GetFullIconPath()
		{
			return NewsContentKeys.GetFullIconPath7 + icon;
		}

		public string GetFullPicturePath()
		{
			return NewsContentKeys.GetFullPicturePath8 + picture;
		}

		public override void Deserialize()
		{
			id = TryGetInt(NewsContentKeys.id);
			intKey = id;
			adt_title = TryGetString(NewsContentKeys.adt_title, string.Empty);
			adt_text = TryGetString(NewsContentKeys.adt_text, string.Empty);
			news_title = TryGetString(NewsContentKeys.news_title, string.Empty);
			news_text = TryGetString(NewsContentKeys.news_text, string.Empty);
			icon = TryGetString(NewsContentKeys.icon, string.Empty);
			picture = TryGetString(NewsContentKeys.picture, string.Empty);
			link = TryGetString(NewsContentKeys.link, string.Empty);
			news_date = TryGetString(NewsContentKeys.news_date, string.Empty);
			sort_val = TryGetFloat(NewsContentKeys.sort_val);
			deploy_on = TryGetInt(NewsContentKeys.deploy_on);
			base.Deserialize();
		}
	}
}

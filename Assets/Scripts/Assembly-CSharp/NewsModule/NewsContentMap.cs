using System.Collections.Generic;
using CraftyEngine.Content;

namespace NewsModule
{
	public class NewsContentMap : ContentMapBase
	{
		public static Dictionary<int, NewsEntries> News;

		public override void Deserialize()
		{
			NewsContentKeys.Deserialize();
			News = ReadInt<NewsEntries>(NewsContentKeys.news);
			base.Deserialize();
		}
	}
}

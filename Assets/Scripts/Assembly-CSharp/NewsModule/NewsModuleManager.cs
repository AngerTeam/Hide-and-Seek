using System;
using CraftyEngine.Content;
using CraftyEngine.Utils;
using HudSystem;

namespace NewsModule
{
	public class NewsModuleManager : Singleton
	{
		private PersistanceUserSettings userSettings_;

		private NewsWindow newsWindow_;

		public static void InitModule(int layer)
		{
			SingletonManager.Add<NewsModuleManager>(layer);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<NewsContentMap>();
			newsWindow_ = GuiModuleHolder.Add<NewsWindow>();
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings_);
			newsWindow_.GenerateInformer();
			newsWindow_.OpenNewsWindow += OnNewsWindowOpen;
		}

		public override void Dispose()
		{
			base.Dispose();
			newsWindow_.OpenNewsWindow -= OnNewsWindowOpen;
		}

		public bool HasNewNews()
		{
			if (NewsContentMap.News == null || NewsContentMap.News.Count == 0)
			{
				return false;
			}
			int lastNewsViewTime = userSettings_.lastNewsViewTime;
			foreach (NewsEntries value in NewsContentMap.News.Values)
			{
				DateTime result;
				if (DateTime.TryParse(value.news_date, out result))
				{
					int num = TimeUtils.DateTimeToUnixTimestamp(result);
					if (lastNewsViewTime < num)
					{
						return true;
					}
				}
				else
				{
					Log.Error("ERROR: Can't parse date = {0}", value.news_date);
				}
			}
			return false;
		}

		private void OnNewsWindowOpen()
		{
			userSettings_.lastNewsViewTime = TimeUtils.DateTimeToUnixTimestamp(DateTime.Now);
			PersistanceManager.Save(userSettings_);
		}
	}
}

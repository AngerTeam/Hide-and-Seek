using HideAndSeekGame;
using InventoryViewModule;

namespace SelectModeModule
{
	public class SelectMapItem : CatalogItem
	{
		public MapItemHierarchy hierarchy;

		public UIWidget[] countIcons;

		public string Description { get; private set; }

		public float Sort { get; private set; }

		public int Id { get; private set; }

		public int MapSize { get; private set; }

		public string Picture { get; private set; }

		public bool Random { get; private set; }

		public string Title { get; private set; }

		public int ModeId { get; private set; }

		public int ViewModeId { get; private set; }

		public int LockedLevel { get; private set; }

		public bool Locked { get; set; }

		public void Init(int modeId, int viewModeId, CommonIslandsEntries entry, string modeTitle = null)
		{
			ModeId = modeId;
			ViewModeId = viewModeId;
			if (entry == null)
			{
				Random = true;
				Id = 0;
				LockedLevel = 0;
				Title = Localisations.Get("UI_GameType_SelectRandomMap");
				Description = Localisations.Get("UI_GameType_SelectRandomMapDiscription");
				if (!string.IsNullOrEmpty(HideAndSeekGameMap.ProjectPictures.RandomMapLargeIcon))
				{
					Picture = HideAndSeekGameMap.GameConstants.PROJECT_PICTURES_CONTENT_PATH + HideAndSeekGameMap.ProjectPictures.RandomMapLargeIcon;
				}
				Sort = float.MinValue;
			}
			else
			{
				Random = false;
				Id = entry.id;
				LockedLevel = entry.level;
				Title = entry.title;
				Description = entry.description;
				MapSize = entry.map_size;
				if (!string.IsNullOrEmpty(entry.large_icon))
				{
					Picture = entry.GetFullLargeIconPath();
				}
				Sort = entry.sort_val;
			}
			if (string.IsNullOrEmpty(Description))
			{
				Description = Title;
			}
			if (modeTitle != null)
			{
				Description = Description.Replace("%gameType%", modeTitle);
			}
		}
	}
}

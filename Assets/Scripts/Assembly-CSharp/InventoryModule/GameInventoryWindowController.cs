using System.Collections.Generic;
using HideAndSeek;
using HudSystem;
using InventoryViewModule;

namespace InventoryModule
{
	public class GameInventoryWindowController : Singleton
	{
		private InventoryWindow inventoryWindow_;

		private int currentLayout_;

		private Dictionary<int, Dictionary<int, bool>> layouts_;

		public void SetLayout(int layout)
		{
			currentLayout_ = layout;
			if (inventoryWindow_ != null)
			{
				inventoryWindow_.SetTabsMode(layouts_[layout]);
			}
		}

		public override void OnDataLoaded()
		{
			layouts_ = new Dictionary<int, Dictionary<int, bool>>();
			layouts_[1] = new Dictionary<int, bool>
			{
				{ 0, true },
				{ 1, true },
				{ 2, true },
				{ 3, false }
			};
			layouts_[0] = new Dictionary<int, bool>
			{
				{ 0, true },
				{ 1, true },
				{ 2, true },
				{ 3, true }
			};
			layouts_[2] = new Dictionary<int, bool>
			{
				{ 0, false },
				{ 1, false },
				{ 2, false },
				{ 3, true }
			};
			layouts_[3] = new Dictionary<int, bool>
			{
				{ 0, true },
				{ 1, true },
				{ 2, false },
				{ 3, false }
			};
			if (SingletonManager.Contains<HideAndSeekModel>())
			{
				inventoryWindow_ = GuiModuleHolder.Add<HideAndSeekInventoryWindow>();
			}
			else
			{
				inventoryWindow_ = GuiModuleHolder.Add<GameInventoryWindow>();
			}
			SetLayout(currentLayout_);
		}
	}
}

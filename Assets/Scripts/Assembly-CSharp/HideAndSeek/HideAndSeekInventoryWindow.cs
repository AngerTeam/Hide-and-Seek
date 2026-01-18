using InventoryViewModule;

namespace HideAndSeek
{
	public class HideAndSeekInventoryWindow : InventorySeparateSlotsWindow
	{
		public HideAndSeekInventoryWindow()
		{
			base.HudState = 40962;
			base.tabs.AddSubWindow<WeaponSubwindow>(0, "UI_Tab_Weapons");
			base.tabs.AddSubWindow<CraftSubwindow>(1, "UI_Tab_Craft");
			base.tabs.AddSubWindow<TempSubwindow>(2, "UI_Tab_Temp");
			base.tabs.AddSubWindow<HideSubwindow>(3, "UI_Tab_Hide");
			base.tabs.ActivateTab(0);
		}
	}
}

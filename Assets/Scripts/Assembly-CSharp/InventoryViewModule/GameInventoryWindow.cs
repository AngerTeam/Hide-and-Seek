namespace InventoryViewModule
{
	public class GameInventoryWindow : InventorySeparateSlotsWindow
	{
		public GameInventoryWindow()
		{
			base.HudState = 40962;
			base.tabs.AddSubWindow<WeaponSubwindow>(0, "UI_Tab_Weapons");
			base.tabs.AddSubWindow<CraftSubwindow>(1, "UI_Tab_Craft");
			base.tabs.AddSubWindow<TempSubwindow>(2, "UI_Tab_Temp");
			base.tabs.ActivateTab(0);
		}
	}
}

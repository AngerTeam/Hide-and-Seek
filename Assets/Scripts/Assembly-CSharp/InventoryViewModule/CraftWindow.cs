using CraftyEngine.Infrastructure;
using NguiTools;
using WindowsModule;

namespace InventoryViewModule
{
	public class CraftWindow : GameWindow
	{
		public CraftSubwindow craftSubwindow_;

		public CraftWindow()
		{
			base.HudState = 40962;
			base.ExclusiveGroup = 1;
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			CraftWindowHierarchy craftWindowHierarchy = singlton.InstantiateNGUIIn<CraftWindowHierarchy>("UICraftWindow", nguiManager.UiRoot.gameObject);
			SetContent(craftWindowHierarchy.transform, false);
			craftSubwindow_ = new CraftSubwindow();
			GameWindow.SetParent(craftSubwindow_.windowHierarchy.transform, craftWindowHierarchy.transform);
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			craftSubwindow_.UpdateVisibility(Visible);
		}

		public override void Clear()
		{
			craftSubwindow_.Clear();
		}
	}
}

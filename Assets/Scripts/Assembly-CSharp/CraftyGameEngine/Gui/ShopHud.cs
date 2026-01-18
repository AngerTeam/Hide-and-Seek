using HudSystem;
using UnityEngine;
using WindowsModule;

namespace CraftyGameEngine.Gui
{
	public class ShopHud : HeadUpDisplay
	{
		private InventoryButtonHierarchy shopButton;

		public ShopHud()
		{
			shopButton = prefabsManager.InstantiateNGUIIn<InventoryButtonHierarchy>("UIShoptButton", nguiManager.UiRoot.TopRightSecondContainer.gameObject);
			hudStateSwitcher.Register(32768, shopButton);
			shopButton.title.text = Localisations.Get("UI_Arsenal");
			ButtonSet.Up(shopButton.button, HandleMarketClick, ButtonSetGroup.Slots);
		}

		private void HandleMarketClick()
		{
			WindowsManagerShortcut.ToggleWindow<IShop>();
		}

		public override void Dispose()
		{
			Object.Destroy(shopButton.gameObject);
		}
	}
}

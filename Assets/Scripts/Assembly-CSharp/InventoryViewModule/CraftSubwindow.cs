using CraftyEngine.Infrastructure;
using HudSystem;
using InventoryModule;
using WindowsModule;

namespace InventoryViewModule
{
	public class CraftSubwindow : GameSubwindow
	{
		public CraftSubwindowHierarchy windowHierarchy;

		private CraftManager craftManager_;

		private CraftController craftSlotController_;

		private UILabel levelRestrictionLabel_;

		private SlotsViewManager slotsViewManager_;

		public CraftSubwindow()
		{
			Build(false);
		}

		public CraftSubwindow(bool isBackpackCraft)
		{
			Build(isBackpackCraft);
		}

		public override void Clear()
		{
			slotsViewManager_.Dispose();
			craftSlotController_.Dispose();
		}

		public void UpdateView()
		{
			windowHierarchy.BackpackScrollview.ResetPosition();
		}

		private void Build(bool isBackpackCraft)
		{
			SingletonManager.Get<CraftManager>(out craftManager_);
			windowHierarchy = prefabsManager_.InstantiateNGUIIn<CraftSubwindowHierarchy>("UICraftSubwindow", nguiManager_.UiRoot.gameObject);
			container = windowHierarchy.gameObject;
			slotsViewManager_ = new SlotsViewManager('r', windowHierarchy.BackpackContentsTable.transform);
			windowHierarchy.RecipeLibraryTitle.text = Localisations.Get("UI_Recipies");
			windowHierarchy.WindowDescription.text = Localisations.Get("UI_CraftWindowDescription");
			craftSlotController_ = new CraftController(windowHierarchy);
			craftManager_.SetResultSlot(craftSlotController_.resultCraftSlot);
			levelRestrictionLabel_ = windowHierarchy.LevelRestrictionLabel;
			ButtonSet.Up(windowHierarchy.RecipeLibraryButton, RecipeLibraryButtonClicked, ButtonSetGroup.InWindow);
			UpdateView();
			base.ViewChanged += HandleViewChanged;
			windowHierarchy.CraftTitle.text = Localisations.Get("UI_LeftSideMenu_Craft");
			windowHierarchy.BackpackTitle.text = Localisations.Get("UI_LeftSideMenu_BackPack");
			craftManager_.StateUpdated += CheckCraftState;
		}

		private void CheckCraftState()
		{
			switch (craftManager_.CraftState)
			{
			case CraftState.Initial:
			case CraftState.CanCraft:
				levelRestrictionLabel_.gameObject.SetActive(false);
				break;
			case CraftState.LevelRestricted:
			{
				string text = Localisations.Get("UI_CraftItemLevelCap");
				if (craftManager_.selectedRecipe != null)
				{
					text = text.Replace("%level%", craftManager_.selectedRecipe.entry.level_min.ToString());
				}
				levelRestrictionLabel_.text = text;
				levelRestrictionLabel_.gameObject.SetActive(true);
				break;
			}
			}
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (base.Visible)
			{
				craftManager_.TryUpdateResult();
				UpdateView();
			}
		}

		private void RecipeLibraryButtonClicked()
		{
			WindowsManagerShortcut.ToggleWindow<RecipeLibraryWindow>();
		}
	}
}

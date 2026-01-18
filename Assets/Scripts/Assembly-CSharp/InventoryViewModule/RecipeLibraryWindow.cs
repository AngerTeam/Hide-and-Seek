using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using HudSystem;
using InventoryModule;

namespace InventoryViewModule
{
	public class RecipeLibraryWindow : CatalogWindow
	{
		private CraftManager craftManager_;

		private bool inited_;

		private Dictionary<int, RecipeModel> recipies_;

		private List<SlotController> slots_;

		public RecipeLibraryWindow()
			: base(false)
		{
			slots_ = new List<SlotController>();
			base.HudState = 40962;
			base.ViewChanged += HandleViewChanged;
			GenerateSlotsButtons();
		}

		public override void Clear()
		{
			base.ViewChanged -= HandleViewChanged;
			base.Clear();
		}

		public void DeselectRecipe()
		{
			windowHierarchy.requiredLabel.text = string.Empty;
			foreach (SlotController item in slots_)
			{
				item.Model.Clear();
			}
		}

		public void UpdateSelectedItemDescription(ushort artikul)
		{
			windowHierarchy.descriptionLabel.text = GetSelectedText(artikul);
		}

		private string GetSelectedText(ushort artikul)
		{
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(artikul, out value))
			{
				return string.Format("{0}: {1}", Localisations.Get("UI_Selected"), value.title);
			}
			return string.Empty;
		}

		private void CraftGhostRecipe(RecipeModel recipeModel)
		{
			craftManager_.SetGhostRecipe(recipeModel);
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void GenerateRecepiesButtons()
		{
			List<RecipeModel> list = new List<RecipeModel>();
			recipies_ = new Dictionary<int, RecipeModel>();
			foreach (RecipeModel value2 in craftManager_.recipes.Values)
			{
				recipies_.Add(value2.RecipeId, value2);
				if (value2.visibleAtOnce)
				{
					list.Add(value2);
				}
			}
			list.Sort((RecipeModel a, RecipeModel b) => a.entry.sort_val.CompareTo(b.entry.sort_val));
			foreach (RecipeModel item in list)
			{
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(item.ArtikulResultId, out value))
				{
					int groupSortId = Convert.ToInt32(item.groupSortValue) - 1;
					AddItem(value.title, value.id, item.RecipeId, groupSortId);
				}
			}
		}

		private void GenerateSlotsButtons()
		{
			SingletonManager.Get<CraftManager>(out craftManager_);
			int slotSizeWorkbenchCraft = InventoryContentMap.CraftSettings.slotSizeWorkbenchCraft;
			int num = (int)Math.Sqrt(slotSizeWorkbenchCraft);
			for (int i = 0; i < num; i++)
			{
				for (int j = 0; j < num; j++)
				{
					SlotModel slotModel = new SlotModel();
					slotModel.x = j;
					slotModel.y = i;
					SlotController slotController = new SlotController(SlotViewType.Normal, slotModel);
					slotController.SetInteractable(false);
					slotController.SetParent(windowHierarchy.recipeConsumablesTable.transform);
					slots_.Add(slotController);
				}
			}
			Recenter();
			windowHierarchy.windowTitleLabel.text = Localisations.Get("UI_RecipeLibrary_Title");
			windowHierarchy.craftNowButtonLabel.text = Localisations.Get("UI_LeftSideMenu_Craft");
			for (int k = 0; k < windowHierarchy.tabButtons.Length; k++)
			{
				int num2 = k;
				UIButton uIButton = windowHierarchy.tabButtons[num2];
				TutorialStorage.Register(uIButton.gameObject, 7, 0, num2);
			}
		}

		protected override void ItemSelect(int id)
		{
			RecipeModel value;
			if (recipies_.TryGetValue(id, out value))
			{
				SetSelectedRecipe(value);
			}
			else
			{
				DeselectRecipe();
			}
			base.ItemSelect(id);
		}

		private void HandleViewChanged(object arg1, BoolEventArguments arg2)
		{
			if (Visible && !inited_)
			{
				GenerateRecepiesButtons();
				DeselectRecipe();
				SelectGroup(0);
				inited_ = true;
			}
		}

		private void SetSelectedRecipe(RecipeModel recipeModel)
		{
			DeselectRecipe();
			GameObjectUtils.SwitchActive(windowHierarchy.craftNowButton.gameObject, false);
			GameObjectUtils.SwitchActive(windowHierarchy.leveLabel.gameObject, false);
			if (recipeModel.recipeBuildings.Count <= 0)
			{
				if (craftManager_.IsLevelRestriction(recipeModel.entry))
				{
					string text = Localisations.Get("UI_CraftItemLevelCap");
					text = text.Replace("%level%", recipeModel.entry.level_min.ToString());
					windowHierarchy.leveLabel.text = text;
					GameObjectUtils.SwitchActive(windowHierarchy.leveLabel.gameObject, true);
				}
				else
				{
					GameObjectUtils.SwitchActive(windowHierarchy.craftNowButton.gameObject, true);
					ButtonSet.Up(windowHierarchy.craftNowButton, delegate
					{
						CraftGhostRecipe(recipeModel);
					}, ButtonSetGroup.InWindow);
				}
			}
			foreach (SlotController item in slots_)
			{
				item.Model.Clear();
				foreach (RecipeItemsEntries recipeItem in recipeModel.recipeItems)
				{
					if (recipeItem.x == item.Model.x && recipeItem.y == item.Model.y)
					{
						item.Model.Insert(recipeItem.artikul_id, recipeItem.artikul_cnt);
						break;
					}
				}
				item.Dirtyfy();
			}
		}
	}
}

using System;
using System.Collections.Generic;
using CraftyEngine.Utils.Unity;
using HudSystem;
using NguiTools;
using WindowsModule;

namespace InventoryViewModule
{
	public abstract class CatalogWindow : GameWindow
	{
		protected bool useTabs_;

		protected RecipeLibraryHierarchy windowHierarchy;

		private List<RecipeLibraryButtonHierarchy> itemButtons_ = new List<RecipeLibraryButtonHierarchy>();

		public int CurrentGroup { get; private set; }

		public event Action<int> GroupSelected;

		public event Action<int> OnItemSelected;

		public CatalogWindow(bool useTabs = true)
		{
			useTabs_ = useTabs;
			windowHierarchy = prefabsManager.InstantiateNGUIIn<RecipeLibraryHierarchy>("UIRecipeLibraryWindow", nguiManager.UiRoot.gameObject);
			SetContent(windowHierarchy.transform, false);
			windowHierarchy.crystalsLabel.text = Localisations.Get("UI_Shop_Available_Crystals_Label");
			if (useTabs_)
			{
				windowHierarchy.tabsWidget.gameObject.SetActive(true);
				for (int i = 0; i < windowHierarchy.tabButtons.Length; i++)
				{
					int groupSortId = i;
					UIButton button = windowHierarchy.tabButtons[groupSortId];
					ButtonSet.Up(button, delegate
					{
						SelectGroup(groupSortId);
					}, ButtonSetGroup.InWindow);
				}
			}
			else
			{
				windowHierarchy.tabsWidget.gameObject.SetActive(false);
			}
		}

		public void ScrollToItem(int itemId, bool select = false)
		{
			foreach (RecipeLibraryButtonHierarchy item in itemButtons_)
			{
				if (item.gameObject.activeSelf && item.itemId == itemId)
				{
					windowHierarchy.centerScrollViewOnChild.CenterOn(item.transform);
					if (select)
					{
						SelectItem(item);
					}
					break;
				}
			}
		}

		protected void Recenter()
		{
			windowHierarchy.centerScrollViewOnChild.Recenter();
			windowHierarchy.recipeConsumablesTable.Reposition();
		}

		protected void SelectGroup(int groupSortId)
		{
			RecipeLibraryButtonHierarchy recipeLibraryButtonHierarchy = null;
			CurrentGroup = groupSortId;
			foreach (RecipeLibraryButtonHierarchy item in itemButtons_)
			{
				bool flag = !useTabs_ || item.groupSortId == CurrentGroup;
				item.selectionToggle.value = false;
				GameObjectUtils.SwitchActive(item.gameObject, flag);
				if (flag && recipeLibraryButtonHierarchy == null)
				{
					recipeLibraryButtonHierarchy = item;
				}
			}
			windowHierarchy.recipesTable.Reposition();
			windowHierarchy.recipesScrollView.ResetPosition();
			if (this.GroupSelected != null)
			{
				this.GroupSelected(CurrentGroup);
			}
			if (recipeLibraryButtonHierarchy != null)
			{
				SelectItem(recipeLibraryButtonHierarchy);
			}
			else
			{
				ItemSelect(0);
			}
		}

		private void SelectItem(RecipeLibraryButtonHierarchy item)
		{
			item.selectionToggle.value = true;
			ItemSelect(item.itemId);
		}

		protected virtual void ItemSelect(int id)
		{
			if (this.OnItemSelected != null)
			{
				this.OnItemSelected(id);
			}
		}

		protected void AddItem(string title, int iconId, int itemId, int groupSortId)
		{
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager);
			RecipeLibraryButtonHierarchy recipeLibraryButtonHierarchy = prefabsManager.InstantiateNGUIIn<RecipeLibraryButtonHierarchy>("UIRecipeLibraryButton", windowHierarchy.recipesTable.gameObject);
			recipeLibraryButtonHierarchy.resultName.text = title;
			recipeLibraryButtonHierarchy.itemId = itemId;
			recipeLibraryButtonHierarchy.groupSortId = groupSortId;
			nguiManager.SetIconSprite(recipeLibraryButtonHierarchy.resultImage, iconId.ToString());
			ButtonSet.Up(recipeLibraryButtonHierarchy.button, delegate
			{
				ItemSelect(itemId);
			}, ButtonSetGroup.InWindow);
			itemButtons_.Add(recipeLibraryButtonHierarchy);
		}
	}
}

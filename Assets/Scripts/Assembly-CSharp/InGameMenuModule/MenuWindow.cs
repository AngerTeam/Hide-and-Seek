using System;
using System.Collections.Generic;
using HudSystem;
using WindowsModule;

namespace InGameMenuModule
{
	public class MenuWindow : GameWindow
	{
		private List<InGameMenuItem> items_;

		private UIWindowWithListHierarchy list_;

		public MenuWindow()
		{
			base.HudState = 41088;
			prefabsManager.Load("InGameMenu");
			list_ = prefabsManager.InstantiateNGUIIn<UIWindowWithListHierarchy>("UIWindowWithList", nguiManager.UiRoot.gameObject);
			list_.grid.cellHeight = 90f;
			list_.grid.cellWidth = 440f;
			items_ = new List<InGameMenuItem>();
		}

		public void SetContentWithBackground()
		{
			SetContent(list_.transform, true, true, false, true, true);
		}

		public void RefreshTitles()
		{
			foreach (InGameMenuItem item in items_)
			{
				item.Text.text = ((item.type != 0) ? item.title : string.Format("{0}: {1}", item.title, GetOnOff(item.toggleState)));
			}
			list_.grid.Reposition();
		}

		public InGameSliderItem AddSlider(string title, float initialValue, float minVal, float maxVal, Action<float> handler, bool usePercentValue = false, bool reversed = false, int width = 200)
		{
			string title2 = Localisations.Get(title);
			UISliderHierarchy sliderHierarchy = prefabsManager.InstantiateNGUIIn<UISliderHierarchy>("UIBaseSlider", list_.grid.gameObject);
			InGameSliderItem sliderItem = new InGameSliderItem(title2, sliderHierarchy, minVal, maxVal, ButtonSetGroup.InWindow, usePercentValue, reversed);
			sliderItem.sliderHierarchy.SetWidth(width);
			float range = maxVal - minVal;
			sliderItem.sliderHierarchy.slider.value = (initialValue - minVal) / range;
			EventDelegate.Add(sliderItem.sliderHierarchy.slider.onChange, delegate
			{
				float obj = minVal + sliderItem.sliderHierarchy.slider.value * range;
				handler(obj);
			});
			handler(initialValue);
			return sliderItem;
		}

		public void AddTitle(string title)
		{
			UILabel uILabel = prefabsManager.InstantiateNGUIIn<UILabel>("UIMenuTitle", list_.grid.gameObject);
			uILabel.text = Localisations.Get(title);
		}

		public InGameMenuItem AddToggle(string title, bool initialValue, Action<bool> handler, int width = 362)
		{
			InGameMenuItem item = new InGameMenuItem(title, InGameMenuItemType.Toggle);
			items_.Add(item);
			item.button = prefabsManager.InstantiateNGUIIn<UIButton>("UIWideButtonGreen", list_.grid.gameObject);
			EventDelegate.Add(item.button.onClick, delegate
			{
				item.toggleState = !item.toggleState;
				item.Text.text = string.Format("{0}: {1}", item.title, GetOnOff(item.toggleState));
				handler(item.toggleState);
			});
			item.toggleState = initialValue;
			item.Text = item.button.GetComponentInChildren<UILabel>();
			item.button.gameObject.GetComponent<UIWidget>().width = width;
			item.button.GetComponent<UIWidget>().depth = 5;
			item.Text.GetComponent<UIWidget>().depth = 6;
			return item;
		}

		public InGameMenuItem AddButton(string title, Action handler, int width = 362)
		{
			InGameMenuItem inGameMenuItem = new InGameMenuItem(title, InGameMenuItemType.Action);
			items_.Add(inGameMenuItem);
			inGameMenuItem.button = prefabsManager.InstantiateNGUIIn<UIButton>("UIWideButtonGreen", list_.grid.gameObject);
			EventDelegate.Add(inGameMenuItem.button.onClick, delegate
			{
				handler();
			});
			inGameMenuItem.Text = inGameMenuItem.button.GetComponentInChildren<UILabel>();
			inGameMenuItem.button.gameObject.GetComponent<UIWidget>().width = width;
			inGameMenuItem.button.GetComponent<UIWidget>().depth = 5;
			inGameMenuItem.Text.GetComponent<UIWidget>().depth = 6;
			return inGameMenuItem;
		}

		protected string GetOnOff(bool value)
		{
			string key = ((!value) ? "UI_InGameMenu_Off" : "UI_InGameMenu_On");
			return Localisations.Get(key);
		}
	}
}

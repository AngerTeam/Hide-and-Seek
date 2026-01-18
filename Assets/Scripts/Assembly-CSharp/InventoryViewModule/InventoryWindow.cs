using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using InventoryModule;
using UnityEngine;
using WindowsModule;

namespace InventoryViewModule
{
	public class InventoryWindow : GameWindow
	{
		public TabsWidgetWithSubwindows tabs { get; protected set; }

		public InventoryWindow()
			: base(false)
		{
			base.ExclusiveGroup = 1;
			base.HudState = 41088;
			tabs = new TabsWidgetWithSubwindows();
			SetContent(tabs.hierarchy.transform, true, true, false, false, true);
			tabs.hierarchy.title.text = Localisations.Get("UI_Inventory_Title");
			tabs.SetSize(1600, 720);
			tabs.hierarchy.background.transform.localPosition = new Vector3(0f, -15f, 0f);
			tabs.hierarchy.contentContainer.bottomAnchor.absolute = 63;
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			tabs.UpdateVisibility(Visible);
		}

		public override void Clear()
		{
			base.Clear();
			base.ViewChanged -= HandleViewChanged;
			tabs.Dispose();
		}

		public void SetTabsMode(Dictionary<int, bool> layout)
		{
			bool flag = true;
			foreach (KeyValuePair<int, bool> item in layout)
			{
				TrySetTabVisible(item.Key, item.Value);
				if (flag && item.Value)
				{
					flag = false;
					tabs.ActivateTab(item.Key);
				}
			}
			tabs.hierarchy.title.gameObject.SetActive(false);
		}

		public bool TrySetTabVisible(int type, bool visible)
		{
			SubWindow value;
			if (tabs.Windows.TryGetValue(type, out value))
			{
				tabs.SetTabVisible(value.tab, visible);
				return true;
			}
			return false;
		}

		public void SetTabVisible(int type, bool visible)
		{
			SubWindow value;
			if (tabs.Windows.TryGetValue(type, out value))
			{
				tabs.SetTabVisible(value.tab, visible);
				return;
			}
			Log.Error("Subwindow {0} not found!", type);
		}

		protected void BlinkTabBySlotType(ArtikulSlotTypeArgs e)
		{
			SubWindow value;
			if (tabs.Windows.TryGetValue(e.type, out value))
			{
				tabs.BlinkTab(value.tab, e.artikulId);
				return;
			}
			Log.Error("Subwindow {0} not found!", e.type);
		}
	}
}

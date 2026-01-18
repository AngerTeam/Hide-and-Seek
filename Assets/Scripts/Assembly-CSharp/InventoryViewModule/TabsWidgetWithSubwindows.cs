using System;
using System.Collections.Generic;
using UnityEngine;
using WindowsModule;

namespace InventoryViewModule
{
	public class TabsWidgetWithSubwindows : TabsWidget
	{
		public Dictionary<int, SubWindow> Windows { get; private set; }

		public TabsWidgetWithSubwindows(Transform parent = null, bool fullscreen = false, bool title = true)
			: base(parent, fullscreen, title)
		{
			Windows = new Dictionary<int, SubWindow>();
			base.TabActivated += HandleTabActivated;
		}

		public override void Dispose()
		{
			foreach (SubWindow value in Windows.Values)
			{
				value.window.Clear();
			}
			Windows.Clear();
			base.Dispose();
		}

		public T AddSubWindow<T>(string title) where T : GameSubwindow, new()
		{
			return AddSubWindow<T>(Windows.Count, title);
		}

		public void AddSubWindow(GameSubwindow gameSubwindow, int type, string title)
		{
			GameWindow.SetParent(gameSubwindow.container.transform, hierarchy.contentContainer.transform);
			SubWindow subWindow = new SubWindow();
			subWindow.window = gameSubwindow;
			subWindow.tab = AddTab(title);
			subWindow.window.container.SetActive(false);
			subWindow.window.UpdateVisibility(false);
			Windows.Add(type, subWindow);
		}

		public T AddSubWindow<T>(int type, string title) where T : GameSubwindow, new()
		{
			T val;
			try
			{
				val = new T();
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
				return (T)null;
			}
			AddSubWindow(val, type, Localisations.Get(title));
			return val;
		}

		public override void UpdateVisibility(bool visible)
		{
			base.UpdateVisibility(visible);
			if (!visible || activeTab_ == null)
			{
				return;
			}
			foreach (SubWindow value in Windows.Values)
			{
				if (value.tab == activeTab_)
				{
					value.window.ReportViewChanged();
					break;
				}
			}
		}

		private void HandleTabActivated(Tab activatedTab)
		{
			foreach (SubWindow value in Windows.Values)
			{
				if (value.tab != activatedTab)
				{
					value.window.UpdateVisibility(false);
				}
			}
			foreach (SubWindow value2 in Windows.Values)
			{
				if (value2.tab == activatedTab)
				{
					value2.window.UpdateVisibility(true);
				}
			}
		}
	}
}

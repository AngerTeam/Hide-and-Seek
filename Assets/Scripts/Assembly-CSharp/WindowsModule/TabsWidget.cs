using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using Extensions;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace WindowsModule
{
	public class TabsWidget : IDisposable
	{
		public TabsDynamicWindowHierarchy hierarchy;

		protected Tab activeTab_;

		private List<Tab> tabs_;

		private PrefabsManagerNGUI prefabsManager_;

		private UnityScreenSizeTracker screenSizeTracker_;

		private UnityEvent unityEvent_;

		private bool resizePending_;

		public event Action<Tab> TabActivated;

		public TabsWidget(Transform parent = null, bool fullscreen = false, bool title = true)
		{
			tabs_ = new List<Tab>();
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			NguiManager singlton;
			SingletonManager.Get<NguiManager>(out singlton);
			SingletonManager.Get<UnityScreenSizeTracker>(out screenSizeTracker_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			prefabsManager_.Load("WindowsModule");
			hierarchy = prefabsManager_.InstantiateIn<TabsDynamicWindowHierarchy>("UITabbedWindow", (!(parent == null)) ? parent : singlton.UiRoot.transform);
			if (fullscreen)
			{
				if (title)
				{
					SetAnchor(singlton.UiRoot.gameObject, 0, 0, 0, -200);
				}
				else
				{
					SetAnchor(singlton.UiRoot.gameObject, 0, 0, 0, -100);
				}
			}
			UIGridFollowsResize component = hierarchy.tabsGrid.GetComponent<UIGridFollowsResize>();
			if (component == null)
			{
				hierarchy.tabsGrid.gameObject.AddComponent<UIGridFollowsResize>();
			}
			hierarchy.tabsGrid.hideInactive = true;
			screenSizeTracker_.ScreenSizeChangedDelayed += Reposition;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public void SetSize(int width, int height)
		{
			hierarchy.background.width = width;
			hierarchy.background.height = height;
			resizePending_ = true;
		}

		private void Update()
		{
			if (resizePending_ && hierarchy != null && hierarchy.background.gameObject.activeInHierarchy)
			{
				hierarchy.background.ResizeCollider();
				resizePending_ = false;
			}
		}

		public void SetAnchor(GameObject ancor, int left, int bottom, int right, int top)
		{
			hierarchy.background.SetAnchor(ancor, left, bottom, right, top);
			resizePending_ = true;
		}

		private void Reposition()
		{
			resizePending_ = true;
			int num = 0;
			for (int i = 0; i < tabs_.Count; i++)
			{
				if (tabs_[i].visible)
				{
					num++;
				}
			}
			hierarchy.tabsGrid.cellWidth = (float)hierarchy.background.width / (float)num;
			hierarchy.tabsGrid.repositionNow = true;
		}

		public virtual void UpdateVisibility(bool visible)
		{
			if (visible)
			{
				if (activeTab_ != null)
				{
					ActivateTab(activeTab_);
				}
				resizePending_ = true;
			}
		}

		public void ActivateTab(int index)
		{
			if (index < tabs_.Count && index >= 0)
			{
				ActivateTab(tabs_[index]);
				return;
			}
			Log.Error("Tab {0} not found!", index);
		}

		public void ActivateTab(Tab tab)
		{
			activeTab_ = tab;
			for (int i = 0; i < tabs_.Count; i++)
			{
				tabs_[i].hierarchy.toggle.gameObject.SetActive(tabs_[i].index == tab.index);
			}
			this.TabActivated.SafeInvoke(tab);
		}

		public Tab AddTab(string title)
		{
			Tab tab = new Tab();
			int count = tabs_.Count;
			tabs_.Add(tab);
			tab.index = count;
			tab.hierarchy = prefabsManager_.InstantiateIn<TabButtonHierarchy>("UITabButton", hierarchy.tabsGrid.transform);
			tab.hierarchy.title.text = title;
			Transform transform = tab.hierarchy.transform.Find("InactiveTab");
			tab.inactive = transform.GetComponent<UISprite>();
			ButtonSet.Up(tab.hierarchy.button, delegate
			{
				HandleButtonPressed(tab);
			}, ButtonSetGroup.InWindow);
			SetTabVisible(tab, true);
			return tab;
		}

		private void HandleButtonPressed(Tab tab)
		{
			ActivateTab(tab);
		}

		public void BlinkTab(Tab tab, int artikulId)
		{
			float num = 3f;
			float num2 = 1f;
			float duration = num2 / num;
			int loops = (int)num * 2;
			tab.hierarchy.title.transform.localScale = Vector3.one;
			tab.hierarchy.title.color = Color.white;
			tab.inactive.color = Color.white;
			DOTween.To(() => tab.hierarchy.title.transform.localScale, delegate(Vector3 s)
			{
				tab.hierarchy.title.transform.localScale = s;
			}, Vector3.one * 1.3f, duration).SetLoops(loops, LoopType.Yoyo).SetEase(Ease.OutQuad);
			DOTween.To(() => tab.hierarchy.title.color, delegate(Color c)
			{
				tab.hierarchy.title.color = c;
			}, new Color(1f, 0.5f, 0f), duration).SetLoops(loops, LoopType.Yoyo).SetEase(Ease.OutQuad);
			DOTween.To(() => tab.inactive.color, delegate(Color c)
			{
				tab.inactive.color = c;
			}, new Color(0f, 1f, 0f), duration).SetLoops(loops, LoopType.Yoyo).SetEase(Ease.OutQuad);
		}

		public void SetTabVisible(Tab tab, bool visible)
		{
			tab.visible = visible;
			tab.hierarchy.gameObject.SetActive(visible);
			Reposition();
		}

		public virtual void Dispose()
		{
			screenSizeTracker_.ScreenSizeChangedDelayed -= Reposition;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			hierarchy = null;
		}
	}
}

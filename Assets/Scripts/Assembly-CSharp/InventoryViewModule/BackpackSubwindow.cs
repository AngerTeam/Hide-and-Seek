using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using InventoryModule;
using WindowsModule;

namespace InventoryViewModule
{
	public class BackpackSubwindow : GameSubwindow, IDisposable
	{
		protected SlotsViewManager slotsViewManager;

		public BackpackSubwindowHierarchy windowHierarchy;

		protected void Init(List<SlotModel> slots)
		{
			Instantiate();
			slotsViewManager = new SlotsViewManager(slots, windowHierarchy.ContentsTable.transform);
			LocalInit();
		}

		protected void Init(char slotType)
		{
			Instantiate();
			slotsViewManager = new SlotsViewManager(slotType, windowHierarchy.ContentsTable.transform);
			LocalInit();
		}

		private void Instantiate(int height = 750)
		{
			windowHierarchy = prefabsManager_.InstantiateNGUIIn<BackpackSubwindowHierarchy>("UIBackpackSubwindow", nguiManager_.UiRoot.gameObject);
			UIWidget component = windowHierarchy.GetComponent<UIWidget>();
			component.height = height;
		}

		private void LocalInit()
		{
			container = windowHierarchy.gameObject;
			slotsViewManager.SetScrollView(windowHierarchy.ScrollView, true);
			UpdateView();
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (base.Visible)
			{
				UpdateView();
			}
		}

		public void UpdateView()
		{
			windowHierarchy.ContentsTable.Reposition();
			windowHierarchy.ScrollView.ResetPosition();
		}

		public override void Clear()
		{
			Dispose();
		}

		public void Dispose()
		{
			slotsViewManager.Dispose();
		}
	}
}

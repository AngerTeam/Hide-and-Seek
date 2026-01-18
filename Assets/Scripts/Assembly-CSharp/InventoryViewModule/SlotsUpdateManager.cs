using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using InventoryModule;
using NguiTools;

namespace InventoryViewModule
{
	public class SlotsUpdateManager : Singleton
	{
		private List<SlotController> slots_;

		private UnityEvent unityEvent_;

		private SlotController lastSelectedSlot_;

		private SlotController lastSplittedSlot_;

		private bool splitting_;

		private NguiManager nguiManager_;

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			for (int i = 0; i < slots_.Count; i++)
			{
				slots_[i].Dispose();
			}
			slots_.Clear();
		}

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			slots_ = new List<SlotController>();
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public void Register(SlotController slot)
		{
			slots_.Add(slot);
		}

		public void Unregister(SlotController slot)
		{
			if (slots_.Contains(slot))
			{
				slots_.Remove(slot);
			}
		}

		private void Update()
		{
			if (nguiManager_.AtlasTexture == null)
			{
				return;
			}
			splitting_ = false;
			for (int i = 0; i < slots_.Count; i++)
			{
				SlotController slotController = slots_[i];
				SlotModel model = slotController.Model;
				bool flag = model.Dirty || (!model.IsEmpty && model.Item.Dirty);
				HandleSelection(slotController);
				if (flag)
				{
					slotController.Redraw();
				}
			}
			for (int j = 0; j < slots_.Count; j++)
			{
				SlotController slotController2 = slots_[j];
				SlotModel model2 = slotController2.Model;
				model2.Dirty = false;
				if (!model2.IsEmpty)
				{
					model2.Item.Dirty = false;
				}
			}
			slots_.IterateAndRemove(TryRemove);
			if (!splitting_ && lastSplittedSlot_ != null)
			{
				lastSplittedSlot_.Split(false);
				lastSplittedSlot_ = null;
			}
		}

		private bool TryRemove(int i)
		{
			if (slots_[i].View.Hierarchy == null)
			{
				slots_[i].Dispose();
				return true;
			}
			return false;
		}

		private void HandleSelection(SlotController controller)
		{
			if (controller.Model.Selected)
			{
				if (lastSelectedSlot_ == null)
				{
					lastSelectedSlot_ = controller;
					controller.Select(true);
				}
				else if (lastSelectedSlot_ != controller)
				{
					lastSelectedSlot_.Select(false);
					lastSelectedSlot_ = controller;
					controller.Select(true);
				}
			}
			if (controller.Model.Splitting)
			{
				splitting_ = true;
				if (lastSplittedSlot_ == null)
				{
					lastSplittedSlot_ = controller;
					controller.Split(true);
				}
				else if (lastSplittedSlot_ != controller)
				{
					lastSplittedSlot_.Split(false);
					lastSplittedSlot_ = controller;
					controller.Split(true);
				}
			}
		}
	}
}

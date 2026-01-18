using System;
using CraftyEngine.Infrastructure;
using Extensions;

namespace InventoryModule
{
	public class SeparateSlotTypeBasedInventory : Singleton, IInventoryLogic, ISingleton
	{
		private InventoryInteractionController inventoryInteractionController_;

		public InventoryModel Model { get; private set; }

		public InvetnoryController Controller { get; private set; }

		public event Action<ArtikulSlotTypeArgs> AttemptToMoveItemToWrongSlotType;

		public override void Init()
		{
			SingletonManager.Get<InventoryInteractionController>(out inventoryInteractionController_);
			Model = SingletonManager.Get<InventoryModel>();
			Controller = SingletonManager.Get<InvetnoryController>();
			inventoryInteractionController_.SlotDragged += HandleSlotDragged;
		}

		public override void Dispose()
		{
			inventoryInteractionController_.SlotDragged -= HandleSlotDragged;
		}

		private void HandleSlotDragged(SlotModel source, SlotModel target)
		{
			if (!source.system && !target.system)
			{
				TryMoveSlot(source, target, source.Amount);
			}
		}

		public SlotMergeStatus CheckStatus(SlotModel sourceSlot, SlotModel targetSlot, int amount)
		{
			int resultAmount;
			return CheckStatus(sourceSlot, targetSlot, amount, out resultAmount);
		}

		public SlotMergeStatus CheckStatus(SlotModel sourceSlot, SlotModel targetSlot, int amount, out int resultAmount)
		{
			resultAmount = 0;
			if (!sourceSlot.Movable || !targetSlot.Movable)
			{
				return SlotMergeStatus.Error;
			}
			bool flag = sourceSlot.Amount == amount;
			if (sourceSlot.IsEmpty || amount <= 0 || amount > sourceSlot.Amount)
			{
				return SlotMergeStatus.Error;
			}
			int artikulId = ((targetSlot.ArtikulId != 0) ? targetSlot.ArtikulId : sourceSlot.ArtikulId);
			bool flag2 = sourceSlot.AllowTake && (sourceSlot.slotType == targetSlot.slotType || IsArtikulMatchesSlot(artikulId, targetSlot.IsTemp, sourceSlot));
			int artikulId2 = ((sourceSlot.ArtikulId != 0) ? sourceSlot.ArtikulId : targetSlot.ArtikulId);
			if (!targetSlot.AllowInsert || (sourceSlot.slotType != targetSlot.slotType && !IsArtikulMatchesSlot(artikulId2, sourceSlot.IsTemp, targetSlot)))
			{
				return SlotMergeStatus.ErrorSlotType;
			}
			if (targetSlot.IsEmpty)
			{
				resultAmount = amount;
				return SlotMergeStatus.Move;
			}
			if (sourceSlot.Item.ArtikulId == targetSlot.Item.ArtikulId)
			{
				if (targetSlot.Entry.stack_size == 1)
				{
					return SlotMergeStatus.Swap;
				}
				int num = targetSlot.Entry.stack_size - targetSlot.Amount;
				resultAmount = ((num >= amount) ? amount : num);
				if (resultAmount > 0)
				{
					return SlotMergeStatus.Merge;
				}
				return SlotMergeStatus.ErrorFull;
			}
			if (flag && flag2)
			{
				return (!targetSlot.IsEmpty) ? SlotMergeStatus.Swap : SlotMergeStatus.Move;
			}
			return SlotMergeStatus.Error;
		}

		private bool IsArtikulMatchesSlot(int artikulId, bool isTemp, SlotModel slot)
		{
			ArtikulsEntries value;
			if (!InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
			{
				return false;
			}
			switch (Controller.GetArtikulSlotType(value, isTemp))
			{
			case 0:
				return slot.slotType == 'w' || slot.slotType == 'p' || slot.slotType == 'r' || slot.slotType == '*';
			case 1:
				return slot.slotType == 'r' || slot.slotType == 'c' || slot.slotType == '*';
			case 2:
				return slot.slotType == 't' || slot.slotType == 'p';
			default:
				return false;
			}
		}

		public bool TryMoveSlot(SlotModel slotA, SlotModel slotB, int count)
		{
			int resultAmount;
			switch (CheckStatus(slotA, slotB, count, out resultAmount))
			{
			case SlotMergeStatus.Move:
			case SlotMergeStatus.Merge:
				Controller.MoveSlot(slotA, slotB, resultAmount);
				return true;
			case SlotMergeStatus.Swap:
				Controller.SwapSlots(slotA, slotB);
				return true;
			case SlotMergeStatus.ErrorSlotType:
			{
				int artikulSlotType = Controller.GetArtikulSlotType(slotA.ArtikulId, slotA.IsTemp);
				this.AttemptToMoveItemToWrongSlotType.SafeInvoke(new ArtikulSlotTypeArgs(artikulSlotType, 0));
				return false;
			}
			default:
				MessageBroadcaster.ReportInfo("UI_UnsupportedSlotAction", 0f);
				return false;
			}
		}

		public bool GetFirstAvailableSlot(int articulId, int amount, bool isTemp, out SlotModel slot)
		{
			return GetFirstAvailableSlot(new ArtikulItem(articulId, amount, 0, isTemp), out slot);
		}

		public bool GetFirstAvailableSlot(ArtikulItem item, out SlotModel slot)
		{
			int artikulSlotType = Controller.GetArtikulSlotType(item.Entry, item.IsTemp);
			char[] slotCodes = new char[0];
			switch (artikulSlotType)
			{
			case 0:
				slotCodes = new char[2] { 'p', 'w' };
				break;
			case 1:
				slotCodes = new char[2] { 'r', 'c' };
				break;
			case 2:
				slotCodes = new char[2] { 'p', 't' };
				break;
			}
			if (GetFirstAvailableSlot(slotCodes, item, out slot))
			{
				return true;
			}
			return false;
		}

		public bool TryAddToPanelOrBackpack(SlotModel source, out SlotModel result)
		{
			return TryAddToPanelOrBackpack(source.Item, out result);
		}

		public bool TryAddToPanelOrBackpack(int articulId, int count, out SlotModel slot, bool isTemp = true)
		{
			ArtikulItem item = new ArtikulItem(articulId, count, 0, isTemp);
			return TryAddToPanelOrBackpack(item, out slot);
		}

		public bool TryAddToPanelOrBackpack(ArtikulItem item)
		{
			SlotModel slot;
			return TryAddToPanelOrBackpack(item, out slot);
		}

		public bool TryAddToPanelOrBackpack(ArtikulItem item, out SlotModel slot)
		{
			if (GetFirstAvailableSlot(item, out slot))
			{
				slot.Append(item);
				return true;
			}
			slot = null;
			return false;
		}

		public bool GetFirstAvailableSlot(char[] slotCodes, ArtikulItem item, out SlotModel slot)
		{
			for (int i = 0; i < slotCodes.Length; i++)
			{
				if (GetFirstAvailableSlot(slotCodes[i], item, out slot))
				{
					return true;
				}
			}
			slot = null;
			return false;
		}

		public bool GetFirstAvailableSlot(char slotCode, ArtikulItem item, out SlotModel slot)
		{
			if (item.Amount > item.AmountMax)
			{
				slot = null;
				return false;
			}
			foreach (SlotModel item2 in Model.Slots[slotCode])
			{
				if (!item2.IsEmpty && item2.Item.ArtikulId == item.ArtikulId)
				{
					int num = item2.Amount + item.Amount;
					if (num <= item2.Entry.stack_size)
					{
						slot = item2;
						return true;
					}
				}
			}
			foreach (SlotModel item3 in Model.Slots[slotCode])
			{
				if (item3.IsEmpty)
				{
					slot = item3;
					return true;
				}
			}
			slot = null;
			return false;
		}

		public void InitSlotGroups()
		{
			Controller.AddSlotsGroup('w', InventoryContentMap.CraftSettings.slotSize);
			Controller.AddSlotsGroup('r', InventoryContentMap.CraftSettings.slotSize);
			Controller.AddSlotsGroup('t', InventoryContentMap.CraftSettings.slotSize);
			Controller.AddSlotsGroup('p', InventoryContentMap.CraftSettings.slotSizeBelt);
			Controller.AddSlotsGroup('c', InventoryContentMap.CraftSettings.slotSizeWorkbenchCraft, true);
		}
	}
}

using System;
using System.Collections.Generic;
using Extensions;
using RemoteData;
using SyncOnlineModule;

namespace BankModule
{
	public class BroadPurchaseOnline : Singleton
	{
		private bool syncRecieved_;

		private int lastMoneyValue_;

		public Queue<PurchaseItem> PurchaseItems { get; private set; }

		public event Action PurchaseItemsUpdated;

		public event Action<BonusItemMessage[]> BonusesUpdated;

		public event Action<HideVoxelsMessage[]> HideVoxelsUpdated;

		public event Action<MoneyMessage[]> MoneyUpdated;

		public event Action<SkinsMessage[]> SkinsUpdated;

		public event Action<SlotMessage[]> SlotsUpdated;

		public void ExtractPurchaseItems(PurchaseMessage message, bool gift = false)
		{
			if (PurchaseItems == null)
			{
				PurchaseItems = new Queue<PurchaseItem>();
			}
			if (message.money != null && message.money.Length > 0)
			{
				lastMoneyValue_ = message.money[0].money;
			}
			if (message.hideVoxelUpdate != null)
			{
				for (int i = 0; i < message.hideVoxelUpdate.Length; i++)
				{
					PurchaseItem item = new PurchaseItem(message.hideVoxelUpdate[i].voxelId, gift, PurchaseItemType.Voxel);
					PurchaseItems.Enqueue(item);
				}
			}
			if (message.slotUpdate != null)
			{
				for (int j = 0; j < message.slotUpdate.Length; j++)
				{
					PurchaseItem item2 = new PurchaseItem(message.slotUpdate[j].artikulId, gift, PurchaseItemType.Artikul);
					PurchaseItems.Enqueue(item2);
				}
			}
			if (message.moneyUpdate != null)
			{
				for (int k = 0; k < message.moneyUpdate.Length; k++)
				{
					if (message.moneyUpdate[k].money > lastMoneyValue_)
					{
						lastMoneyValue_ = message.moneyUpdate[k].money;
						PurchaseItem item3 = new PurchaseItem(-1, gift, PurchaseItemType.Money);
						PurchaseItems.Enqueue(item3);
					}
				}
			}
			if (PurchaseItems.Count > 1)
			{
				PurchaseItems.Clear();
				PurchaseItems.Enqueue(new PurchaseItem(-1, gift, PurchaseItemType.Multi));
			}
			this.PurchaseItemsUpdated.SafeInvoke();
		}

		public void AddPurchaseItem(int id, bool gift, PurchaseItemType type)
		{
			if (PurchaseItems == null)
			{
				PurchaseItems = new Queue<PurchaseItem>();
			}
			PurchaseItem item = new PurchaseItem(id, gift, type);
			PurchaseItems.Enqueue(item);
			this.PurchaseItemsUpdated.SafeInvoke();
		}

		public void Report(PurchaseMessage message)
		{
			if (message != null)
			{
				TryReport(message.bonusItems, this.BonusesUpdated);
				TryReport(message.money, this.MoneyUpdated);
				TryReport(message.skins, this.SkinsUpdated);
				TryReport(message.hideVoxels, this.HideVoxelsUpdated);
				TryReport(message.moneyUpdate, this.MoneyUpdated);
				TryReport(message.slotUpdate, this.SlotsUpdated);
				TryReport(message.hideVoxelUpdate, this.HideVoxelsUpdated);
			}
		}

		public override void OnSyncRecieved()
		{
			PurchaseMessage message;
			if (!SyncManager.TryRead<PurchaseMessage>(out message))
			{
				return;
			}
			TryReport(message.bonusItems, this.BonusesUpdated);
			if (!syncRecieved_)
			{
				syncRecieved_ = true;
				TryReport(message.money, this.MoneyUpdated);
				if (message.money != null && message.money.Length != 0)
				{
					lastMoneyValue_ = message.money[0].money;
				}
			}
			TryReport(message.skins, this.SkinsUpdated);
			TryReport(message.hideVoxels, this.HideVoxelsUpdated);
		}

		private void TryReport<T>(T[] arr, Action<T[]> action)
		{
			if (arr != null && arr.Length > 0)
			{
				if (action == null)
				{
					Log.Warning("No subscriber for {0} is provided!", typeof(T));
				}
				else
				{
					action(arr);
				}
			}
		}
	}
}

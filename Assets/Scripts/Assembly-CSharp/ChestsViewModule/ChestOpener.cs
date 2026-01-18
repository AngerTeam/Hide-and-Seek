using System.Collections.Generic;
using BankModule;
using CraftyEngine.Infrastructure;
using InventoryModule;
using RemoteData;

namespace ChestsViewModule
{
	public class ChestOpener : Singleton
	{
		public SelectedChestWindow selectedChestWindow;

		private UnityEvent unityEvent_;

		private BroadPurchaseOnline broadPurchaseOnline_;

		public override void OnDataLoaded()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_, 1);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			broadPurchaseOnline_.BonusesUpdated += OnBonusesUpdated;
			selectedChestWindow = new SelectedChestWindow();
			unityEvent_.Subscribe(UnityEventType.ApplicationFocus, OnFocusChanged);
		}

		private void OnBonusesUpdated(BonusItemMessage[] bonusItems)
		{
			List<BonusItem> list = new List<BonusItem>();
			if (bonusItems != null)
			{
				foreach (BonusItemMessage bonusItemMessage in bonusItems)
				{
					list.Add(new BonusItem(bonusItemMessage.typeId, bonusItemMessage.field, bonusItemMessage.value, bonusItemMessage.value2, 0));
				}
			}
			selectedChestWindow.RewardsReady(list);
		}

		private void OnFocusChanged()
		{
			if (CompileConstants.MOBILE && !CompileConstants.EDITOR && selectedChestWindow.Visible)
			{
				selectedChestWindow.ToggleWindow();
			}
		}

		public void CreateAndOpenChest(ArtikulsEntries articul)
		{
			if (articul.type_id == 5)
			{
				RewardChest rewardChest = new RewardChest();
				rewardChest.artikulId = articul.id;
				rewardChest.artikul = articul;
				rewardChest.itemName = articul.title;
				rewardChest.iconPath = articul.GetFullLargeIconPath();
				rewardChest.state = RewardChestState.Taking;
				rewardChest.type = RewardChestType.Instant;
				selectedChestWindow.OpenWindow(rewardChest);
			}
		}

		public override void Dispose()
		{
			broadPurchaseOnline_.BonusesUpdated -= OnBonusesUpdated;
			selectedChestWindow.Dispose();
			selectedChestWindow = null;
		}
	}
}

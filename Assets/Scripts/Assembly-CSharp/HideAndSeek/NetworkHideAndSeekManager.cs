using BankModule;
using PlayerModule.MyPlayer;
using RemoteData;
using SyncOnlineModule;

namespace HideAndSeek
{
	public class NetworkHideAndSeekManager : Singleton
	{
		private HideAndSeekModel hideVoxelsModel_;

		private BroadPurchaseOnline broadPurchaseOnline_;

		private IHideAndSeekShopOnline shopOnline_;

		private MyPlayerStatsModel playerModel_;

		public override void OnDataLoaded()
		{
			SingletonManager.Get<HideAndSeekModel>(out hideVoxelsModel_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			SingletonManager.Get<IHideAndSeekShopOnline>(out shopOnline_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			broadPurchaseOnline_.HideVoxelsUpdated += HandleHideVoxelsUpdated;
			hideVoxelsModel_.BuyClicked += HandleBuyClicked;
			shopOnline_.BuyHideVoxelReceived += HandleBuyHideVoxelReceived;
		}

		public override void Dispose()
		{
			broadPurchaseOnline_.HideVoxelsUpdated -= HandleHideVoxelsUpdated;
			hideVoxelsModel_.BuyClicked -= HandleBuyClicked;
			shopOnline_.BuyHideVoxelReceived -= HandleBuyHideVoxelReceived;
		}

		public override void OnSyncRecieved()
		{
			PurchaseMessage message;
			if (SyncManager.TryRead<PurchaseMessage>(out message) && message.hideVoxels != null)
			{
				HandleHideVoxelsUpdated(message.hideVoxels);
			}
		}

		private void HandleBuyHideVoxelReceived(RemoteMessageEventArgs obj)
		{
			PurchaseMessage message = obj.remoteMessage as PurchaseMessage;
			broadPurchaseOnline_.Report(message);
			broadPurchaseOnline_.ExtractPurchaseItems(message);
		}

		private void HandleBuyClicked(int hideVoxelId, int? count)
		{
			HideVoxelsEntries hideVoxelsEntries = HideAndSeekContentMap.HideVoxels[hideVoxelId];
			int num = hideVoxelsEntries.money_cnt;
			if (count.HasValue)
			{
				num *= count.Value;
			}
			if (playerModel_.money.GetMoneyAmount(hideVoxelsEntries.money_type) < num)
			{
				playerModel_.money.ReportInsufficientMoney(hideVoxelsEntries.money_type);
			}
			else
			{
				shopOnline_.SendBuyHideVoxel(hideVoxelId, count);
			}
		}

		private void HandleHideVoxelsUpdated(HideVoxelsMessage[] obj)
		{
			foreach (HideVoxelsMessage hideVoxelsMessage in obj)
			{
				hideVoxelsModel_.SetAmount(hideVoxelsMessage.voxelId, hideVoxelsMessage.count);
				if (hideVoxelsMessage.voxelId == playerModel_.stats.hideAndSeek.HideVoxelId)
				{
					if (hideVoxelsMessage.count == 0)
					{
						playerModel_.stats.hideAndSeek.HideVoxelId = hideVoxelsModel_.DefaultHideVoxel.id;
					}
					else
					{
						playerModel_.stats.hideAndSeek.ReportSelectedHideVoxelChanged();
					}
				}
			}
		}
	}
}

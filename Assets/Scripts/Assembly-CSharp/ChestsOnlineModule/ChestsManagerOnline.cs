using BankModule;
using ChestsViewModule;
using RemoteData;
using RemoteData.Lua;

namespace ChestsOnlineModule
{
	public class ChestsManagerOnline : Singleton
	{
		private ChestsOnlineController chestsOnlineController_;

		private ChestsManagerBase chestsManagerBase_;

		private BroadPurchaseOnline broadPurchaseOnline_;

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<ChestsOnlineController>(out chestsOnlineController_);
			SingletonManager.Get<ChestsManagerBase>(out chestsManagerBase_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			chestsManagerBase_.SendOpenAssassinsChest += SendOpenAssassinsChest;
			chestsManagerBase_.SendOpenChest += SendOpenChest;
			chestsManagerBase_.SendStartChest += SendStartChest;
			chestsOnlineController_.StartChestResponseReceived += OnStartChestResponse;
			chestsOnlineController_.OpenChestResponseReceived += OnOpenChestResponce;
			chestsOnlineController_.OpenAssassinsChestResponseReceived += OnOpenChestResponce;
			chestsOnlineController_.OpenAdsChestResponseReceived += OnOpenChestResponce;
		}

		private void OnOpenChestResponce(RemoteMessageEventArgs obj)
		{
			PurchaseMessage message = obj.remoteMessage as PurchaseMessage;
			broadPurchaseOnline_.Report(message);
			broadPurchaseOnline_.ExtractPurchaseItems(message);
		}

		private void SendOpenAssassinsChest()
		{
			chestsOnlineController_.SendOpenAssassinsChest();
		}

		private void SendOpenChest(int slotId, int boostPrice)
		{
			chestsOnlineController_.SendOpenChest(slotId, boostPrice);
		}

		private void SendStartChest(int slotId)
		{
			chestsOnlineController_.SendStartChest(slotId);
		}

		private void OnStartChestResponse(RemoteMessageEventArgs args)
		{
			ChestStartResponse chestStartResponse = args.remoteMessage as ChestStartResponse;
			if (chestStartResponse != null)
			{
				chestsManagerBase_.StartOpeningChest((int)chestStartResponse.startTime);
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			chestsOnlineController_.StartChestResponseReceived -= OnStartChestResponse;
		}
	}
}

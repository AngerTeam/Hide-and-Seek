using BankModule;
using CraftyGameEngine.Gui;
using CraftyNetworkEngine;
using HudSystem;
using PlayerModule.MyPlayer;
using RemoteData;
using ShopModule;

namespace CraftyMultiplayerEngine
{
	public class NetworkShopManager : Singleton
	{
		protected BroadPurchaseOnline broadPurchaseOnline_;

		private MyPlayerStatsModel playerDataManager_;

		private IShopOnline shopOnline_;

		public override void Init()
		{
			SingletonManager.Get<IShopOnline>(out shopOnline_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerDataManager_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			shopOnline_.BuyArticulReceived += HandleBuyResponceReceived;
			shopOnline_.AdViewReceived += HandleBuyResponceReceived;
			shopOnline_.BuySkinReceived += HandleBuyResponceReceived;
		}

		private void HandleBuyResponceReceived(RemoteMessageEventArgs obj)
		{
			PurchaseMessage message = obj.remoteMessage as PurchaseMessage;
			broadPurchaseOnline_.Report(message);
			broadPurchaseOnline_.ExtractPurchaseItems(message);
		}

		public override void OnDataLoaded()
		{
			IShop module;
			if (GuiModuleHolder.TryGet<IShop>(out module))
			{
				module.OnBuy += BuyArtikul;
			}
		}

		public void BuyArtikul(ShopItemsEntries shopItemsEntry)
		{
			if (playerDataManager_.money.GetMoneyAmount(shopItemsEntry.money_type) >= shopItemsEntry.money_cnt)
			{
				CheckIfChest(shopItemsEntry.artikulId);
				shopOnline_.SendBuyArtikul(shopItemsEntry.artikulId);
			}
			else
			{
				playerDataManager_.money.ReportInsufficientMoney(shopItemsEntry.money_type);
			}
		}

		protected virtual void CheckIfChest(int artikulId)
		{
		}

		public override void Dispose()
		{
			IShop module;
			if (GuiModuleHolder.TryGet<IShop>(out module))
			{
				module.OnBuy -= BuyArtikul;
			}
		}
	}
}

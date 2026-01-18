using Authorization;
using RemoteData.Lua;

namespace BankModule
{
	public class PurchasesDataManager : Singleton
	{
		private PurchaseDataSaver purchaseDataSaver_;

		private HttpBankOnline httpBankOnline_;

		public override void Init()
		{
			SingletonManager.Get<PurchaseDataSaver>(out purchaseDataSaver_);
			SingletonManager.Get<HttpBankOnline>(out httpBankOnline_);
			httpBankOnline_.PurchaseResponseReceived += OnPurchaseResponseReceived;
		}

		private void OnPurchaseResponseReceived(RemoteMessageEventArgs args)
		{
			PurchaseResponse purchaseResponse = args.remoteMessage as PurchaseResponse;
			if (purchaseResponse != null)
			{
				purchaseDataSaver_.RemovePurchase(purchaseResponse.orderId);
			}
		}

		public override void OnSyncRecieved()
		{
			SendAllPurchases();
		}

		public void SendAllPurchases()
		{
			foreach (PurchaseSaveData purchase in purchaseDataSaver_.Purchases)
			{
				SendPurchase(purchase);
			}
		}

		public void TrySendPurchase(string pf, string orderId, string inapp, string currency, double price, int money, string signature, string purchaseData)
		{
			PurchaseSaveData purchaseSaveData = new PurchaseSaveData();
			purchaseSaveData.pf = pf;
			purchaseSaveData.orderId = orderId;
			purchaseSaveData.inapp = inapp;
			purchaseSaveData.currency = currency;
			purchaseSaveData.price = price;
			purchaseSaveData.money = money;
			purchaseSaveData.signature = signature;
			purchaseSaveData.purchaseData = purchaseData;
			purchaseDataSaver_.AddPurchase(purchaseSaveData);
			SendPurchase(purchaseSaveData);
		}

		private void SendPurchase(PurchaseSaveData purchase)
		{
			HttpOnlineModel singlton;
			SingletonManager.Get<HttpOnlineModel>(out singlton);
			AuthorizationModel singlton2;
			SingletonManager.Get<AuthorizationModel>(out singlton2);
			int? notFromStore = null;
			if (!singlton2.isInstalledFromStore)
			{
				notFromStore = 1;
			}
			httpBankOnline_.SendPurchaseRequest(purchase.pf, singlton.userId.ToString(), purchase.orderId, purchase.inapp, purchase.currency, purchase.price, purchase.money, purchase.signature, purchase.purchaseData, notFromStore);
		}

		public override void Dispose()
		{
			httpBankOnline_.PurchaseResponseReceived -= OnPurchaseResponseReceived;
		}
	}
}

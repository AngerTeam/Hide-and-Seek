using PlayerModule.MyPlayer;
using RemoteData;
using RemoteData.Lua;

namespace BankModule
{
	public class NetworkBankManager : Singleton
	{
		private IBankOnline bankOnline_;

		private BroadPurchaseOnline broadPurchaseOnline_;

		private MyPlayerStatsModel model_;

		public static void InitBank(int layer)
		{
			SingletonManager.Add<BroadPurchaseOnline>(layer);
			SingletonManager.AddAlias<HttpBankOnline, IBankOnline>(layer);
			SingletonManager.Add<NetworkBankManager>(layer);
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			SingletonManager.Get<IBankOnline>(out bankOnline_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			bankOnline_.PurchaseResponseReceived += HanlePurchaseResponseReceived;
			broadPurchaseOnline_.MoneyUpdated += HandleMoneyUpdated;
		}

		private void HandleMoneyUpdated(MoneyMessage[] moneyUpdateMessages)
		{
			foreach (MoneyMessage moneyMessage in moneyUpdateMessages)
			{
				model_.money.SetMoneyAmount(moneyMessage.moneyType, moneyMessage.money);
			}
		}

		private void HanlePurchaseResponseReceived(RemoteMessageEventArgs obj)
		{
			PurchaseResponse message = obj.remoteMessage as PurchaseResponse;
			broadPurchaseOnline_.Report(message);
			broadPurchaseOnline_.ExtractPurchaseItems(message);
		}
	}
}

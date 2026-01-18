using System;
using HttpNetwork;
using PlayerModule.MyPlayer;
using RemoteData.Lua;
using SyncOnlineModule;

namespace BankModule
{
	public class HttpBankOnline : Singleton, IBankOnline, ISingleton
	{
		private HttpOnlineManager http_;

		public event Action<RemoteMessageEventArgs> PurchaseResponseReceived;

		public event Action<RemoteMessageEventArgs> MaintenanceCheckReceived;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.common != null && message.common != null)
			{
				MyPlayerStatsModel singlton;
				SingletonManager.Get<MyPlayerStatsModel>(out singlton);
				singlton.money.IsPayer = BitMath.GetBit((byte)message.common.userFlags, 1);
			}
		}

		public void SendPurchaseRequest(string pf, string udid, string orderId, string inapp, string currency, double price, int money, string signature, string purchaseData, int? notFromStore)
		{
			PurchaseLuaCommand purchaseLuaCommand = new PurchaseLuaCommand(pf, udid, orderId, inapp, currency, price, 2, money, purchaseData);
			purchaseLuaCommand.notFromStore = notFromStore;
			purchaseLuaCommand.signature = signature;
			http_.Send<PurchaseResponse>(purchaseLuaCommand, this.PurchaseResponseReceived);
		}

		public void SendMaintenanceCheck()
		{
			http_.Send<MaintenanceCheckResponse>(new MaintenanceCheckLuaCommand(), this.MaintenanceCheckReceived);
		}
	}
}

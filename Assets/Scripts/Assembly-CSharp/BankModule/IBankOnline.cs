using System;

namespace BankModule
{
	public interface IBankOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> PurchaseResponseReceived;

		event Action<RemoteMessageEventArgs> MaintenanceCheckReceived;

		void SendPurchaseRequest(string pf, string udid, string orderId, string inapp, string currency, double price, int money, string signature, string purchaseData, int? notFromStore);

		void SendMaintenanceCheck();
	}
}

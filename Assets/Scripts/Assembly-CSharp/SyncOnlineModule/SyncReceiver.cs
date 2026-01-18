using BankModule;
using RemoteData.Lua;

namespace SyncOnlineModule
{
	public class SyncReceiver : Singleton
	{
		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.main != null && message.main.Length > 0)
			{
				if (!DataStorage.isAdmin)
				{
					DataStorage.isAdmin = BitMath.GetBit((byte)message.main[0].flags, 0);
				}
				BroadPurchaseOnline broadPurchaseOnline = SingletonManager.Get<BroadPurchaseOnline>();
				broadPurchaseOnline.Report(message);
			}
		}
	}
}

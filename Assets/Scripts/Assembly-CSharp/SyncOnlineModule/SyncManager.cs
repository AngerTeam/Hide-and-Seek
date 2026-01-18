using CraftyEngine.Infrastructure.SingletonManagerCore;
using Interlace.Amf;
using RemoteData;

namespace SyncOnlineModule
{
	public class SyncManager : Singleton
	{
		public bool reportOnNextUpdate;

		public AmfObject SyncObject { get; private set; }

		public AmfObject PlayerSyncObject { get; private set; }

		public void SetObject(AmfObject syncObject, bool lua)
		{
			SyncObject = syncObject;
			PlayerSyncObject = (AmfObject)syncObject.Properties["player"];
			if (reportOnNextUpdate)
			{
				reportOnNextUpdate = false;
				Report();
			}
		}

		public void Report(int? layer = null)
		{
			if (layer.HasValue)
			{
				SingletonManager.InitiatePhase(SingletonPhase.Sync, layer.Value);
			}
			else
			{
				SingletonManager.InitiatePhase(SingletonPhase.Sync);
			}
		}

		public static bool TryRead<T>(out T message) where T : RemoteMessage, new()
		{
			SyncManager syncManager = SingletonManager.Get<SyncManager>();
			return RemoteMessage.TryRead<T>(syncManager.PlayerSyncObject, out message);
		}
	}
}

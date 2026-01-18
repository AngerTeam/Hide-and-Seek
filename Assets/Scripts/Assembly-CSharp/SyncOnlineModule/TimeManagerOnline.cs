using CraftyEngine.Infrastructure;
using RemoteData.Lua;

namespace SyncOnlineModule
{
	public class TimeManagerOnline : Singleton
	{
		private TimeManager timeManager_;

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.common != null)
			{
				SingletonManager.Get<TimeManager>(out timeManager_);
				timeManager_.SetTime((int)message.common.serverTime);
			}
		}
	}
}

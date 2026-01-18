using RemoteData.Lua;
using SyncOnlineModule;

namespace ChestsOnlineModule
{
	public class ChestsSocketsManagerOnline : Singleton
	{
		public override void OnSyncRecieved()
		{
			PlayerChestsSyncMessage message;
			if (!SyncManager.TryRead<PlayerChestsSyncMessage>(out message) || message.chestSlots == null)
			{
				return;
			}
			int num = 0;
			ChestSlotsMessage[] chestSlots = message.chestSlots;
			foreach (ChestSlotsMessage chestSlotsMessage in chestSlots)
			{
				if (chestSlotsMessage.artikulId != 0)
				{
					num++;
				}
			}
			DataStorage.rewardChestsCount = num;
		}
	}
}

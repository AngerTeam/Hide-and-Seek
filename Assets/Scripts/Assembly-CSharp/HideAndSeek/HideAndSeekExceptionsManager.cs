using CraftyVoxelEngine;
using ExceptionsModule;
using Interlace.Amf;
using PlayerModule.MyPlayer;
using RemoteData;
using RemoteData.Socket;

namespace HideAndSeek
{
	public class HideAndSeekExceptionsManager : Singleton
	{
		private ExceptionsManager exceptionsManager_;

		private MyPlayerStatsModel myPlayer_;

		private HideAndSeekNetworkCombatController combatController_;

		public override void Init()
		{
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayer_);
			SingletonManager.Get<HideAndSeekNetworkCombatController>(out combatController_);
			exceptionsManager_.AddHandler(Hanlder, 1100);
		}

		private bool Hanlder(ExceptionArgs args)
		{
			if (myPlayer_.stats.hideAndSeek != null && myPlayer_.stats.hideAndSeek.IsHidden)
			{
				AmfObject source = args.data as AmfObject;
				VoxelMessage message;
				if (RemoteMessage.TryRead<VoxelMessage>(source, out message))
				{
					VoxelKey other = new VoxelKey(message.x, message.y, message.z);
					if (myPlayer_.stats.hideAndSeek.HidePosition.Equals(other))
					{
						combatController_.silent = true;
						myPlayer_.stats.hideAndSeek.Appear();
						combatController_.silent = false;
						Exc.Report(3202);
						return true;
					}
				}
			}
			return false;
		}

		public override void Dispose()
		{
			exceptionsManager_.RemoveHandler(Hanlder);
		}
	}
}

using System;
using Extensions;
using PlayerModule;
using PlayerModule.MyPlayer;
using RemoteData.Socket;

namespace CraftyNetworkEngine
{
	public abstract class NetworkBasicPlayersManager : Singleton
	{
		protected PlayerModelsHolder holder;

		protected MyPlayerStatsModel myPlayerStatsModel;

		protected GameModel gameModel;

		public static event Action<TeamDataMessage[], int> StatsRecieved;

		public override void Init()
		{
			SingletonManager.Get<GameModel>(out gameModel);
			SingletonManager.Get<PlayerModelsHolder>(out holder);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel);
		}

		public void UpdateMembers(MemberMessage[] members)
		{
			if (members == null)
			{
				return;
			}
			foreach (MemberMessage memberMessage in members)
			{
				PlayerStatsModel value;
				if (holder.Models.TryGetValue(memberMessage.persId, out value))
				{
					holder.UpdateModel(memberMessage.persId, memberMessage.kills, memberMessage.exp, memberMessage.side, memberMessage.points, GetPlaymateTeam(memberMessage.side));
				}
				else if (memberMessage.persId != myPlayerStatsModel.stats.persId)
				{
					Exc.Report(3202);
				}
			}
		}

		protected bool GetPlaymateTeam(int side)
		{
			if (gameModel.gameMode.supportTeams)
			{
				return side == myPlayerStatsModel.stats.Side;
			}
			return false;
		}

		protected void ReportStatsRecieved(TeamDataMessage[] meesage, int side)
		{
			NetworkBasicPlayersManager.StatsRecieved.SafeInvoke(meesage, side);
		}

		protected void SetPlaymateSide(PlayerStatsModel model, int side)
		{
			model.SetSide(side, GetPlaymateTeam(side));
		}
	}
}

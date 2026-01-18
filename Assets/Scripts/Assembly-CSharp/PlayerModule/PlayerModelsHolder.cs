using System;
using System.Collections.Generic;
using Extensions;
using PlayerModule.MyPlayer;

namespace PlayerModule
{
	public class PlayerModelsHolder : Singleton
	{
		private List<PlayerStatsModel> modelsToRemove_;

		public Dictionary<string, PlayerStatsModel> Models { get; private set; }

		public event Action StatsChanged;

		public event Action<string> ModelRemoved;

		public event Action<PlayerStatsModel> ModelWillBeRemoved;

		public event Action<PlayerStatsModel> ModelAdded;

		public event Action<PlayerStatsModel> ModelChanged;

		public PlayerModelsHolder()
		{
			Models = new Dictionary<string, PlayerStatsModel>();
			modelsToRemove_ = new List<PlayerStatsModel>();
		}

		public override void Dispose()
		{
			foreach (PlayerStatsModel value in Models.Values)
			{
				if (!value.IsMyPlayer)
				{
					value.Dispose();
				}
			}
		}

		public override void Init()
		{
			MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
			Models[myPlayerStatsModel.stats.persId] = myPlayerStatsModel.stats;
		}

		internal void AddRemoteModel(PlayerStatsModel model)
		{
			Models[model.persId] = model;
			this.ModelAdded.SafeInvoke(model);
			this.ModelChanged.SafeInvoke(model);
		}

		public void UpdateOnlineState()
		{
			foreach (PlayerStatsModel value in Models.Values)
			{
				if (!value.online)
				{
					modelsToRemove_.Add(value);
				}
			}
			foreach (PlayerStatsModel item in modelsToRemove_)
			{
				this.ModelWillBeRemoved.SafeInvoke(item);
				Models.Remove(item.persId);
				this.ModelRemoved.SafeInvoke(item.persId);
			}
			modelsToRemove_.Clear();
		}

		internal void RemoveRemoteModel(string persId)
		{
			PlayerStatsModel value;
			if (Models.TryGetValue(persId, out value))
			{
				this.ModelWillBeRemoved.SafeInvoke(value);
				Models.Remove(value.persId);
				this.ModelRemoved.SafeInvoke(value.persId);
			}
		}

		internal void ReportStatsChanged()
		{
			this.StatsChanged.SafeInvoke();
		}

		internal void UpdateModel(string persId, int kills, int exp, int side, int points, bool inMyPlayerTeam)
		{
			PlayerStatsModel value;
			if (Models.TryGetValue(persId, out value))
			{
				value.points = points;
				value.online = true;
				value.combat.KillFragsCount = kills;
				value.BattleExperiance = exp;
				value.SetSide(side, inMyPlayerTeam);
				this.ModelChanged.SafeInvoke(value);
			}
		}
	}
}

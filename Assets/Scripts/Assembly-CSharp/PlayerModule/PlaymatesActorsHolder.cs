using System;
using System.Collections.Generic;
using Extensions;
using PlayerModule.Playmate;

namespace PlayerModule
{
	public class PlaymatesActorsHolder : Singleton
	{
		private Dictionary<string, PlaymateEntity> actors_;

		private PlayerModelsHolder playersHolder_;

		public event Action<PlaymateEntity> ActorAdded;

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<PlayerModelsHolder>(out playersHolder_);
			playersHolder_.ModelRemoved += HandleModelRemoved;
			playersHolder_.ModelAdded += HandleModelAdded;
			actors_ = new Dictionary<string, PlaymateEntity>();
		}

		public override void Dispose()
		{
			foreach (PlaymateEntity value in actors_.Values)
			{
				value.Dispose();
			}
			actors_.Clear();
		}

		private void HandleModelAdded(PlayerStatsModel model)
		{
			if (!model.IsMyPlayer)
			{
				model.visibility.ByGameLogic = true;
				model.visibility.ByGameState = true;
				model.visibility.ByHealth = true;
				model.visibility.ByPlayerSide = true;
				model.visibility.ByServerPosition = true;
				model.HealthMax = 100;
				model.HealthCurrent = 100;
				PlaymateEntity playmateEntity = new PlaymateEntity(model, false, false);
				actors_[model.persId] = playmateEntity;
				this.ActorAdded.SafeInvoke(playmateEntity);
			}
		}

		private void HandleModelRemoved(string persId)
		{
			RemoveRemoteActor(persId);
		}

		private void RemoveRemoteActor(string id)
		{
			PlaymateEntity playmateEntity = actors_[id];
			actors_.Remove(id);
			playmateEntity.Dispose();
		}

		public PlaymateEntity GetActor(string id)
		{
			PlaymateEntity value;
			if (id != null && actors_.TryGetValue(id, out value))
			{
				return value;
			}
			return null;
		}
	}
}

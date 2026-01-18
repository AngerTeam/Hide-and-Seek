using PlayerModule;

namespace ExpirienceModule
{
	public class PlaymatesExpirienceManager : Singleton
	{
		private PlayerModelsHolder playerModelsHolder_;

		private ExpirienceManager expirienceManager_;

		public override void Init()
		{
			SingletonManager.Get<ExpirienceManager>(out expirienceManager_);
			SingletonManager.Get<PlayerModelsHolder>(out playerModelsHolder_);
			playerModelsHolder_.ModelAdded += HandleModelAdded;
		}

		private void HandleModelAdded(PlayerStatsModel model)
		{
			model.HealthMax = expirienceManager_.GetHealthByLevel(model.experiance.level);
		}
	}
}

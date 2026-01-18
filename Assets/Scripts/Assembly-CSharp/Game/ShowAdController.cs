using AdsModule;

namespace Game
{
	public class ShowAdController : Singleton
	{
		private GameModel gameModel_;

		private AdsManager adsManager_;

		public override void Init()
		{
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<AdsManager>(out adsManager_);
		}

		private void Done()
		{
			gameModel_.adDone = true;
		}

		public void Start()
		{
			gameModel_.adDone = false;
			adsManager_.TryShowNonRewardedAd(Done);
		}
	}
}

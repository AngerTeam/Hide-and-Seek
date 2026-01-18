using ExpirienceModule;

namespace Game
{
	public class LevelUpController : Singleton
	{
		private GameModel gameModel_;

		private HttpTopManager httpTopManager_;

		private ExpirienceManager expirienceManager_;

		public override void Init()
		{
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<HttpTopManager>(out httpTopManager_);
			SingletonManager.Get<ExpirienceManager>(out expirienceManager_);
		}

		public void Start()
		{
			gameModel_.lvlUpChecked = false;
			expirienceManager_.LevelUpEnabled = true;
			expirienceManager_.LvlUpDone += OnLvlUpDone;
			httpTopManager_.Sync();
		}

		private void OnLvlUpDone(bool succeed)
		{
			expirienceManager_.LvlUpDone -= OnLvlUpDone;
			expirienceManager_.LevelUpEnabled = false;
			gameModel_.lvlUpChecked = true;
		}
	}
}

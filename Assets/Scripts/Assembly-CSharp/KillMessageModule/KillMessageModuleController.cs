using Combat;
using CombatOnline;

namespace KillMessageModule
{
	public class KillMessageModuleController : Singleton
	{
		private KillMessageController killMessageController_;

		private NetworkCombatManager combatInteraction_;

		public override void OnDataLoaded()
		{
			killMessageController_ = new KillMessageController();
			if (SingletonManager.TryGet<NetworkCombatManager>(out combatInteraction_))
			{
				combatInteraction_.KillSucceseded += HandleKillSucceseded;
			}
		}

		private void HandleKillSucceseded(string text, KillMessageType type)
		{
			SetKillMessage(text, type);
		}

		public void SetKillMessage(string text, KillMessageType type)
		{
			if (killMessageController_ != null)
			{
				killMessageController_.SetKillMessage(text, type);
			}
		}

		public override void Dispose()
		{
			killMessageController_.Dispose();
			if (combatInteraction_ != null)
			{
				combatInteraction_.KillSucceseded -= HandleKillSucceseded;
			}
		}
	}
}

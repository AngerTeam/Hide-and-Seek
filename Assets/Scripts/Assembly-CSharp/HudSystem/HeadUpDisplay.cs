using CraftyEngine.Infrastructure.SingletonManagerCore;
using NguiTools;

namespace HudSystem
{
	public abstract class HeadUpDisplay : GuiModlule
	{
		protected PrefabsManagerNGUI prefabsManager;

		protected NguiManager nguiManager;

		protected HudStateSwitcher hudStateSwitcher;

		protected HeadUpDisplay()
		{
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager);
			SingletonManager.Get<NguiManager>(out nguiManager);
			SingletonManager.PhaseCompleted += HandleSingletonManagerPhaseCompleted;
		}

		private void HandleSingletonManagerPhaseCompleted(SingletonPhase phase, int layer)
		{
			if (phase == SingletonPhase.Init)
			{
				Resubscribe();
			}
		}

		public override void Dispose()
		{
			SingletonManager.PhaseCompleted -= HandleSingletonManagerPhaseCompleted;
		}
	}
}

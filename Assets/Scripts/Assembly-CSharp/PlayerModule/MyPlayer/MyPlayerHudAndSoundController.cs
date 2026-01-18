using CraftyEngine.Sounds;
using HudSystem;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerHudAndSoundController : ArtikulHandler
	{
		private ActionHandler actionHandler_;

		private MyPlayerStatsModel model_;

		public MyPlayerHudAndSoundController(MyPlayerStatsModel model, ActionHandler actionHandler)
		{
			model_ = model;
			SetModel(model.stats);
			actionHandler_ = actionHandler;
			actionHandler_.ActionChanged += HandleActionChanged;
			actionHandler_.ContactHappened += HandleContactHappened;
			GuiModuleHolder.Add<MyPlayerHurtHud>();
		}

		private void HandleContactHappened()
		{
			if (model_.myVisibility.Visible)
			{
				if (selectedArtikul.ranged)
				{
					PlaySoundGroup(selectedArtikul.sound_group_id);
				}
				if (selectedArtikul.cooldown > 0.3f)
				{
					model_.hudItemCooldown = selectedArtikul.cooldown;
				}
			}
		}

		private void HandleActionChanged(int id)
		{
			if (selectedArtikul != null)
			{
				switch (id)
				{
				case 5:
					PlaySoundGroup(selectedArtikul.cooldown_sound_group_id);
					break;
				case 4:
					PlaySoundGroup(selectedArtikul.reload_sound_group_id);
					model_.hudItemCooldown = selectedArtikul.reload_time;
					break;
				}
			}
		}

		private void PlaySoundGroup(int group)
		{
			if (model_.myVisibility.Visible)
			{
				SoundProvider.PlayGroupSound2D(group, 1f);
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			actionHandler_.ActionChanged -= HandleActionChanged;
			actionHandler_.ContactHappened -= HandleContactHappened;
		}
	}
}

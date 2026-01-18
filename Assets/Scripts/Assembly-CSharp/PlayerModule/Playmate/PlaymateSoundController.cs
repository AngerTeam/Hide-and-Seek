using CraftyEngine.Sounds;
using MyPlayerInput;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlaymateSoundController : ArtikulHandler
	{
		private Transform transform_;

		private Vector3 previousStepPosition_;

		private float previousStepMoment_;

		public PlaymateSoundController(PlayerStatsModel model, ActionHandler handler)
		{
			handler.ContactHappened += HandleContactHappened;
			handler.ActionChanged += HandleActionChanged;
			SetModel(model);
			if (MyPlayerInputContentMap.PlayerSettings.useAnimationEvent == 1)
			{
				model.visual.byCamera3Rd.Updated += HandleUpdated;
			}
		}

		private void HandleUpdated()
		{
			if (base.Model.visual.byCamera3Rd.BodyAsc != null)
			{
				base.Model.visual.byCamera3Rd.BodyAsc.Asc.Step += HandleStep;
			}
		}

		private void HandleStep()
		{
			if (base.Model.visual.byCamera3Rd.enabled && !(Vector3.Distance(previousStepPosition_, base.Model.Position) < 0.05f) && !(Time.unscaledTime - previousStepMoment_ < 0.15f))
			{
				previousStepMoment_ = Time.unscaledTime;
				previousStepPosition_ = base.Model.Position;
				int num = base.Model.visual.stepSoundId;
				if (num == 0)
				{
					num = MyPlayerInputContentMap.PlayerSettings.defaultStepSoundId;
				}
				SoundProvider.PlayGroupSound3D(base.Model.Position, num, (!base.Model.IsMyPlayer) ? 0.6f : 1f);
			}
		}

		private void HandleContactHappened()
		{
			if (selectedArtikul != null && selectedArtikul.ranged)
			{
				PlaySoundGroup(selectedArtikul.sound_group_id);
			}
		}

		public void SetTransform(Transform transform)
		{
			transform_ = transform;
		}

		private void HandleActionChanged(int id)
		{
			if (selectedArtikul != null)
			{
				if (id == 4)
				{
					PlaySoundGroup(selectedArtikul.reload_sound_group_id);
				}
				if (selectedArtikul.ranged && id == 5)
				{
					PlaySoundGroup(selectedArtikul.cooldown_sound_group_id);
				}
			}
		}

		private void PlaySoundGroup(int group)
		{
			if (transform_ != null && base.Model.visibility.Visible)
			{
				SoundProvider.PlayGroupSound3D(transform_.position, group, 1f);
			}
		}
	}
}

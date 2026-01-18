using System;
using Animations;
using CraftyEngine.Infrastructure;

namespace PlayerModule.Playmate
{
	public class PlaymateJumpController : IDisposable
	{
		private const int IDLE = 0;

		private const int JUMP = 1;

		private const int FALL = 2;

		private int state_;

		private AnimatorOverrideStatesController asc_;

		private PlayerStatsModel model_;

		private float previousPositionHeight_;

		private TaskQueue queue_;

		private ActionTask reseTask_;

		private int framesCounter_;

		public PlaymateJumpController(PlayerStatsModel model, AnimatorOverrideStatesController Asc)
		{
			state_ = 0;
			asc_ = Asc;
			model_ = model;
			QueueManager singlton;
			SingletonManager.Get<QueueManager>(out singlton, 2);
			queue_ = singlton.AddUnityThreadQueue();
			previousPositionHeight_ = model_.Position.y;
			model_.PositionUpdated += TryJump;
			model_.jumping = false;
			model_.visibility.VisibleChanged += HandleVisibleChanged;
			reseTask_ = new ActionTask(ResetJump);
			ResetJump();
		}

		private void HandleVisibleChanged()
		{
			ResetJump();
		}

		private void TryJump(bool interpolate)
		{
			if (!interpolate)
			{
				ResetJump();
				return;
			}
			if (model_.visual.jumpPending)
			{
				model_.visual.jumpPending = false;
				PlayJump();
			}
			switch (state_)
			{
			case 0:
				TryFall();
				TryJump();
				break;
			case 1:
				TryFall();
				break;
			case 2:
				TryLand();
				break;
			}
			previousPositionHeight_ = model_.Position.y;
		}

		private void TryJump()
		{
			if (model_.Position.y > previousPositionHeight_)
			{
				framesCounter_ = 0;
				state_ = 1;
				model_.jumping = true;
				PlayJump();
			}
		}

		public void PlayJump()
		{
			if (queue_.TaskCount == 0)
			{
				asc_.Play("jumpStart", null, queue_, 0f);
				asc_.Play("jumpCont", null, queue_, 0f);
			}
		}

		private void TryLand()
		{
			if (model_.Position.y == previousPositionHeight_)
			{
				framesCounter_++;
				if (framesCounter_ >= 2)
				{
					state_ = 0;
					if (model_.resultVisibility.Visible)
					{
						queue_.Clear();
						asc_.Play("jumpEnd", null, queue_, 0f);
						queue_.Add(reseTask_);
					}
					else
					{
						ResetJump();
					}
				}
			}
			else
			{
				framesCounter_ = 0;
			}
		}

		private void TryFall()
		{
			if (model_.Position.y < previousPositionHeight_)
			{
				state_ = 2;
				model_.jumping = true;
				asc_.Play("jumpCont", null, queue_, 0.2f);
				framesCounter_ = 0;
			}
			else if (model_.Position.y == previousPositionHeight_)
			{
				framesCounter_++;
				if (framesCounter_ >= 5)
				{
					ResetJump();
				}
			}
			else
			{
				framesCounter_ = 0;
			}
		}

		private void ResetJump()
		{
			framesCounter_ = 0;
			if (model_.jumping || state_ != 0)
			{
				model_.jumping = false;
				state_ = 0;
				queue_.Clear();
				if (model_.visual.Statinoary)
				{
					asc_.Play("idle", null, null, 0.5f);
				}
			}
		}

		public void Dispose()
		{
			queue_.Clear();
			model_.jumping = false;
			model_.PositionUpdated -= TryJump;
			model_.visibility.VisibleChanged -= HandleVisibleChanged;
		}
	}
}

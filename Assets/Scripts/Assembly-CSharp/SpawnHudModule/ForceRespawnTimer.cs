using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using HudSystem;
using MiniGameCraft.GameStates;

namespace SpawnHudModule
{
	public class ForceRespawnTimer
	{
		private float duration_;

		private RespawnHud hud_;

		private int lastT_;

		private UnityTimer timer_;

		private UnityEvent unityEvent_;

		private UnityTimerManager timerManager_;

		public event Action Completed;

		public ForceRespawnTimer(float forceRespawnTime)
		{
			GuiModuleHolder.Get<RespawnHud>(out hud_);
			hud_.SetTime(string.Empty);
			duration_ = forceRespawnTime;
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			UnityUpdate();
		}

		public void Dispose()
		{
			if (timer_ != null)
			{
				timer_.Stop();
				timer_.Completeted -= HandleTimerCompleteted;
				timer_ = null;
			}
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
		}

		public void Start()
		{
			timer_ = timerManager_.SetTimer(duration_);
			timer_.Completeted += HandleTimerCompleteted;
			UnityUpdate();
		}

		public void Stop()
		{
			if (timer_ != null)
			{
				timer_.Stop();
				timer_ = null;
			}
		}

		private void HandleTimerCompleteted()
		{
			this.Completed.SafeInvoke();
		}

		private void UnityUpdate()
		{
			if (timer_ != null)
			{
				float num = duration_ - timer_.Time;
				int num2 = (int)num;
				if (lastT_ != num2)
				{
					lastT_ = num2;
					hud_.SetTime(num.ToString("0"));
				}
			}
		}
	}
}

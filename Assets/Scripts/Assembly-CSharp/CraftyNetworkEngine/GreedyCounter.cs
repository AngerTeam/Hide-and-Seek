using System;
using System.Timers;
using Extensions;

namespace CraftyNetworkEngine
{
	public class GreedyCounter
	{
		public int criticalAmount;

		private Timer timer_;

		private float greedDuration_;

		public int CurrentAmount { get; private set; }

		public event Action CriticalAmountReached;

		public GreedyCounter(int criticalAmount, float greedDuration = 2f)
		{
			greedDuration_ = greedDuration;
			this.criticalAmount = criticalAmount;
		}

		public void Start()
		{
			CurrentAmount = 0;
			if (!(greedDuration_ <= 0f))
			{
				timer_ = new Timer(greedDuration_ * 1000f);
				timer_.Elapsed += HandleTimer;
				timer_.Start();
			}
		}

		public void Stop()
		{
			if (timer_ != null)
			{
				timer_.Elapsed -= HandleTimer;
				timer_.Stop();
				timer_ = null;
			}
		}

		public bool PushError()
		{
			CurrentAmount++;
			if (CurrentAmount >= criticalAmount)
			{
				this.CriticalAmountReached.SafeInvoke();
				CurrentAmount = 0;
				return true;
			}
			return false;
		}

		private void HandleTimer(object sender, ElapsedEventArgs e)
		{
			if (CurrentAmount > 0)
			{
				CurrentAmount--;
			}
		}
	}
}

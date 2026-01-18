using System;
using CraftyEngine.Infrastructure;
using Extensions;

namespace CraftyEngine.States
{
	public class ProgressableStateMachine : IDisposable, IProgressable
	{
		public bool Enabled
		{
			get
			{
				return StateMachine.enabled;
			}
			set
			{
				StateMachine.enabled = value;
			}
		}

		public float Progress { get; private set; }

		public StateMachine StateMachine { get; private set; }

		public float Weight { get; set; }

		public event Action<float> Progressed;

		public ProgressableStateMachine(State initialState, string name)
		{
			Weight = 1f;
			StateMachine = new StateMachine(initialState, name);
			StateMachine.StateChanged += HandleStateChanged;
		}

		public void Update()
		{
			StateMachine.Update();
		}

		private void HandleStateChanged()
		{
			ProgressState progressState = StateMachine.CurrentState as ProgressState;
			if (progressState != null && progressState.progress > Progress)
			{
				Progress = progressState.progress;
				this.Progressed.SafeInvoke(Progress);
			}
		}

		public void Dispose()
		{
			StateMachine.Dispose();
		}
	}
}

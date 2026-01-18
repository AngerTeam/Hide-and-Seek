using CraftyEngine.States;
using UnityEngine;

namespace HudSystem
{
	public class StateMachineGui
	{
		private StateMachine stateMachine_;

		private string title_;

		public StateMachineGui(StateMachine stateMachine, string title)
		{
			title_ = title;
			stateMachine_ = stateMachine;
		}

		public void OnGui()
		{
			GUILayout.Label(title_ + ": " + stateMachine_.CurrentState.Name);
			foreach (Transaction transaction in stateMachine_.CurrentState.Transactions)
			{
				if (GUILayout.Button("Go to " + transaction.Target.Name))
				{
					transaction.pretendToBeFulfilled = true;
					stateMachine_.Update();
				}
			}
		}
	}
}

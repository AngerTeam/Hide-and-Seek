using UnityEngine;

namespace CraftyEngine.States
{
	public class StateMachineEditorView : MonoBehaviour
	{
		public string currentState;

		private StateMachine stateMachine_;

		public void SetStateMachine(StateMachine stateMachine)
		{
			stateMachine_ = stateMachine;
		}

		private void Update()
		{
			if (stateMachine_ != null)
			{
				currentState = stateMachine_.CurrentState.Name;
			}
		}
	}
}

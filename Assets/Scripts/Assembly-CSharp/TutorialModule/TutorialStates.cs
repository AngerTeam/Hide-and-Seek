using System.Collections.Generic;

namespace TutorialModule
{
	public class TutorialStates
	{
		public List<TutorialState> attackStates;

		public List<TutorialState> controlStates;

		public List<TutorialState> craftStates;

		public TutorialStates()
		{
			controlStates = new List<TutorialState>();
			controlStates.Add(new TutorialStateRotate());
			controlStates.Add(new TutorialStateMove());
			controlStates.Add(new TutorialStateJump());
			attackStates = new List<TutorialState>();
			attackStates.Add(new TutorialStateAttack());
		}
	}
}

using System;

namespace CraftyEngine.Infrastructure
{
	public class ActionTask : SyncTask
	{
		private Action action_;

		public ActionTask(Action action)
		{
			action_ = action;
		}

		public override void Body()
		{
			action_();
		}
	}
}

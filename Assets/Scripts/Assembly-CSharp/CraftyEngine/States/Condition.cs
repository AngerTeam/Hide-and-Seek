using System;

namespace CraftyEngine.States
{
	public class Condition
	{
		public Func<bool> Check;

		public float priority;

		public bool temp;

		public Condition(Func<bool> check)
		{
			Check = check;
		}

		public bool Fulfilled()
		{
			return Check();
		}
	}
}

using System;
using System.Collections.Generic;
using Extensions;

namespace CraftyEngine.States
{
	public class Transaction
	{
		public bool pretendToBeFulfilled;

		private List<Condition> conditions_;

		public State Target { get; private set; }

		public event Action Started;

		public event Action Transiting;

		public event Action Completed;

		public Transaction(State target)
		{
			Target = target;
			conditions_ = new List<Condition>();
		}

		public Condition AddCondition(Func<bool> check)
		{
			Condition condition = new Condition(check);
			conditions_.Add(condition);
			conditions_.Sort(SortConditions);
			return condition;
		}

		private int SortConditions(Condition a, Condition b)
		{
			return a.priority.CompareTo(b.priority);
		}

		public bool Fulfilled()
		{
			if (pretendToBeFulfilled)
			{
				pretendToBeFulfilled = false;
				return true;
			}
			for (int i = 0; i < conditions_.Count; i++)
			{
				if (!conditions_[i].Fulfilled())
				{
					return false;
				}
			}
			return true;
		}

		public void Complete()
		{
			this.Completed.SafeInvoke();
		}

		public void Transit()
		{
			this.Transiting.SafeInvoke();
		}

		public void Start()
		{
			this.Started.SafeInvoke();
		}
	}
}

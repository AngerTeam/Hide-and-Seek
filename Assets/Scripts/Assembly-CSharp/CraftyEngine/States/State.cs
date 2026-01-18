using System;
using System.Collections.Generic;
using Extensions;

namespace CraftyEngine.States
{
	public class State
	{
		public string Name { get; private set; }

		public List<Transaction> Transactions { get; private set; }

		public event Action Entered;

		public event Action Exited;

		public State(string name)
		{
			Name = name;
			Transactions = new List<Transaction>();
		}

		public virtual Transaction AddTransaction(State target, Func<bool> check = null)
		{
			Transaction transaction = new Transaction(target);
			Transactions.Add(transaction);
			if (check != null)
			{
				transaction.AddCondition(check);
			}
			return transaction;
		}

		public Transaction TryGetExitTransaction()
		{
			for (int i = 0; i < Transactions.Count; i++)
			{
				Transaction transaction = Transactions[i];
				if (transaction.Fulfilled())
				{
					return transaction;
				}
			}
			return null;
		}

		protected virtual void OnEnter()
		{
		}

		protected virtual void OnExit()
		{
		}

		public void Enter()
		{
			try
			{
				OnEnter();
				this.Entered.SafeInvoke();
			}
			catch (Exception exc)
			{
				Log.Error("Unable to enter to {0}", Name);
				Log.Exception(exc);
			}
		}

		public void Exit()
		{
			try
			{
				OnExit();
				this.Exited.SafeInvoke();
			}
			catch (Exception exc)
			{
				Log.Error("Unable to exit from {0}", Name);
				Log.Exception(exc);
			}
		}
	}
}

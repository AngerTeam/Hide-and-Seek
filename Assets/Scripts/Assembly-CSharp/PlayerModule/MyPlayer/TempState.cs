using System;
using CraftyEngine.States;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class TempState : State
	{
		public float duration;

		private float moment_;

		public int Id { get; private set; }

		public TempState(string name, int id)
			: base(name)
		{
			Id = id;
		}

		public override Transaction AddTransaction(State target, Func<bool> check = null)
		{
			Transaction transaction = base.AddTransaction(target, check);
			transaction.AddCondition(MarkReached);
			return transaction;
		}

		protected override void OnEnter()
		{
			if (Id != 5 && duration == 0f)
			{
				Log.Warning("duration {0} is 0", base.Name);
			}
			moment_ = Time.time + duration;
		}

		private bool MarkReached()
		{
			return moment_ < Time.time;
		}
	}
}

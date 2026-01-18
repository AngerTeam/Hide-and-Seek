using System;
using Extensions;
using UnityEngine;

namespace PlayerModule
{
	[Serializable]
	public class PlayerCombatModel : IDisposable
	{
		[SerializeField]
		private int killFragsCount_;

		public float attackedMyPlayerMoment;

		public int KillFragsCount
		{
			get
			{
				return killFragsCount_;
			}
			set
			{
				if (killFragsCount_ != value)
				{
					killFragsCount_ = value;
					this.KillsCountChanged.SafeInvoke();
				}
			}
		}

		public event Action KillsCountChanged;

		public void Dispose()
		{
			this.KillsCountChanged = null;
		}
	}
}

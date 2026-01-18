using System;
using System.Collections.Generic;
using Extensions;
using MoneyModule;

namespace PlayerModule.MyPlayer
{
	[Serializable]
	public class MyPlayerMoneyModel
	{
		public bool IsPayer;

		private readonly Dictionary<int, int> moneyAmount_ = new Dictionary<int, int>();

		public int CrystalsAmount
		{
			get
			{
				return GetMoneyAmount(MoneyTypesEntries.crystalId);
			}
			set
			{
				SetMoneyAmount(MoneyTypesEntries.crystalId, value);
			}
		}

		public event Action<int> InsufficientMoney;

		public event Action<int> MoneyAmountUpdated;

		public int GetMoneyAmount(int moneyType)
		{
			int value;
			if (moneyAmount_.TryGetValue(moneyType, out value))
			{
				return value;
			}
			return 0;
		}

		public void SetMoneyAmount(int moneyType, int moneyAmount)
		{
			moneyAmount_[moneyType] = moneyAmount;
			this.MoneyAmountUpdated.SafeInvoke(moneyType);
		}

		public void ReportInsufficientMoney(int moneyType)
		{
			this.InsufficientMoney.SafeInvoke(moneyType);
		}
	}
}

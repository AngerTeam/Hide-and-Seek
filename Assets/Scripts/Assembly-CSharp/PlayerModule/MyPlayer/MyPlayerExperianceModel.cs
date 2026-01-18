using System;
using Extensions;

namespace PlayerModule.MyPlayer
{
	[Serializable]
	public class MyPlayerExperianceModel
	{
		private int exp_;

		private int lvl_;

		public int Exp
		{
			get
			{
				return exp_;
			}
			set
			{
				exp_ = value;
				this.Updated.SafeInvoke();
			}
		}

		public int level
		{
			get
			{
				return lvl_;
			}
			set
			{
				lvl_ = value;
				this.Updated.SafeInvoke();
			}
		}

		public event Action Updated;
	}
}

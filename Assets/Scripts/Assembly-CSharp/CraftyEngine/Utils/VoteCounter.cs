using System.Collections.Generic;

namespace CraftyEngine.Utils
{
	public class VoteCounter
	{
		public bool mainAnchor;

		private Dictionary<object, bool> enableScore_ = new Dictionary<object, bool>();

		public bool actualValue { get; private set; }

		public bool SetEnable(object applicant, bool enabled)
		{
			enableScore_[applicant] = enabled;
			foreach (bool value in enableScore_.Values)
			{
				if (value == mainAnchor)
				{
					actualValue = mainAnchor;
					return actualValue;
				}
			}
			actualValue = !mainAnchor;
			return actualValue;
		}

		public void Clear()
		{
			enableScore_.Clear();
		}
	}
}

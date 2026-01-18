using System;
using CraftyEngine.Utils;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class TimeManager : Singleton
	{
		private int startTimestamp_;

		private int timeOffset_;

		public int CurrentTimestamp
		{
			get
			{
				return startTimestamp_ - timeOffset_ + (int)Time.unscaledTime;
			}
		}

		public override void Init()
		{
			SetTime(TimeUtils.DateTimeToUnixTimestamp(DateTime.Now));
		}

		public void SetTime(int timestamp)
		{
			startTimestamp_ = timestamp;
			timeOffset_ = (int)Time.unscaledTime;
		}
	}
}

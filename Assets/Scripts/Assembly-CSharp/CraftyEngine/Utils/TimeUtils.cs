using System;

namespace CraftyEngine.Utils
{
	internal class TimeUtils
	{
		private static string H = "h";

		private static string D = "d";

		private static string M = "m";

		private static string S = "s";

		public static void SetLetters(string d, string h, string m, string s)
		{
			D = d;
			H = h;
			M = m;
			S = s;
		}

		public static DateTime UnixTimeStampToDateTime(int unixTimeStamp)
		{
			return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(unixTimeStamp).ToLocalTime();
		}

		public static int DateTimeToUnixTimestamp(DateTime dateTime)
		{
			return (int)(TimeZoneInfo.ConvertTimeToUtc(dateTime) - new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc)).TotalSeconds;
		}

		public static int GetSecondsLeft(int currentTimeStamp, int endTimeStamp)
		{
			int num = endTimeStamp - currentTimeStamp;
			return (num > 0) ? num : 0;
		}

		public static string GetTimeLeft(int currentTimeStamp, int endTimeStamp)
		{
			DateTime dateTime = UnixTimeStampToDateTime(currentTimeStamp);
			DateTime dateTime2 = UnixTimeStampToDateTime(endTimeStamp);
			TimeSpan time = dateTime2 - dateTime;
			return ToShortPositiveDuration(time);
		}

		public static string ToShortPositiveDuration(TimeSpan time)
		{
			if (time.Seconds < 0)
			{
				return string.Format("0{0}", S);
			}
			if (time.Days > 0)
			{
				if (time.Hours == 0)
				{
					return string.Format("{0}{1}", time.Days, D);
				}
				return string.Format("{0}{1} {2}{3}", time.Days, D, time.Hours, H);
			}
			if (time.Hours > 0)
			{
				if (time.Minutes == 0)
				{
					return string.Format("{0}{1}", time.Hours, H);
				}
				return string.Format("{0}{1} {2}{3}", time.Hours, H, time.Minutes, M);
			}
			if (time.Minutes > 0)
			{
				if (time.Seconds == 0)
				{
					return string.Format("{0}{1}", time.Minutes, M);
				}
				return string.Format("{0}{1} {2}{3}", time.Minutes, M, time.Seconds, S);
			}
			return string.Format("{0}{1}", time.Seconds, S);
		}

		public static string ToLongPositiveDuration(TimeSpan time)
		{
			if (time.Seconds < 0)
			{
				return string.Format("00{0} 00{1}", M, S);
			}
			if (time.Days > 0)
			{
				return string.Format("{0:00}{1} {2:00}{3} {4:00}{5} {6:00}{7}", time.Days, D, time.Hours, H, time.Minutes, M, time.Seconds, S);
			}
			if (time.Hours > 0)
			{
				return string.Format("{0:00}{1} {2:00}{3} {4:00}{5}", time.Hours, H, time.Minutes, M, time.Seconds, S);
			}
			return string.Format("{0:00}{1} {2:00}{3}", time.Minutes, M, time.Seconds, S);
		}

		public static string ToTimerCounter(int seconds)
		{
			TimeSpan time = TimeSpan.FromSeconds(seconds);
			return ToShortPositiveDuration(time);
		}
	}
}

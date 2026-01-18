using Interlace.Amf;
using RemoteData;

namespace RateMeModule.RemoteData
{
	public class AppRatingMessage : RemoteMessage
	{
		public double rewardTime;

		public double refusalTime;

		public int refusalCount;

		public int refusalForever;

		public int rating;

		public AppRatingMessage(double rewardTime, double refusalTime, int refusalCount, int refusalForever, int rating)
		{
			this.rewardTime = rewardTime;
			this.refusalTime = refusalTime;
			this.refusalCount = refusalCount;
			this.refusalForever = refusalForever;
			this.rating = rating;
		}

		public AppRatingMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			rewardTime = Get<double>(source, "reward_time", false);
			refusalTime = Get<double>(source, "refusal_time", false);
			refusalCount = Get<int>(source, "refusal_cnt", false);
			refusalForever = Get<int>(source, "refusal_forever", false);
			rating = Get<int>(source, "rating", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AppRatingMessage: rewardTime: {0}; refusalTime: {1}; refusalCount: {2}; refusalForever: {3}; rating: {4};", rewardTime, refusalTime, refusalCount, refusalForever, rating);
		}
	}
}

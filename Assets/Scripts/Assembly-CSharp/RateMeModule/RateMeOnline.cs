using System;
using HttpNetwork;
using RateMeModule.RemoteData;

namespace RateMeModule
{
	public class RateMeOnline
	{
		public HttpOnlineManager http;

		public event Action<RemoteMessageEventArgs> RateResponseReceived;

		public RateMeOnline()
		{
			SingletonManager.Get<HttpOnlineManager>(out http);
		}

		public void SendRate(bool forever, int rate = 0)
		{
			if (rate != 0)
			{
				http.Send<AppRatingResponse>(new AppRatingLuaCommand(rate), this.RateResponseReceived);
			}
			else
			{
				http.Send<AppRatingResponse>(new AppRatingRefusalLuaCommand(forever ? 1 : 0), this.RateResponseReceived);
			}
		}
	}
}

using HttpNetwork;
using RemoteData.Lua;

namespace SpecialOffersModule
{
	public class SpecialOffersOnlineController : Singleton
	{
		private HttpOnlineManager http_;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public void SendOfferStart(int offerId, string inappId)
		{
			http_.Send(new OfferStartLuaCommand(inappId, offerId));
		}
	}
}

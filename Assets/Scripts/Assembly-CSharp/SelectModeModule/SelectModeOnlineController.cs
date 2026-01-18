using System;
using AuthorizationGame.RemoteData;
using HttpNetwork;

namespace SelectModeModule
{
	public class SelectModeOnlineController : Singleton
	{
		private HttpOnlineManager http;

		public event Action<RemoteMessageEventArgs> PvpInfoReceived;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http);
		}

		public void SendPvpInfo()
		{
			http.Send<PvpInfoResponse>(new PvpInfoLuaCommand(), this.PvpInfoReceived);
		}
	}
}

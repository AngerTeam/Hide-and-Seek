using System;
using ExpirienceModule.RemoteData;
using HttpNetwork;

namespace ExperienceModule
{
	public class HttpExperianceOnline
	{
		public HttpOnlineManager http;

		public event Action<RemoteMessageEventArgs> LevelUpResponse;

		public HttpExperianceOnline()
		{
			SingletonManager.Get<HttpOnlineManager>(out http);
		}

		public void SendLevelUp()
		{
			http.Send<LevelupMessage>(new LevelupLuaCommand(), this.LevelUpResponse);
		}
	}
}

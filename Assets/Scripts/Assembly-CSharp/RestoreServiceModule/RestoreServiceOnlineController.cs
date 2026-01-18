using System;
using Authorization;
using Extensions;
using HttpNetwork;
using RemoteData.Lua;

namespace RestoreServiceModule
{
	public class RestoreServiceOnlineController : Singleton
	{
		private HttpOnlineModel httpModel_;

		private HttpOnlineManager http_;

		public event Action UnboundReceived;

		public event Action BoundSucceedReceived;

		public event Action<BindPlayerMessage> AnotherProfileReceived;

		public event Action BoundForcedReceived;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineModel>(out httpModel_);
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public void SendGameCenterBind(string serviceId, string password)
		{
			http_.Send<GameCenterBindResponse>(new GameCenterBindLuaCommand(serviceId, password), GetGameCenterBindResponce, httpModel_.gameServerUrl);
		}

		private void GetGameCenterBindResponce(RemoteMessageEventArgs args)
		{
			GameCenterBindResponse gameCenterBindResponse = (GameCenterBindResponse)args.remoteMessage;
			if (gameCenterBindResponse.bindPlayer != null)
			{
				this.AnotherProfileReceived.SafeInvoke(gameCenterBindResponse.bindPlayer);
			}
			else
			{
				this.BoundSucceedReceived.SafeInvoke();
			}
		}

		public void SendGameCenterBindForce(string serviceId, string password)
		{
			http_.Send<GameCenterBindForceResponse>(new GameCenterBindForceLuaCommand(serviceId, password), GetGameCenterBindForceResponce, httpModel_.gameServerUrl);
		}

		private void GetGameCenterBindForceResponce(RemoteMessageEventArgs args)
		{
			this.BoundForcedReceived.SafeInvoke();
		}

		public void SendGameCenterUnbind()
		{
			http_.Send<GameCenterUnbindResponse>(new GameCenterUnbindLuaCommand(), GetGameCenterUnbindResponce, httpModel_.gameServerUrl);
		}

		private void GetGameCenterUnbindResponce(RemoteMessageEventArgs args)
		{
			this.UnboundReceived.SafeInvoke();
		}
	}
}

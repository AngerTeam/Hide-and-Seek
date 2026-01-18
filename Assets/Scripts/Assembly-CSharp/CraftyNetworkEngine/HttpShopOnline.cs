using System;
using HttpNetwork;
using RemoteData;
using RemoteData.Auth;
using RemoteData.Lua;

namespace CraftyNetworkEngine
{
	public class HttpShopOnline : Singleton, IShopOnline, ISingleton
	{
		private HttpOnlineManager http_;

		public event Action<RemoteMessageEventArgs> BuyArticulReceived;

		public event Action<RemoteMessageEventArgs> AdViewReceived;

		public event Action<RemoteMessageEventArgs> BuySkinReceived;

		public event Action<RemoteMessageEventArgs> SkinUpdated;

		public event Action<RemoteMessageEventArgs> NickUpdated;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public void SendBuyArtikul(int id)
		{
			BuyArtikulLuaCommand command = new BuyArtikulLuaCommand(id);
			http_.Send<BuyArtikulResponse>(command, this.BuyArticulReceived);
		}

		public void SendAdView(string chestPos)
		{
			AdViewLuaCommand command = new AdViewLuaCommand(chestPos);
			http_.Send<AdViewResponse>(command, this.AdViewReceived);
		}

		public void SendBuySkin(int id)
		{
			http_.Send<BuySkinResponse>(new BuySkinLuaCommand(id), this.BuySkinReceived);
		}

		public void SendSetSkin(int skinId)
		{
			http_.Send<RemoteMessage>(new SetSkinLuaCommand(skinId), this.SkinUpdated);
		}

		public void SendSetNickname(string nickname)
		{
			http_.Send<RemoteMessage>(new SetNameLuaCommand(nickname), this.NickUpdated);
		}
	}
}

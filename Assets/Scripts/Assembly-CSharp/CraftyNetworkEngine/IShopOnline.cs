using System;

namespace CraftyNetworkEngine
{
	public interface IShopOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> BuyArticulReceived;

		event Action<RemoteMessageEventArgs> AdViewReceived;

		event Action<RemoteMessageEventArgs> BuySkinReceived;

		event Action<RemoteMessageEventArgs> SkinUpdated;

		event Action<RemoteMessageEventArgs> NickUpdated;

		void SendBuyArtikul(int articulId);

		void SendAdView(string chestPos);

		void SendBuySkin(int id);

		void SendSetSkin(int skinId);

		void SendSetNickname(string nickname);
	}
}

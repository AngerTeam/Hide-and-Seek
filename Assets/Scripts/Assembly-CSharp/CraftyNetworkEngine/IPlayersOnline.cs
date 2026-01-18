using System;

namespace CraftyNetworkEngine
{
	public interface IPlayersOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> PlayerIn;

		event Action<RemoteMessageEventArgs> PlayerExit;

		event Action<RemoteMessageEventArgs> PlayerSpawn;

		event Action<RemoteMessageEventArgs> SkinChangeReceived;

		event Action<RemoteMessageEventArgs> PlayerSideChangeReceived;

		event Action<RemoteMessageEventArgs> ActorsStatusChanged;

		event Action<RemoteMessageEventArgs> SyncInstance;

		void SendMyPlayerPosition();

		void ResyncInstance();
	}
}

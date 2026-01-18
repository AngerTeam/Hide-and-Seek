using System;

namespace CraftyNetworkEngine
{
	public interface IGameOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> BattleStatsReceived;

		event Action<RemoteMessageEventArgs> InstanceStopped;

		event Action<RemoteMessageEventArgs> InstanceResultsRecieved;

		event Action<RemoteMessageEventArgs> ReadyResponseReceived;

		event Action<RemoteMessageEventArgs> StartStageReceived;

		event Action PvpExitSent;

		void SendReady();

		void SendExitPvp();

		void SendSlot(string slotName);
	}
}

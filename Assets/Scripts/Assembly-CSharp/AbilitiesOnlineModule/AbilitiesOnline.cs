using System;
using CraftyNetworkEngine.Sockets;
using Extensions;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;
using UnityEngine;

namespace AbilitiesOnlineModule
{
	public class AbilitiesOnline : SocketsOnlineManagerApi
	{
		public event Action<RemoteMessageEventArgs> PlayerAbilityUseReceived;

		public event Action<RemoteMessageEventArgs> AbilityUseResponseReceived;

		public override void Init()
		{
			base.Init();
			sockets.CommandRecieved += HandleCommand;
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			switch (command)
			{
			case "player_ability_use":
				HandleAbilityUse(obj);
				break;
			}
		}

		public void SendAbilityUse(string[] targets, Vector3 direction)
		{
			AbilityUseCommand abilityUseCommand = new AbilityUseCommand();
			abilityUseCommand.targets = targets;
			abilityUseCommand.direction = new VectorMessage(direction);
			abilityUseCommand.ResponceRecieved += HandleAbilityUseResponce;
			Send(abilityUseCommand);
		}

		private void HandleAbilityUseResponce(AmfObject obj)
		{
			AbilityUseResponse message;
			if (RemoteMessage.TryRead<AbilityUseResponse>(obj, out message))
			{
				this.AbilityUseResponseReceived.SafeInvoke(new RemoteMessageEventArgs(message));
			}
		}

		private void HandleAbilityUse(AmfObject obj)
		{
			PlayerAbilityUseMessage remoteMessage = RemoteMessage.Read<PlayerAbilityUseMessage>(obj);
			this.PlayerAbilityUseReceived.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}
	}
}

using System;
using CraftyEngine.Utils;
using Extensions;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsGameOnline : SocketsOnlineManagerApi, IGameOnline, ISingleton
	{
		private UnityTimer sendExitPvpTimer_;

		public event Action<RemoteMessageEventArgs> BattleStatsReceived;

		public event Action<RemoteMessageEventArgs> InstanceResultsRecieved;

		public event Action<RemoteMessageEventArgs> InstanceStopped;

		public event Action PvpExitSent;

		public event Action<RemoteMessageEventArgs> ReadyResponseReceived;

		public event Action<RemoteMessageEventArgs> StartStageReceived;

		public override void Init()
		{
			base.Init();
			sockets.CommandRecieved += HandleCommand;
		}

		public void SendBattleStatsRequest()
		{
			BattleStatCommand battleStatCommand = new BattleStatCommand();
			battleStatCommand.ResponceRecieved += HandleBattleStateResponceRecieved;
			Send(battleStatCommand);
		}

		public void SendExitPvp()
		{
			PvpExitCommand pvpExitCommand = new PvpExitCommand();
			pvpExitCommand.ResponceRecieved += HandleExitPvp;
			pvpExitCommand.ResponceNotRecieved += delegate
			{
				HandleExitPvp("respnce not recieved");
			};
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			sendExitPvpTimer_ = unityTimerManager.SetTimer(5f);
			sendExitPvpTimer_.Completeted += delegate
			{
				HandleExitPvp("by timer");
			};
			Send(pvpExitCommand);
		}

		[Obsolete("remove dirty hardcode")]
		public void SendSlot(string slotId)
		{
			SlotSelectCommand command = new SlotSelectCommand(slotId);
			Send(command);
		}

		public void SendReady()
		{
			ReadyCommand readyCommand = new ReadyCommand();
			readyCommand.ResponceRecieved += HandleReady;
			Send(readyCommand);
		}

		private void HandleBattleStateResponceRecieved(AmfObject obj)
		{
			BattleStatMessage message;
			if (RemoteMessage.TryRead<BattleStatMessage>(obj, out message))
			{
				this.BattleStatsReceived(new RemoteMessageEventArgs(message));
			}
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			switch (command)
			{
			case "fin_instance":
				ReportInstanceStopped(obj);
				break;
			case "instance_top":
				ReportInstanceResultsRecieved(obj);
				break;
			case "start_stage":
				ReportStartStageRecieved(obj);
				break;
			}
		}

		private void HandleExitPvp(string type)
		{
			if (sendExitPvpTimer_ != null)
			{
				sendExitPvpTimer_.Stop();
				sendExitPvpTimer_ = null;
			}
			Log.Online("PvpExitSent {0} ", type);
			this.PvpExitSent.SafeInvoke();
		}

		private void HandleExitPvp(AmfObject arg1)
		{
			HandleExitPvp("correct responce");
		}

		private void HandleReady(AmfObject obj)
		{
			ReadyMessage message;
			RemoteMessage.TryRead<ReadyMessage>(obj, out message);
			this.ReadyResponseReceived(new RemoteMessageEventArgs(message));
		}

		private void ReportInstanceResultsRecieved(AmfObject obj)
		{
			InstanceTopMessage remoteMessage = RemoteMessage.Read<InstanceTopMessage>(obj);
			if (this.InstanceResultsRecieved != null)
			{
				this.InstanceResultsRecieved(new RemoteMessageEventArgs(remoteMessage));
			}
		}

		private void ReportInstanceStopped(AmfObject obj)
		{
			FinInstanceMessage remoteMessage = RemoteMessage.Read<FinInstanceMessage>(obj);
			this.InstanceStopped(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportStartStageRecieved(AmfObject obj)
		{
			StartStageMessage remoteMessage = RemoteMessage.Read<StartStageMessage>(obj);
			if (this.StartStageReceived != null)
			{
				this.StartStageReceived(new RemoteMessageEventArgs(remoteMessage));
			}
		}
	}
}

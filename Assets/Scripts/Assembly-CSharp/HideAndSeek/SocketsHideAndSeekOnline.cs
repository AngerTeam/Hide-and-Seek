using System;
using CraftyNetworkEngine.Sockets;
using Extensions;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;

namespace HideAndSeek
{
	public class SocketsHideAndSeekOnline : SocketsOnlineManagerApi
	{
		public event Action<RemoteMessageEventArgs> SelectHideVoxelResponceReceived;

		public event Action<RemoteMessageEventArgs> HideResponceReceived;

		public event Action<RemoteMessageEventArgs> SeekResponceReceived;

		public event Action<RemoteMessageEventArgs> PlayerHideVoxelSelect;

		public event Action<RemoteMessageEventArgs> PlayerHide;

		public event Action<RemoteMessageEventArgs> PlayerSeek;

		public event Action<RemoteMessageEventArgs> PlayerAppear;

		public event Action<RemoteMessageEventArgs> PlayerHideCast;

		public override void Init()
		{
			base.Init();
			sockets.CommandRecieved += HandleCommand;
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			switch (command)
			{
			case "player_hide_voxel_select":
				ReportPlayerHideVoxelSelect(obj);
				break;
			case "player_hide":
				ReportPlayerHide(obj);
				break;
			case "player_seek":
				ReportPlayerSeek(obj);
				break;
			case "player_appear":
				ReportPlayerAppear(obj);
				break;
			case "player_hide_cast":
				ReportPlayerHideCast(obj);
				break;
			}
		}

		private void ReportPlayerHideVoxelSelect(AmfObject obj)
		{
			PlayerHideVoxelSelectMessage remoteMessage = RemoteMessage.Read<PlayerHideVoxelSelectMessage>(obj);
			this.PlayerHideVoxelSelect.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportPlayerHide(AmfObject obj)
		{
			PlayerHideMessage remoteMessage = RemoteMessage.Read<PlayerHideMessage>(obj);
			this.PlayerHide.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportPlayerSeek(AmfObject obj)
		{
			PlayerSeekMessage remoteMessage = RemoteMessage.Read<PlayerSeekMessage>(obj);
			this.PlayerSeek.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportPlayerAppear(AmfObject obj)
		{
			PlayerAppearMessage remoteMessage = RemoteMessage.Read<PlayerAppearMessage>(obj);
			this.PlayerAppear.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportPlayerHideCast(AmfObject obj)
		{
			PlayerHideCastMessage remoteMessage = RemoteMessage.Read<PlayerHideCastMessage>(obj);
			this.PlayerHideCast.SafeInvoke(new RemoteMessageEventArgs(remoteMessage));
		}

		public void SendHideVoxelSelectCommand(int voxelId)
		{
			HideVoxelSelectCommand hideVoxelSelectCommand = new HideVoxelSelectCommand(voxelId);
			hideVoxelSelectCommand.ResponceRecieved += HandleHideVoxelSelectResponce;
			Send(hideVoxelSelectCommand);
		}

		private void HandleHideVoxelSelectResponce(AmfObject obj)
		{
			HideVoxelSelectResponse message;
			RemoteMessage.TryRead<HideVoxelSelectResponse>(obj, out message);
			this.SelectHideVoxelResponceReceived.SafeInvoke(new RemoteMessageEventArgs(message));
		}

		public void SendHideCommand(IIntVector3 position, int rotation)
		{
			HideCommand hideCommand = new HideCommand(rotation, position);
			hideCommand.ResponceRecieved += HandleHideResponce;
			Send(hideCommand);
		}

		private void HandleHideResponce(AmfObject obj)
		{
			HideResponse message;
			RemoteMessage.TryRead<HideResponse>(obj, out message);
			this.HideResponceReceived.SafeInvoke(new RemoteMessageEventArgs(message));
		}

		public void SendSeekCommand(IIntVector3 position)
		{
			SeekCommand seekCommand = new SeekCommand(position);
			seekCommand.ResponceRecieved += HandleSeekResponce;
			Send(seekCommand);
		}

		private void HandleSeekResponce(AmfObject obj)
		{
			SeekMessage message;
			if (RemoteMessage.TryRead<SeekMessage>(obj, out message))
			{
				this.SeekResponceReceived.SafeInvoke(new RemoteMessageEventArgs(message));
			}
		}

		public void SendAppearCommand()
		{
			Send(new AppearCommand());
		}

		public void SendHideCastCommand()
		{
			Send(new HideCastCommand());
		}
	}
}

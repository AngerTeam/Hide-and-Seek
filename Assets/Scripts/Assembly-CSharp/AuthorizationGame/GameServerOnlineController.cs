using AuthorizationGame.RemoteData;
using HttpNetwork;
using Interlace.Amf;
using RemoteData;
using RemoteData.Auth;
using RemoteData.Lua;
using SyncOnlineModule;

namespace AuthorizationGame
{
	public class GameServerOnlineController : ServerOnlineControllerBase
	{
		private PvpAuthorizationModel pvpModel_;

		public GameServerOnlineController()
		{
			SingletonManager.Get<PvpAuthorizationModel>(out pvpModel_);
		}

		public void SendPersCreate()
		{
			SendPersCreate(null);
		}

		public void SendCheckPvp()
		{
			http.Send<PvpCheckMessage>(new PvpCheckLuaCommand(), PvpCheckReceived);
		}

		public void SendEnterPvp()
		{
			PvpEntryLuaCommand pvpEntryLuaCommand = new PvpEntryLuaCommand();
			pvpEntryLuaCommand.mapId = pvpModel_.mapId;
			pvpEntryLuaCommand.islandId = pvpModel_.mapId;
			pvpEntryLuaCommand.modeId = pvpModel_.mapModeId;
			pvpEntryLuaCommand.comeback = (pvpModel_.comaback ? 1 : 0);
			http.Send<PvpEntryResponse>(pvpEntryLuaCommand, PvpInstanceEnter);
		}

		private void PvpInstanceEnter(RemoteMessageEventArgs args)
		{
			PvpEntryResponse pvpEntryResponse = (PvpEntryResponse)args.remoteMessage;
			HandlePvpInfo(pvpEntryResponse.pvpInfo);
		}

		private void PvpCheckReceived(RemoteMessageEventArgs args)
		{
			PvpCheckMessage pvpCheckMessage = (PvpCheckMessage)args.remoteMessage;
			if (pvpCheckMessage.pvpInfo != null)
			{
				authModel.alreadyInPvp = true;
				pvpModel_.alreadyInPvp = true;
				authModel.HasNickname = true;
				HandlePvpInfo(pvpCheckMessage.pvpInfo);
			}
			authModel.checkCompleted = true;
		}

		private void HandlePvpInfo(PvpInfoMessage info)
		{
			pvpModel_.enteredPvp = true;
			pvpModel_.serverUrl = info.ip;
			pvpModel_.serverPort = info.tcpPort;
			pvpModel_.mapId = ((info.islandId <= 0) ? info.mapId : info.islandId);
		}

		public void SendPersCreate(string characterName)
		{
			PersCreateCommand persCreateCommand = new PersCreateCommand(httpModel.userId, httpModel.sessionId);
			if (!string.IsNullOrEmpty(characterName))
			{
				persCreateCommand.name = characterName;
			}
			http.Send<PersCreateMessage>(persCreateCommand, ReportPersCreated, httpModel.gameServerUrl);
		}

		public void SendPersEnter()
		{
			SendPersEnter(httpModel.persId);
		}

		public void SendPersEnter(string persId)
		{
			http.Send<RemoteMessage>(new PersEnterCommand(httpModel.userId, persId, httpModel.sessionId), ReportPersEnter, httpModel.gameServerUrl);
		}

		public void SendSync()
		{
			SyncLuaCommand syncLuaCommand = new SyncLuaCommand();
			syncLuaCommand.ResponceRecieved += HandleSyncResponceRecieved;
			http.Send<SyncMessage>(syncLuaCommand, HandleSync);
		}

		private void HandleSyncResponceRecieved(AmfObject amfObject)
		{
			SyncManager singleton;
			if (SingletonManager.TryGet<SyncManager>(out singleton))
			{
				singleton.reportOnNextUpdate = true;
				singleton.SetObject(amfObject, true);
			}
		}

		private void HandleSync(RemoteMessageEventArgs args)
		{
			SyncMessage syncMessage = (SyncMessage)args.remoteMessage;
			authModel.HasSyncMessage = true;
			authModel.HasNickname = !string.IsNullOrEmpty(syncMessage.player.main[0].name);
		}

		private void ReportPersCreated(RemoteMessageEventArgs obj)
		{
			PersCreateMessage persCreateMessage = (PersCreateMessage)obj.remoteMessage;
			httpModel.persId = persCreateMessage.persId;
		}

		private void ReportPersEnter(RemoteMessageEventArgs obj)
		{
			authModel.persEntered = true;
		}

		public void SendSetNickname(string nickname)
		{
			http.Send(new SetNameLuaCommand(nickname));
		}

		public void SendPing()
		{
			http.Send(new PingLuaCommand(), httpModel.gameServerUrl);
		}
	}
}

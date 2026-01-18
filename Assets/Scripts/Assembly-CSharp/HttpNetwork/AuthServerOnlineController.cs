using System;
using System.Collections.Generic;
using Authorization;
using RemoteData.Auth;
using UnityEngine;

namespace HttpNetwork
{
	public class AuthServerOnlineController : ServerOnlineControllerBase
	{
		public void SendGetServers()
		{
			ServersCommand command = new ServersCommand(httpModel.userId, httpModel.sessionId);
			http.Send<ServersMessage>(command, GetServersRead, authModel.authServerUrl);
		}

		public void SendLogin(string login, string password)
		{
			if (AuthorizationModel.debugGibberish)
			{
				login = "debugGibberish";
			}
			LoginCommand loginCommand = new LoginCommand(login, password, CompileConstants.PLATFORM, GetLocale(), authModel.deviceId, DataStorage.version);
			loginCommand.pushToken = authModel.pushDeviceId;
			loginCommand.notFromStore = ((!authModel.isInstalledFromStore) ? 1 : 0);
			http.Send<LoginResponse>(loginCommand, ReportLogin, authModel.authServerUrl);
		}

		public void SendRegistrationGuest()
		{
			RegistrationGuestCommand registrationGuestCommand = new RegistrationGuestCommand(CompileConstants.PLATFORM, GetLocale(), authModel.deviceId, DataStorage.version, DataStorage.bundleIdentifier);
			registrationGuestCommand.pushToken = authModel.pushDeviceId;
			registrationGuestCommand.notFromStore = ((!authModel.isInstalledFromStore) ? 1 : 0);
			http.Send<RegistrationGuestResponse>(registrationGuestCommand, ReportRegistrationCompleted, authModel.authServerUrl);
		}

		public void SendServerEnter(string serverId)
		{
			ServerMessage serverMessage = authModel.allServers.serversById[serverId];
			authModel.persList = serverMessage.persList;
			http.Send<ServerEnterMessage>(new ServerEnterCommand(httpModel.userId, httpModel.sessionId, serverId), ReportServerEnter, authModel.authServerUrl);
		}

		private string GetLocale()
		{
			return (Application.systemLanguage != SystemLanguage.Russian) ? "en_US" : "ru_RU";
		}

		private void GetServersRead(RemoteMessageEventArgs args)
		{
			authModel.allServers = (ServersMessage)args.remoteMessage;
			authModel.allServers.serversById = new Dictionary<string, ServerMessage>();
			authModel.allServers.persById = new Dictionary<string, PersMessage>();
			for (int i = 0; i < authModel.allServers.serverList.Length; i++)
			{
				ServerMessage serverMessage = authModel.allServers.serverList[i];
				serverMessage.persList = new List<PersMessage>();
				authModel.allServers.serversById[serverMessage.id] = serverMessage;
				for (int j = 0; j < authModel.allServers.persList.Length; j++)
				{
					PersMessage persMessage = authModel.allServers.persList[j];
					if (persMessage.serverId == serverMessage.id)
					{
						serverMessage.persList.Add(persMessage);
						authModel.allServers.persById[persMessage.persId] = persMessage;
					}
				}
			}
		}

		private void ReportLogin(RemoteMessageEventArgs obj)
		{
			LoginResponse loginResponse = (LoginResponse)obj.remoteMessage;
			httpModel.sessionId = loginResponse.sid;
			httpModel.userId = loginResponse.userId;
			authModel.serverVersion = loginResponse.serverVersion;
		}

		private void ReportRegistrationCompleted(RemoteMessageEventArgs obj)
		{
			authModel.registrationGuest = (RegistrationGuestResponse)obj.remoteMessage;
			httpModel.sessionId = authModel.registrationGuest.sid;
			httpModel.userId = authModel.registrationGuest.userId;
			authModel.registrationTimestamp = Convert.ToInt32(authModel.registrationGuest.ctime);
			authModel.registered = true;
		}

		private void ReportServerEnter(RemoteMessageEventArgs args)
		{
			ServerEnterMessage serverEnterMessage = (ServerEnterMessage)args.remoteMessage;
			httpModel.gameServerUrl = serverEnterMessage.url;
			authModel.chatIp = serverEnterMessage.chatIp;
			authModel.chatPort = serverEnterMessage.chatTcpPort;
		}

		public void SendDefaultServerEnter()
		{
			ServerMessage serverMessage = authModel.allServers.serverList[0];
			if (serverMessage.persList.Count > 0)
			{
				httpModel.persId = serverMessage.persList[0].persId;
			}
			SendServerEnter(serverMessage.id);
		}
	}
}

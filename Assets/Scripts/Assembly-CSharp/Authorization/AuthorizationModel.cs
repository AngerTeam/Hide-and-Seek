using System;
using System.Collections.Generic;
using GameInfrastructure;
using RemoteData.Auth;
using UnityEngine;

namespace Authorization
{
	[Serializable]
	public class AuthorizationModel : Singleton
	{
		public static bool debugGibberish;

		public bool started;

		public bool HasNickname;

		public bool HasSyncMessage;

		public bool checkCompleted;

		public bool alreadyInPvp;

		public bool persEntered;

		public AuthorisationResult result;

		public bool registered;

		public bool newUser;

		public string pushDeviceId;

		public bool isInstalledFromStore;

		public string deviceId;

		public int registrationTimestamp;

		public string chatIp;

		public int chatPort;

		public List<PersMessage> persList;

		public int serverVersion;

		public int islandId;

		public string instanceId;

		public ServersMessage allServers;

		public string authServerUrl;

		public RegistrationGuestResponse registrationGuest;

		private HttpOnlineModel http_;

		public bool HasSession
		{
			get
			{
				return !string.IsNullOrEmpty(http_.sessionId);
			}
		}

		public bool HasServerList
		{
			get
			{
				return allServers != null;
			}
		}

		public bool HasPers
		{
			get
			{
				return !string.IsNullOrEmpty(http_.persId);
			}
		}

		public bool HasGameServer
		{
			get
			{
				return !string.IsNullOrEmpty(http_.gameServerUrl);
			}
		}

		public AuthorizationModel()
		{
			deviceId = SystemInfo.deviceUniqueIdentifier;
		}

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineModel>(out http_);
		}
	}
}

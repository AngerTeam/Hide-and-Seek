using Interlace.Amf;

namespace RemoteData.Auth
{
	public class RegistrationGuestCommand : RemoteCommand
	{
		private string pf;

		private string locale;

		private string udid;

		private string clientVersion;

		private string bid;

		public int? notFromStore;

		public string pushToken;

		private int? offlineUserId;

		private int? offlineCrystals;

		public RegistrationGuestCommand(string pf, string locale, string udid, string clientVersion, string bid, int? offlineUserId, int? offlineCrystals)
		{
			this.pf = pf;
			this.locale = locale;
			this.udid = udid;
			this.clientVersion = clientVersion;
			this.bid = bid;
			this.offlineUserId = offlineUserId;
			this.offlineCrystals = offlineCrystals;
			cmd = "registration_guest";
		}

		public RegistrationGuestCommand(string pf, string locale, string udid, string clientVersion, string bid)
		{
			this.pf = pf;
			this.locale = locale;
			this.udid = udid;
			this.clientVersion = clientVersion;
			this.bid = bid;
			cmd = "registration_guest";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["pf"] = pf;
			amfObject.Properties["locale"] = locale;
			amfObject.Properties["udid"] = udid;
			amfObject.Properties["client_version"] = clientVersion;
			amfObject.Properties["bid"] = bid;
			if (notFromStore.HasValue)
			{
				amfObject.Properties["not_from_store"] = notFromStore;
			}
			if (pushToken != null)
			{
				amfObject.Properties["push_token"] = pushToken;
			}
			if (offlineUserId.HasValue)
			{
				amfObject.Properties["offline_user_id"] = offlineUserId;
			}
			if (offlineCrystals.HasValue)
			{
				amfObject.Properties["offline_crystals"] = offlineCrystals;
			}
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("RegistrationGuestCommand: pf: {0}; locale: {1}; udid: {2}; clientVersion: {3}; bid: {4}; notFromStore: {5}; pushToken: {6}; offlineUserId: {7}; offlineCrystals: {8};", pf, locale, udid, clientVersion, bid, notFromStore, pushToken, offlineUserId, offlineCrystals);
		}
	}
}

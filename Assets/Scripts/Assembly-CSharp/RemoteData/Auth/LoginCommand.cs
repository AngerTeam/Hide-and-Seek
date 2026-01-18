using Interlace.Amf;

namespace RemoteData.Auth
{
	public class LoginCommand : RemoteCommand
	{
		private string email;

		private string passwd;

		private string pf;

		private string locale;

		private string udid;

		private string clientVersion;

		public int? notFromStore;

		public string pushToken;

		public LoginCommand(string email, string passwd, string pf, string locale, string udid, string clientVersion)
		{
			this.email = email;
			this.passwd = passwd;
			this.pf = pf;
			this.locale = locale;
			this.udid = udid;
			this.clientVersion = clientVersion;
			cmd = "login";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["email"] = email;
			amfObject.Properties["passwd"] = passwd;
			amfObject.Properties["pf"] = pf;
			amfObject.Properties["locale"] = locale;
			amfObject.Properties["udid"] = udid;
			amfObject.Properties["client_version"] = clientVersion;
			if (notFromStore.HasValue)
			{
				amfObject.Properties["not_from_store"] = notFromStore;
			}
			if (pushToken != null)
			{
				amfObject.Properties["push_token"] = pushToken;
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
			return string.Format("LoginCommand: email: {0}; passwd: {1}; pf: {2}; locale: {3}; udid: {4}; clientVersion: {5}; notFromStore: {6}; pushToken: {7};", email, "***", pf, locale, udid, clientVersion, notFromStore, pushToken);
		}
	}
}

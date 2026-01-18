using Interlace.Amf;

namespace RemoteData.Auth
{
	public class EmailConfirmCommand : RemoteCommand
	{
		private int userId;

		private string sid;

		private string email;

		private string passwd;

		private string pf;

		private string locale;

		public EmailConfirmCommand(int userId, string sid, string email, string passwd, string pf, string locale)
		{
			this.userId = userId;
			this.sid = sid;
			this.email = email;
			this.passwd = passwd;
			this.pf = pf;
			this.locale = locale;
			cmd = "email_confirm";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["sid"] = sid;
			amfObject.Properties["email"] = email;
			amfObject.Properties["passwd"] = passwd;
			amfObject.Properties["pf"] = pf;
			amfObject.Properties["locale"] = locale;
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
			return string.Format("EmailConfirmCommand: userId: {0}; email: {1}; passwd: {2}; pf: {3}; locale: {4};", userId, email, "***", pf, locale);
		}
	}
}

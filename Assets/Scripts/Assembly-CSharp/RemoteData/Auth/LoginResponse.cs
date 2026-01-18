using Interlace.Amf;

namespace RemoteData.Auth
{
	public class LoginResponse : RemoteMessage
	{
		public string sid;

		public int userId;

		public int guest;

		public double ctime;

		public int serverVersion;

		public LoginResponse(string sid, int userId, int guest, double ctime, int serverVersion)
		{
			this.sid = sid;
			this.userId = userId;
			this.guest = guest;
			this.ctime = ctime;
			this.serverVersion = serverVersion;
		}

		public LoginResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			sid = Get<string>(source, "sid", false);
			userId = Get<int>(source, "user_id", false);
			guest = Get<int>(source, "guest", false);
			ctime = Get<double>(source, "ctime", false);
			serverVersion = Get<int>(source, "server_version", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("LoginResponse: userId: {0}; guest: {1}; ctime: {2}; serverVersion: {3};", userId, guest, ctime, serverVersion);
		}
	}
}

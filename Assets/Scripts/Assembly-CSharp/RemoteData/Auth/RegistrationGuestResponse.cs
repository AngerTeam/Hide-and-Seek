using Interlace.Amf;

namespace RemoteData.Auth
{
	public class RegistrationGuestResponse : RemoteMessage
	{
		public string sid;

		public int userId;

		public string email;

		public string passwd;

		public double ctime;

		public int guest;

		public RegistrationGuestResponse(string sid, int userId, string email, string passwd, double ctime, int guest)
		{
			this.sid = sid;
			this.userId = userId;
			this.email = email;
			this.passwd = passwd;
			this.ctime = ctime;
			this.guest = guest;
		}

		public RegistrationGuestResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			sid = Get<string>(source, "sid", false);
			userId = Get<int>(source, "user_id", false);
			email = Get<string>(source, "email", false);
			passwd = Get<string>(source, "passwd", false);
			ctime = Get<double>(source, "ctime", false);
			guest = Get<int>(source, "guest", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("RegistrationGuestResponse: userId: {0}; email: {1}; passwd: {2}; ctime: {3}; guest: {4};", userId, email, "***", ctime, guest);
		}
	}
}

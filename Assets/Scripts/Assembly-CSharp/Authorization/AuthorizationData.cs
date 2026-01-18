using System;

namespace Authorization
{
	[Serializable]
	public class AuthorizationData
	{
		public string login;

		public string password;

		public int registrationTimestamp;
	}
}

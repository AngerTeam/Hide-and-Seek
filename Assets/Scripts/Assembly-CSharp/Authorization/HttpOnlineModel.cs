namespace Authorization
{
	public class HttpOnlineModel : Singleton
	{
		public int userId;

		public string persId;

		public string sessionId;

		public string gameServerUrl;

		public bool HasSession
		{
			get
			{
				return !string.IsNullOrEmpty(sessionId);
			}
		}
	}
}

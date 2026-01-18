namespace HttpNetwork
{
	public class PvpAuthorizationModel : Singleton
	{
		public string serverUrl;

		public int serverPort;

		public int mapId;

		public int mapModeId;

		public bool comaback;

		public bool autoSendReady;

		public bool enteredPvp;

		public bool alreadyInPvp;

		public void Reset()
		{
			autoSendReady = false;
			enteredPvp = false;
			alreadyInPvp = false;
			mapId = 0;
		}
	}
}

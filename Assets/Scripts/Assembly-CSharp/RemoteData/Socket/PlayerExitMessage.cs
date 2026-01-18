using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerExitMessage : RemoteMessage
	{
		public string persId;

		public PlayerExitMessage(string persId)
		{
			this.persId = persId;
		}

		public PlayerExitMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerExitMessage: persId: {0};", persId);
		}
	}
}

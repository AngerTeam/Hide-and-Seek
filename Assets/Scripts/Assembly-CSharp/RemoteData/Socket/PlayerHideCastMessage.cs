using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerHideCastMessage : RemoteMessage
	{
		public string persId;

		public PlayerHideCastMessage(string persId)
		{
			this.persId = persId;
		}

		public PlayerHideCastMessage()
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
			return string.Format("PlayerHideCastMessage: persId: {0};", persId);
		}
	}
}

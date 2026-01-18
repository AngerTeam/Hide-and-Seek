using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ChangeSkinMessage : RemoteMessage
	{
		public string persId;

		public int skinId;

		public ChangeSkinMessage(string persId, int skinId)
		{
			this.persId = persId;
			this.skinId = skinId;
		}

		public ChangeSkinMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			skinId = Get<int>(source, "skin_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChangeSkinMessage: persId: {0}; skinId: {1};", persId, skinId);
		}
	}
}

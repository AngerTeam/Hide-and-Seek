using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerAppearMessage : RemoteMessage
	{
		public string persId;

		public int x;

		public int y;

		public int z;

		public PlayerAppearMessage(string persId, IIntVector3 vector)
		{
			this.persId = persId;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
		}

		public PlayerAppearMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			x = Get<int>(source, "x", false);
			y = Get<int>(source, "y", false);
			z = Get<int>(source, "z", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerAppearMessage: persId: {0}; x: {1}; y: {2}; z: {3};", persId, x, y, z);
		}
	}
}

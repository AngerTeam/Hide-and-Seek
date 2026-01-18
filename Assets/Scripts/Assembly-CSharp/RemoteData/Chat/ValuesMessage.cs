using Interlace.Amf;

namespace RemoteData.Chat
{
	public class ValuesMessage : RemoteMessage
	{
		public string killer;

		public string seeker;

		public string hider;

		public string deadman;

		public string name;

		public override void Deserialize(AmfObject source, bool silent)
		{
			killer = Get<string>(source, "killer", true);
			seeker = Get<string>(source, "seeker", true);
			hider = Get<string>(source, "hider", true);
			deadman = Get<string>(source, "deadman", true);
			name = Get<string>(source, "name", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChatValuesMessage: killer: {0}; seeker: {1}; hider: {2}; deadman: {3}; name: {4};", killer, seeker, hider, deadman, name);
		}
	}
}

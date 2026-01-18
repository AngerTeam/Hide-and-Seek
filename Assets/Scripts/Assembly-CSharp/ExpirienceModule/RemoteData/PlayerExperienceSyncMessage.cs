using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace ExpirienceModule.RemoteData
{
	public class PlayerExperienceSyncMessage : RemoteMessage
	{
		public PlayerSyncExperienceMessage[] expLevel;

		public PlayerExperienceSyncMessage(PlayerSyncExperienceMessage[] expLevel)
		{
			this.expLevel = expLevel;
		}

		public PlayerExperienceSyncMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			expLevel = GetArray<PlayerSyncExperienceMessage>(source, "exp_level");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerExperienceSyncMessage:\n expLevel: {0}", ArrayUtils.ArrayToString(expLevel, "\n\t"));
		}
	}
}

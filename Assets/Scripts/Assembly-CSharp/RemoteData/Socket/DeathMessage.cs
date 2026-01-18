using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class DeathMessage : RemoteMessage
	{
		public string persId;

		public MemberMessage[] membersUpdate;

		public DeathMessage(string persId)
		{
			this.persId = persId;
		}

		public DeathMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("DeathMessage: persId: {0};\n membersUpdate: {1}", persId, ArrayUtils.ArrayToString(membersUpdate, "\n\t"));
		}
	}
}

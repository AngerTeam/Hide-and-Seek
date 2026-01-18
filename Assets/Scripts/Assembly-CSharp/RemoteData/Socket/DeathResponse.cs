using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class DeathResponse : RemoteMessage
	{
		public MemberMessage[] membersUpdate;

		public override void Deserialize(AmfObject source, bool silent)
		{
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("DeathResponse:\n membersUpdate: {0}", ArrayUtils.ArrayToString(membersUpdate, "\n\t"));
		}
	}
}

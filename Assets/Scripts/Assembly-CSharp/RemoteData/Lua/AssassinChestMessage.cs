using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AssassinChestMessage : RemoteMessage
	{
		public int slotId;

		public int kills;

		public int total;

		public AssassinChestMessage(int slotId, int kills, int total)
		{
			this.slotId = slotId;
			this.kills = kills;
			this.total = total;
		}

		public AssassinChestMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<int>(source, "slot_id", false);
			kills = Get<int>(source, "kills", false);
			total = Get<int>(source, "total", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AssassinChestMessage: slotId: {0}; kills: {1}; total: {2};", slotId, kills, total);
		}
	}
}

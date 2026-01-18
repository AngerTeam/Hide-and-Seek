using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PlayerChestsSyncMessage : RemoteMessage
	{
		public ChestSlotsMessage[] chestSlots;

		public AdChestMessage[] adChest;

		public AssassinChestMessage[] assassinChest;

		public PlayerChestsSyncMessage(AdChestMessage[] adChest, AssassinChestMessage[] assassinChest)
		{
			this.adChest = adChest;
			this.assassinChest = assassinChest;
		}

		public PlayerChestsSyncMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			chestSlots = GetArray<ChestSlotsMessage>(source, "chest_slots", true);
			adChest = GetArray<AdChestMessage>(source, "ad_chest");
			assassinChest = GetArray<AssassinChestMessage>(source, "assassin_chest");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerChestsSyncMessage:\n chestSlots: {0}\n adChest: {1}\n assassinChest: {2}", ArrayUtils.ArrayToString(chestSlots, "\n\t"), ArrayUtils.ArrayToString(adChest, "\n\t"), ArrayUtils.ArrayToString(assassinChest, "\n\t"));
		}
	}
}

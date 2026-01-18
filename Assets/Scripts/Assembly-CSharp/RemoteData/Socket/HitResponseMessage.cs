using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HitResponseMessage : RemoteMessage
	{
		public string target;

		public int damage;

		public int health;

		public SlotMessage[] slotUpdate;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public HitResponseMessage(string target, int damage, int health)
		{
			this.target = target;
			this.damage = damage;
			this.health = health;
		}

		public HitResponseMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			target = Get<string>(source, "target", false);
			damage = Get<int>(source, "damage", false);
			health = Get<int>(source, "health", false);
			slotUpdate = GetArray<SlotMessage>(source, "slot_update", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("HitResponseMessage: target: {0}; damage: {1}; health: {2};\n slotUpdate: {3}\n membersUpdate: {4}\n teamData: {5}", target, damage, health, ArrayUtils.ArrayToString(slotUpdate, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

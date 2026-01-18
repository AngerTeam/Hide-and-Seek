using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HitMessage : RemoteMessage
	{
		public string actor;

		public string target;

		public int damage;

		public int health;

		public int artikulId;

		public VectorMessage direction;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public HitMessage(string actor, string target, int damage, int health)
		{
			this.actor = actor;
			this.target = target;
			this.damage = damage;
			this.health = health;
		}

		public HitMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			actor = Get<string>(source, "actor", false);
			target = Get<string>(source, "target", false);
			damage = Get<int>(source, "damage", false);
			health = Get<int>(source, "health", false);
			artikulId = Get<int>(source, "artikul_id", true);
			direction = GetMessage<VectorMessage>(source, "direction", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("HitMessage: actor: {0}; target: {1}; damage: {2}; health: {3}; artikulId: {4}; direction: {5};\n membersUpdate: {6}\n teamData: {7}", actor, target, damage, health, artikulId, direction, ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

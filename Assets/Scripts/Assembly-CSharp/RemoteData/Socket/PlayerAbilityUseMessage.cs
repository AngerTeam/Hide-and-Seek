using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerAbilityUseMessage : RemoteMessage
	{
		public string actor;

		public int artikulId;

		public int abilityId;

		public VectorMessage direction;

		public DamageDataMessage[] damageList;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public PlayerAbilityUseMessage(string actor, int artikulId, int abilityId)
		{
			this.actor = actor;
			this.artikulId = artikulId;
			this.abilityId = abilityId;
		}

		public PlayerAbilityUseMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			actor = Get<string>(source, "actor", false);
			artikulId = Get<int>(source, "artikul_id", false);
			abilityId = Get<int>(source, "ability_id", false);
			direction = GetMessage<VectorMessage>(source, "direction", true);
			damageList = GetArray<DamageDataMessage>(source, "damage_list", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AbilitiesPlayerAbilityUseMessage: actor: {0}; artikulId: {1}; abilityId: {2}; direction: {3};\n damageList: {4}\n membersUpdate: {5}\n teamData: {6}", actor, artikulId, abilityId, direction, ArrayUtils.ArrayToString(damageList, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class AbilityUseResponse : RemoteMessage
	{
		public DamageDataMessage[] damageList;

		public SlotUpdateMessage[] slotUpdate;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public AbilityUseResponse(DamageDataMessage[] damageList)
		{
			this.damageList = damageList;
		}

		public AbilityUseResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			damageList = GetArray<DamageDataMessage>(source, "damage_list");
			slotUpdate = GetArray<SlotUpdateMessage>(source, "slot_update", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AbilitiesAbilityUseResponse:\n damageList: {0}\n slotUpdate: {1}\n membersUpdate: {2}\n teamData: {3}", ArrayUtils.ArrayToString(damageList, "\n\t"), ArrayUtils.ArrayToString(slotUpdate, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

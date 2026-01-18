using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ProjectileHitResponse : RemoteMessage
	{
		public string actor;

		public PlayerDamageMessage[] playersDamageList;

		public VoxelMessage[] voxelChangeList;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public ProjectileHitResponse(string actor)
		{
			this.actor = actor;
		}

		public ProjectileHitResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			actor = Get<string>(source, "actor", false);
			playersDamageList = GetArray<PlayerDamageMessage>(source, "players_damage_list", true);
			voxelChangeList = GetArray<VoxelMessage>(source, "voxel_change_list", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ProjectileHitResponse: actor: {0};\n playersDamageList: {1}\n voxelChangeList: {2}\n membersUpdate: {3}\n teamData: {4}", actor, ArrayUtils.ArrayToString(playersDamageList, "\n\t"), ArrayUtils.ArrayToString(voxelChangeList, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

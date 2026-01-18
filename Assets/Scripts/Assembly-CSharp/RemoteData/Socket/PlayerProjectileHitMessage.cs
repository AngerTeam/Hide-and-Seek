using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerProjectileHitMessage : RemoteMessage
	{
		public string actor;

		public VectorMessage point;

		public int artikulId;

		public int projectileId;

		public PlayerDamageMessage[] playersDamageList;

		public VoxelMessage[] voxelChangeList;

		public MemberMessage[] membersUpdate;

		public TeamDataMessage[] teamData;

		public PlayerProjectileHitMessage(string actor, VectorMessage point, int artikulId, int projectileId)
		{
			this.actor = actor;
			this.point = point;
			this.artikulId = artikulId;
			this.projectileId = projectileId;
		}

		public PlayerProjectileHitMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			actor = Get<string>(source, "actor", false);
			point = GetMessage<VectorMessage>(source, "point");
			artikulId = Get<int>(source, "artikul_id", false);
			projectileId = Get<int>(source, "projectile_id", false);
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
			return string.Format("PlayerProjectileHitMessage: actor: {0}; point: {1}; artikulId: {2}; projectileId: {3};\n playersDamageList: {4}\n voxelChangeList: {5}\n membersUpdate: {6}\n teamData: {7}", actor, point, artikulId, projectileId, ArrayUtils.ArrayToString(playersDamageList, "\n\t"), ArrayUtils.ArrayToString(voxelChangeList, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}

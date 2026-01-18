using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerProjectileShotMessage : RemoteMessage
	{
		public string persId;

		public float clock;

		public int artikulId;

		public int projectileId;

		public VectorMessage position;

		public VectorMessage direction;

		public VectorMessage[] trajectory;

		public PlayerProjectileShotMessage(string persId, float clock, int artikulId, int projectileId, VectorMessage position, VectorMessage direction, VectorMessage[] trajectory)
		{
			this.persId = persId;
			this.clock = clock;
			this.artikulId = artikulId;
			this.projectileId = projectileId;
			this.position = position;
			this.direction = direction;
			this.trajectory = trajectory;
		}

		public PlayerProjectileShotMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			clock = Get<float>(source, "clock", false);
			artikulId = Get<int>(source, "artikul_id", false);
			projectileId = Get<int>(source, "projectile_id", false);
			position = GetMessage<VectorMessage>(source, "position");
			direction = GetMessage<VectorMessage>(source, "direction");
			trajectory = GetArray<VectorMessage>(source, "trajectory");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerProjectileShotMessage: persId: {0}; clock: {1}; artikulId: {2}; projectileId: {3}; position: {4}; direction: {5};\n trajectory: {6}", persId, clock, artikulId, projectileId, position, direction, ArrayUtils.ArrayToString(trajectory, "\n\t"));
		}
	}
}

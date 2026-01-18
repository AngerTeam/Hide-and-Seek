using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ProjectileShotCommand : RemoteCommand
	{
		public int? artikulId;

		private VectorMessage direction;

		private VectorMessage[] trajectory;

		public ProjectileShotCommand(VectorMessage direction, VectorMessage[] trajectory)
		{
			this.direction = direction;
			this.trajectory = trajectory;
			cmd = "projectile_shot";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			if (artikulId.HasValue)
			{
				amfObject.Properties["artikul_id"] = artikulId;
			}
			amfObject.Properties["direction"] = direction.Serialize();
			amfObject.Properties["trajectory"] = GetMessageAmfArray(trajectory);
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("ProjectileShotCommand: artikulId: {0}; direction: {1};\n trajectory: {2}", artikulId, direction, ArrayUtils.ArrayToString(trajectory, "\n\t"));
		}
	}
}

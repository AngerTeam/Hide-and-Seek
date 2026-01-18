using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ProjectileHitCommand : RemoteCommand
	{
		private int clientProjectileId;

		private VectorMessage point;

		private string[] targets;

		private VectorMessage[] voxels;

		public ProjectileHitCommand(int clientProjectileId, VectorMessage point, string[] targets, VectorMessage[] voxels)
		{
			this.clientProjectileId = clientProjectileId;
			this.point = point;
			this.targets = targets;
			this.voxels = voxels;
			cmd = "projectile_hit";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["client_projectile_id"] = clientProjectileId;
			amfObject.Properties["point"] = point.Serialize();
			amfObject.Properties["targets"] = GetAmfArray(targets);
			amfObject.Properties["voxels"] = GetMessageAmfArray(voxels);
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
			return string.Format("ProjectileHitCommand: clientProjectileId: {0}; point: {1};\n targets: {2}\n voxels: {3}", clientProjectileId, point, ArrayUtils.ArrayToString(targets, "\n\t"), ArrayUtils.ArrayToString(voxels, "\n\t"));
		}
	}
}

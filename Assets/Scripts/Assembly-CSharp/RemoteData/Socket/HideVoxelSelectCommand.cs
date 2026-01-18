using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HideVoxelSelectCommand : RemoteCommand
	{
		private int voxelId;

		public HideVoxelSelectCommand(int voxelId)
		{
			this.voxelId = voxelId;
			cmd = "hide_voxel_select";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["voxel_id"] = voxelId;
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
			return string.Format("HideVoxelSelectCommand: voxelId: {0};", voxelId);
		}
	}
}

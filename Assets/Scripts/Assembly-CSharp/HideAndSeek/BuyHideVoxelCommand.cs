using Interlace.Amf;
using RemoteData;

namespace HideAndSeek
{
	public class BuyHideVoxelCommand : RemoteCommand
	{
		private int voxelId;

		public int? count;

		public BuyHideVoxelCommand(int voxelId)
		{
			this.voxelId = voxelId;
			cmd = "buy_hide_voxel";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["voxel_id"] = voxelId;
			if (count.HasValue)
			{
				amfObject.Properties["cnt"] = count;
			}
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
			return string.Format("BuyHideVoxelCommand: voxelId: {0}; count: {1};", voxelId, count);
		}
	}
}

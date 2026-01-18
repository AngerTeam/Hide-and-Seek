using Interlace.Amf;
using RemoteData;

namespace HideAndSeek
{
	public class BuyHideVoxelLuaCommand : RemoteLuaCommand
	{
		private int voxelId;

		public int? count;

		public BuyHideVoxelLuaCommand(int voxelId)
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
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["sid"] = sid;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("BuyHideVoxelLuaCommand: voxelId: {0}; count: {1};", voxelId, count);
		}
	}
}

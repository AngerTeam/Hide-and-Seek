using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AdViewLuaCommand : RemoteLuaCommand
	{
		private string chestPos;

		public AdViewLuaCommand(string chestPos)
		{
			this.chestPos = chestPos;
			cmd = "ad_view";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["chest_pos"] = chestPos;
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
			return string.Format("AdViewLuaCommand: chestPos: {0};", chestPos);
		}
	}
}

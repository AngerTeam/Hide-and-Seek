using Interlace.Amf;

namespace RemoteData.Lua
{
	public class SetSkinLuaCommand : RemoteLuaCommand
	{
		private int skinId;

		public SetSkinLuaCommand(int skinId)
		{
			this.skinId = skinId;
			cmd = "set_skin";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["skin_id"] = skinId;
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
			return string.Format("SetSkinLuaCommand: skinId: {0};", skinId);
		}
	}
}

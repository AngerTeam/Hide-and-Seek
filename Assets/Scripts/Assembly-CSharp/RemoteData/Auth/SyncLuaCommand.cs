using Interlace.Amf;

namespace RemoteData.Auth
{
	public class SyncLuaCommand : RemoteLuaCommand
	{
		public SyncLuaCommand()
		{
			cmd = "sync";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
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
			return string.Format("SyncLuaCommand:");
		}
	}
}

using Interlace.Amf;

namespace RemoteData.Lua
{
	public class GameCenterBindLuaCommand : RemoteLuaCommand
	{
		private string gameCenterId;

		private string passwd;

		public GameCenterBindLuaCommand(string gameCenterId, string passwd)
		{
			this.gameCenterId = gameCenterId;
			this.passwd = passwd;
			cmd = "game_center_bind";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["game_center_id"] = gameCenterId;
			amfObject.Properties["passwd"] = passwd;
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
			return string.Format("GameCenterBindLuaCommand: gameCenterId: {0}; passwd: {1};", gameCenterId, "***");
		}
	}
}

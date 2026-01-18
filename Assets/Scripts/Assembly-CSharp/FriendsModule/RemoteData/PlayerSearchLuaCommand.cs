using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class PlayerSearchLuaCommand : RemoteLuaCommand
	{
		private string name;

		public PlayerSearchLuaCommand(string name)
		{
			this.name = name;
			cmd = "player_search";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["name"] = name;
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
			return string.Format("PlayerSearchLuaCommand: name: {0};", name);
		}
	}
}

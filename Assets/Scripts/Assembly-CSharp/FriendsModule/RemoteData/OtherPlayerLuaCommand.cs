using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class OtherPlayerLuaCommand : RemoteLuaCommand
	{
		private string otherPersId;

		public OtherPlayerLuaCommand(string otherPersId)
		{
			this.otherPersId = otherPersId;
			cmd = "other_player";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["other_pers_id"] = otherPersId;
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
			return string.Format("OtherPlayerLuaCommand: otherPersId: {0};", otherPersId);
		}
	}
}

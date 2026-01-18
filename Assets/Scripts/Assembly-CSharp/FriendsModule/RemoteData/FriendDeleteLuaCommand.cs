using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendDeleteLuaCommand : RemoteLuaCommand
	{
		private string friendPersId;

		public FriendDeleteLuaCommand(string friendPersId)
		{
			this.friendPersId = friendPersId;
			cmd = "friend_delete";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["friend_pers_id"] = friendPersId;
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
			return string.Format("FriendDeleteLuaCommand: friendPersId: {0};", friendPersId);
		}
	}
}

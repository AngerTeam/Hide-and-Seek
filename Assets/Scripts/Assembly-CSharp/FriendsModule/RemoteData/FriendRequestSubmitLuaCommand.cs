using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendRequestSubmitLuaCommand : RemoteLuaCommand
	{
		private string reqPersId;

		public FriendRequestSubmitLuaCommand(string reqPersId)
		{
			this.reqPersId = reqPersId;
			cmd = "friend_request_submit";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["req_pers_id"] = reqPersId;
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
			return string.Format("FriendRequestSubmitLuaCommand: reqPersId: {0};", reqPersId);
		}
	}
}

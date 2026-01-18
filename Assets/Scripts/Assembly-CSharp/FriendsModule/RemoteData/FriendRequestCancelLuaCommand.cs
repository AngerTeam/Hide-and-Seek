using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendRequestCancelLuaCommand : RemoteLuaCommand
	{
		private int reqUserId;

		private string reqPersId;

		public FriendRequestCancelLuaCommand(int reqUserId, string reqPersId)
		{
			this.reqUserId = reqUserId;
			this.reqPersId = reqPersId;
			cmd = "friend_request_cancel";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["req_user_id"] = reqUserId;
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
			return string.Format("FriendRequestCancelLuaCommand: reqUserId: {0}; reqPersId: {1};", reqUserId, reqPersId);
		}
	}
}

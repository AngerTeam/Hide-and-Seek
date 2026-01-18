using Interlace.Amf;

namespace RemoteData.Chat
{
	public class GetHistoryCommand : RemoteCommand
	{
		private string persId;

		private int userId;

		private string sid;

		public GetHistoryCommand(string persId, int userId, string sid)
		{
			this.persId = persId;
			this.userId = userId;
			this.sid = sid;
			cmd = "get_history";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["sid"] = sid;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("ChatGetHistoryCommand: persId: {0}; userId: {1};", persId, userId);
		}
	}
}

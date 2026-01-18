using Interlace.Amf;

namespace RemoteData.Chat
{
	public class InitCommand : RemoteCommand
	{
		private string persId;

		private int userId;

		private string sid;

		private int reconnect;

		public InitCommand(string persId, int userId, string sid, int reconnect)
		{
			this.persId = persId;
			this.userId = userId;
			this.sid = sid;
			this.reconnect = reconnect;
			cmd = "init";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["sid"] = sid;
			amfObject.Properties["reconnect"] = reconnect;
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
			return string.Format("ChatInitCommand: persId: {0}; userId: {1}; reconnect: {2};", persId, userId, reconnect);
		}
	}
}

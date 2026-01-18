using Interlace.Amf;

namespace RemoteData.Auth
{
	public class ServerEnterCommand : RemoteCommand
	{
		private int userId;

		private string sid;

		private string serverId;

		public ServerEnterCommand(int userId, string sid, string serverId)
		{
			this.userId = userId;
			this.sid = sid;
			this.serverId = serverId;
			cmd = "server_enter";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["sid"] = sid;
			amfObject.Properties["server_id"] = serverId;
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
			return string.Format("ServerEnterCommand: userId: {0}; serverId: {1};", userId, serverId);
		}
	}
}

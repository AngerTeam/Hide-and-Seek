using Interlace.Amf;

namespace RemoteData.Auth
{
	public class ServersCommand : RemoteCommand
	{
		private int userId;

		private string sid;

		public ServersCommand(int userId, string sid)
		{
			this.userId = userId;
			this.sid = sid;
			cmd = "servers";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
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
			return string.Format("ServersCommand: userId: {0};", userId);
		}
	}
}

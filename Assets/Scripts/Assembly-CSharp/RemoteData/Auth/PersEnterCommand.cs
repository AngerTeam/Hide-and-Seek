using Interlace.Amf;

namespace RemoteData.Auth
{
	public class PersEnterCommand : RemoteCommand
	{
		private int userId;

		private string persId;

		private string sid;

		public PersEnterCommand(int userId, string persId, string sid)
		{
			this.userId = userId;
			this.persId = persId;
			this.sid = sid;
			cmd = "pers_enter";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["pers_id"] = persId;
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
			return string.Format("PersEnterCommand: userId: {0}; persId: {1};", userId, persId);
		}
	}
}

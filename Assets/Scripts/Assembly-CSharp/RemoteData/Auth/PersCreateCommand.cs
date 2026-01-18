using Interlace.Amf;

namespace RemoteData.Auth
{
	public class PersCreateCommand : RemoteCommand
	{
		private int userId;

		private string sid;

		public string name;

		public PersCreateCommand(int userId, string sid)
		{
			this.userId = userId;
			this.sid = sid;
			cmd = "pers_create";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["sid"] = sid;
			if (name != null)
			{
				amfObject.Properties["name"] = name;
			}
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
			return string.Format("PersCreateCommand: userId: {0}; name: {1};", userId, name);
		}
	}
}

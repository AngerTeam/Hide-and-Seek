using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SetNameCommand : RemoteCommand
	{
		private string name;

		public SetNameCommand(string name)
		{
			this.name = name;
			cmd = "set_name";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["name"] = name;
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
			return string.Format("SetNameCommand: name: {0};", name);
		}
	}
}

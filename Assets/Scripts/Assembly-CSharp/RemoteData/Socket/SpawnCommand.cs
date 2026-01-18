using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SpawnCommand : RemoteCommand
	{
		private VectorMessage position;

		public SpawnCommand(VectorMessage position)
		{
			this.position = position;
			cmd = "spawn";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["position"] = position.Serialize();
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
			return string.Format("SpawnCommand: position: {0};", position);
		}
	}
}

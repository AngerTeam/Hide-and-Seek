using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class SyncMapCommand : RemoteCommand
	{
		public SyncMapCommand()
		{
			cmd = "sync_map";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
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
			return string.Format("SyncMapCommand:");
		}
	}
}

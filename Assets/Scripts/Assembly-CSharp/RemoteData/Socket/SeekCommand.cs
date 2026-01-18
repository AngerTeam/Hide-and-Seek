using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SeekCommand : RemoteCommand
	{
		private int x;

		private int y;

		private int z;

		public SeekCommand(IIntVector3 vector)
		{
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
			cmd = "seek";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["x"] = x;
			amfObject.Properties["y"] = y;
			amfObject.Properties["z"] = z;
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
			return string.Format("SeekCommand: x: {0}; y: {1}; z: {2};", x, y, z);
		}
	}
}

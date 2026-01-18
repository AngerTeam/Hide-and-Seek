using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HideCommand : RemoteCommand
	{
		private int x;

		private int y;

		private int z;

		private int rotation;

		public HideCommand(int rotation, IIntVector3 vector)
		{
			this.rotation = rotation;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
			cmd = "hide";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["x"] = x;
			amfObject.Properties["y"] = y;
			amfObject.Properties["z"] = z;
			amfObject.Properties["rotation"] = rotation;
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
			return string.Format("HideCommand: x: {0}; y: {1}; z: {2}; rotation: {3};", x, y, z, rotation);
		}
	}
}

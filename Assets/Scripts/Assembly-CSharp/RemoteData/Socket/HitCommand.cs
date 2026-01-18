using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HitCommand : RemoteCommand
	{
		private string target;

		public VectorMessage direction;

		private int type;

		public HitCommand(string target, int type)
		{
			this.target = target;
			this.type = type;
			cmd = "hit";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["target"] = target;
			if (direction != null)
			{
				amfObject.Properties["direction"] = direction.Serialize();
			}
			amfObject.Properties["type"] = type;
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
			return string.Format("HitCommand: target: {0}; direction: {1}; type: {2};", target, direction, type);
		}
	}
}

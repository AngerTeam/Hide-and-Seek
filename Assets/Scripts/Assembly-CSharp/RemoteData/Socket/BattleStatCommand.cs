using Interlace.Amf;

namespace RemoteData.Socket
{
	public class BattleStatCommand : RemoteCommand
	{
		public BattleStatCommand()
		{
			cmd = "battle_stat";
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
			return string.Format("BattleStatCommand:");
		}
	}
}

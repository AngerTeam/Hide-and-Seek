using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class AbilityUseCommand : RemoteCommand
	{
		public string[] targets;

		public VectorMessage direction;

		public AbilityUseCommand()
		{
			cmd = "ability_use";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			if (targets != null)
			{
				amfObject.Properties["targets"] = GetAmfArray(targets);
			}
			if (direction != null)
			{
				amfObject.Properties["direction"] = direction.Serialize();
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
			return string.Format("AbilitiesAbilityUseCommand: direction: {0};\n targets: {1}", direction, ArrayUtils.ArrayToString(targets, "\n\t"));
		}
	}
}

using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class TeamTopMessage : RemoteMessage
	{
		public int side;

		public TopMessage[] top;

		public TeamTopMessage(int side, TopMessage[] top)
		{
			this.side = side;
			this.top = top;
		}

		public TeamTopMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			side = Get<int>(source, "side", false);
			top = GetArray<TopMessage>(source, "top");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("TeamTopMessage: side: {0};\n top: {1}", side, ArrayUtils.ArrayToString(top, "\n\t"));
		}
	}
}

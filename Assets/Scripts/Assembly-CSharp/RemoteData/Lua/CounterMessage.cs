using Interlace.Amf;

namespace RemoteData.Lua
{
	public class CounterMessage : RemoteMessage
	{
		public string id;

		public int value;

		public CounterMessage(string id, int value)
		{
			this.id = id;
			this.value = value;
		}

		public CounterMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			id = Get<string>(source, "id", false);
			value = Get<int>(source, "value", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("CounterMessage: id: {0}; value: {1};", id, value);
		}
	}
}

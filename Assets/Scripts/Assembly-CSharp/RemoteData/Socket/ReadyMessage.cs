using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ReadyMessage : RemoteMessage
	{
		public int health;

		public VectorMessage position;

		public VectorMessage rotation;

		public double started;

		public ReadyMessage(int health, VectorMessage position, VectorMessage rotation, double started)
		{
			this.health = health;
			this.position = position;
			this.rotation = rotation;
			this.started = started;
		}

		public ReadyMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			health = Get<int>(source, "health", false);
			position = GetMessage<VectorMessage>(source, "position");
			rotation = GetMessage<VectorMessage>(source, "rotation");
			started = Get<double>(source, "started", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ReadyMessage: health: {0}; position: {1}; rotation: {2}; started: {3};", health, position, rotation, started);
		}
	}
}

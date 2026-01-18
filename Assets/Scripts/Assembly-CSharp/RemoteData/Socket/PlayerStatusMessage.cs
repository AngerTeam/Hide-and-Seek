using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerStatusMessage : RemoteMessage
	{
		public string persId;

		public int action;

		public int selectedArtikulId;

		public VectorMessage position;

		public VectorMessage rotation;

		public int time;

		public PlayerStatusMessage(string persId, int action, int selectedArtikulId, VectorMessage position, VectorMessage rotation)
		{
			this.persId = persId;
			this.action = action;
			this.selectedArtikulId = selectedArtikulId;
			this.position = position;
			this.rotation = rotation;
		}

		public PlayerStatusMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			action = Get<int>(source, "action", false);
			selectedArtikulId = Get<int>(source, "selected_artikul_id", false);
			position = GetMessage<VectorMessage>(source, "position");
			rotation = GetMessage<VectorMessage>(source, "rotation");
			time = Get<int>(source, "time", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerStatusMessage: persId: {0}; action: {1}; selectedArtikulId: {2}; position: {3}; rotation: {4}; time: {5};", persId, action, selectedArtikulId, position, rotation, time);
		}
	}
}

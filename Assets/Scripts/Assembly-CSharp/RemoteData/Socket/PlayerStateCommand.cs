using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerStateCommand : RemoteCommand
	{
		public VectorMessage position;

		public VectorMessage rotation;

		public int action;

		public int time;

		public PlayerStateCommand(VectorMessage position, VectorMessage rotation, int action, int time)
		{
			this.position = position;
			this.rotation = rotation;
			this.action = action;
			this.time = time;
			cmd = "player_state";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["position"] = position.Serialize();
			amfObject.Properties["rotation"] = rotation.Serialize();
			amfObject.Properties["action"] = action;
			amfObject.Properties["time"] = time;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("PlayerStateCommand: position: {0}; rotation: {1}; action: {2}; time: {3};", position, rotation, action, time);
		}
	}
}

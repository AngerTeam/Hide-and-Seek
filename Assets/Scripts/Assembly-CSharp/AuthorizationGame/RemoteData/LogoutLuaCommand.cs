using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class LogoutLuaCommand : RemoteLuaCommand
	{
		private VectorMessage position;

		private string curSlotId;

		public LogoutLuaCommand(VectorMessage position, string curSlotId)
		{
			this.position = position;
			this.curSlotId = curSlotId;
			cmd = "logout";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["position"] = position.Serialize();
			amfObject.Properties["cur_slot_id"] = curSlotId;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["sid"] = sid;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("LogoutLuaCommand: position: {0}; curSlotId: {1};", position, curSlotId);
		}
	}
}

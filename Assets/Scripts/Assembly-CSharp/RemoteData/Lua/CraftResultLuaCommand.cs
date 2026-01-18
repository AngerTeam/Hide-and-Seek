using Interlace.Amf;

namespace RemoteData.Lua
{
	public class CraftResultLuaCommand : RemoteLuaCommand
	{
		private int artikulId;

		private int recipeId;

		private int count;

		private int craftCount;

		public string slotId;

		public CraftResultLuaCommand(int artikulId, int recipeId, int count, int craftCount)
		{
			this.artikulId = artikulId;
			this.recipeId = recipeId;
			this.count = count;
			this.craftCount = craftCount;
			cmd = "craft_result";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["recipe_id"] = recipeId;
			amfObject.Properties["cnt"] = count;
			amfObject.Properties["craft_cnt"] = craftCount;
			if (slotId != null)
			{
				amfObject.Properties["slot_id"] = slotId;
			}
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
			return string.Format("CraftResultLuaCommand: artikulId: {0}; recipeId: {1}; count: {2}; craftCount: {3}; slotId: {4};", artikulId, recipeId, count, craftCount, slotId);
		}
	}
}

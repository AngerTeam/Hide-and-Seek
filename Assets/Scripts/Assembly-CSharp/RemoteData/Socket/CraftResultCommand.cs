using Interlace.Amf;

namespace RemoteData.Socket
{
	public class CraftResultCommand : RemoteCommand
	{
		private int artikulId;

		private int recipeId;

		private int count;

		private int craftCount;

		private string slotId;

		public CraftResultCommand(int artikulId, int recipeId, int count, int craftCount, string slotId)
		{
			this.artikulId = artikulId;
			this.recipeId = recipeId;
			this.count = count;
			this.craftCount = craftCount;
			this.slotId = slotId;
			cmd = "craft_result";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["recipe_id"] = recipeId;
			amfObject.Properties["cnt"] = count;
			amfObject.Properties["craft_cnt"] = craftCount;
			amfObject.Properties["slot_id"] = slotId;
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
			return string.Format("CraftResultCommand: artikulId: {0}; recipeId: {1}; count: {2}; craftCount: {3}; slotId: {4};", artikulId, recipeId, count, craftCount, slotId);
		}
	}
}

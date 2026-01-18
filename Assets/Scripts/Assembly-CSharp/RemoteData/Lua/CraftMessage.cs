using Interlace.Amf;

namespace RemoteData.Lua
{
	public class CraftMessage : RemoteMessage
	{
		public string refId;

		public int recipeId;

		public int startTime;

		public CraftMessage(string refId, int recipeId, int startTime)
		{
			this.refId = refId;
			this.recipeId = recipeId;
			this.startTime = startTime;
		}

		public CraftMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			refId = Get<string>(source, "ref_id", false);
			recipeId = Get<int>(source, "recipe_id", false);
			startTime = Get<int>(source, "start_time", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("CraftMessage: refId: {0}; recipeId: {1}; startTime: {2};", refId, recipeId, startTime);
		}
	}
}

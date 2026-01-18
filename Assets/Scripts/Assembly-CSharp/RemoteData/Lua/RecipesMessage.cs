using Interlace.Amf;

namespace RemoteData.Lua
{
	public class RecipesMessage : RemoteMessage
	{
		public int recipeId;

		public int ctime;

		public int ltime;

		public int used;

		public RecipesMessage(int recipeId, int ctime, int ltime, int used)
		{
			this.recipeId = recipeId;
			this.ctime = ctime;
			this.ltime = ltime;
			this.used = used;
		}

		public RecipesMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			recipeId = Get<int>(source, "recipe_id", false);
			ctime = Get<int>(source, "ctime", false);
			ltime = Get<int>(source, "ltime", false);
			used = Get<int>(source, "used", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("RecipesMessage: recipeId: {0}; ctime: {1}; ltime: {2}; used: {3};", recipeId, ctime, ltime, used);
		}
	}
}

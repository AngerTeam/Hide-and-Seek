using CraftyEngine.Content;

namespace FxModule
{
	public class ArtikulFxEntries : ContentItem
	{
		public int id;

		public int artikul_id;

		public int fx_id;

		public override void Deserialize()
		{
			id = TryGetInt(FxContentKeys.id);
			intKey = id;
			artikul_id = TryGetInt(FxContentKeys.artikul_id);
			fx_id = TryGetInt(FxContentKeys.fx_id);
			base.Deserialize();
		}
	}
}

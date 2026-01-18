using CraftyEngine.Content;

namespace SelectModeModule
{
	public class CommonIslandSkinsEntries : ContentItem
	{
		public int id;

		public int island_id;

		public int side;

		public int skin_id;

		public override void Deserialize()
		{
			id = TryGetInt(SelectGameModeKeys.id);
			intKey = id;
			island_id = TryGetInt(SelectGameModeKeys.island_id);
			side = TryGetInt(SelectGameModeKeys.side);
			skin_id = TryGetInt(SelectGameModeKeys.skin_id);
			base.Deserialize();
		}
	}
}

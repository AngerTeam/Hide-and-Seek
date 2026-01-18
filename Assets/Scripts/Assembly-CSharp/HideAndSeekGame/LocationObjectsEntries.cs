using ShapesModule;

namespace HideAndSeekGame
{
	public class LocationObjectsEntries : ShapeInstanceEntries
	{
		public int location_id;

		public int chest_bonus_id;

		public override void Deserialize()
		{
			intKey = id;
			intKey = id;
			location_id = TryGetInt(HideAndSeekGametKeys.location_id);
			chest_bonus_id = TryGetInt(HideAndSeekGametKeys.chest_bonus_id);
			base.Deserialize();
		}
	}
}

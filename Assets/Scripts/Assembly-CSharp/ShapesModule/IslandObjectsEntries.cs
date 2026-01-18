namespace ShapesModule
{
	public class IslandObjectsEntries : ShapeInstanceEntries
	{
		public int template_id;

		public override void Deserialize()
		{
			intKey = id;
			template_id = TryGetInt(ShapesContentKeys.template_id);
			base.Deserialize();
		}
	}
}

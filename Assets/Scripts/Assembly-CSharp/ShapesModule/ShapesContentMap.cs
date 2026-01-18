using System.Collections.Generic;
using CraftyEngine.Content;

namespace ShapesModule
{
	public class ShapesContentMap : ContentMapBase
	{
		public static Dictionary<int, ObjectModelsEntries> ObjectModels;

		public static Dictionary<int, IslandObjectsEntries> IslandObjects;

		public override void Deserialize()
		{
			ShapesContentKeys.Deserialize();
			ObjectModels = ReadInt<ObjectModelsEntries>(ShapesContentKeys.object_models);
			IslandObjects = ReadInt<IslandObjectsEntries>(ShapesContentKeys.island_objects);
			base.Deserialize();
		}
	}
}

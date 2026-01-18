using CraftyEngine.Content;

namespace ShapesModule
{
	public class ShapeInstanceEntries : ContentItem
	{
		public int id;

		public int object_model_id;

		public int type_id;

		public string pos;

		public string rotation;

		public int target_id;

		public int inactive;

		public int flags;

		public int? override_model_id;

		internal bool isPassable;

		internal int starsCount;

		internal bool bigCollider;

		public int ModelId
		{
			get
			{
				return (!override_model_id.HasValue) ? object_model_id : override_model_id.Value;
			}
		}

		public override void Deserialize()
		{
			base.Deserialize();
			id = TryGetInt("id");
			intKey = id;
			object_model_id = TryGetInt("object_model_id");
			type_id = TryGetInt("type_id");
			pos = TryGetString("pos", string.Empty);
			rotation = TryGetString("rotation", string.Empty);
			target_id = TryGetInt("target_id");
			inactive = TryGetInt("inactive");
			flags = TryGetInt("flags");
			base.Deserialize();
		}
	}
}

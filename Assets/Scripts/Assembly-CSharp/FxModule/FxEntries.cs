using CraftyEngine.Content;

namespace FxModule
{
	public class FxEntries : ContentItem
	{
		public int id;

		public string title;

		public string type_id;

		public int anchor_id;

		public int moment_id;

		public float duration;

		public float flight_speed;

		public int first_person;

		public int third_person;

		public int show_before_shot;

		public int show_on_target;

		public string bundle;

		public string GetFullBundlePath()
		{
			return FxContentKeys.GetFullBundlePath6 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(FxContentKeys.id);
			intKey = id;
			title = TryGetString(FxContentKeys.title, string.Empty);
			type_id = TryGetString(FxContentKeys.type_id, string.Empty);
			anchor_id = TryGetInt(FxContentKeys.anchor_id);
			moment_id = TryGetInt(FxContentKeys.moment_id);
			duration = TryGetFloat(FxContentKeys.duration);
			flight_speed = TryGetFloat(FxContentKeys.flight_speed);
			first_person = TryGetInt(FxContentKeys.first_person);
			third_person = TryGetInt(FxContentKeys.third_person);
			show_before_shot = TryGetInt(FxContentKeys.show_before_shot);
			show_on_target = TryGetInt(FxContentKeys.show_on_target);
			bundle = TryGetString(FxContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}

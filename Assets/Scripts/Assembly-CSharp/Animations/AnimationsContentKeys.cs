namespace Animations
{
	public class AnimationsContentKeys
	{
		public static string GetFullBundlePath0;

		public static string GetFullBundleSplitPath1;

		public static string ANIMATIONS_ID_MELEE;

		public static string ANIMATIONS_ID_RUN;

		public static string ANIMATIONS_ID_MELEE_ITEM;

		public static string id;

		public static string title;

		public static string type_id;

		public static string bundle;

		public static string bundle_split;

		public static string animation_settings;

		public static string animations;

		public static void Deserialize()
		{
			GetFullBundlePath0 = "content/animations/";
			GetFullBundleSplitPath1 = "content/animations/split/";
			ANIMATIONS_ID_MELEE = "ANIMATIONS_ID_MELEE";
			ANIMATIONS_ID_RUN = "ANIMATIONS_ID_RUN";
			ANIMATIONS_ID_MELEE_ITEM = "ANIMATIONS_ID_MELEE_ITEM";
			id = "id";
			title = "title";
			type_id = "type_id";
			bundle = "bundle";
			bundle_split = "bundle_split";
			animation_settings = "animation_settings";
			animations = "animations";
		}
	}
}

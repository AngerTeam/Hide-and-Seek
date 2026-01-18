namespace CraftyBundles.Content
{
	public class BundlesContentKeys
	{
		public static string GetFullBundlePath4;

		public static string id;

		public static string title;

		public static string bundle;

		public static string atlases;

		public static void Deserialize()
		{
			GetFullBundlePath4 = "content/atlases/";
			id = "id";
			title = "title";
			bundle = "bundle";
			atlases = "atlases";
		}
	}
}

using CraftyEngine.Content;

namespace CraftyBundles.Content
{
	public class BundlesContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<BundlesContentMap>();
		}
	}
}

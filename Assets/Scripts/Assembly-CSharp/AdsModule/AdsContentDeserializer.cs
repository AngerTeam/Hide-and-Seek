using AdsModule.Content;
using CraftyEngine.Content;

namespace AdsModule
{
	public class AdsContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<AdsContentMap>();
		}
	}
}

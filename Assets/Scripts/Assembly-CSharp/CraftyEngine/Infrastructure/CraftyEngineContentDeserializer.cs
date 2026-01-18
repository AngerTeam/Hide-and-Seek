using CraftyEngine.Content;

namespace CraftyEngine.Infrastructure
{
	public class CraftyEngineContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<CraftyEngineContentMap>();
		}
	}
}

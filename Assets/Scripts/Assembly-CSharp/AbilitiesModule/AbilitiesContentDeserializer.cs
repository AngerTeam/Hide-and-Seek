using AbilitiesModule.Content;
using CraftyEngine.Content;

namespace AbilitiesModule
{
	public class AbilitiesContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<AbilitiesContentMap>();
		}
	}
}

using CraftyEngine.Content;
using PvpModule.Content;

namespace PvpModule.Code
{
	public class PvpModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<PvpModuleContentMap>();
		}
	}
}

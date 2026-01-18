using CraftyEngine.Content;

namespace MoneyModule
{
	public class MoneyModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<MoneyTypesContentMap>();
		}
	}
}

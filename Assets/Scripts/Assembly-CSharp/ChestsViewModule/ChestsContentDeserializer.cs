using ChestsViewModule.Content;
using CraftyEngine.Content;

namespace ChestsViewModule
{
	public class ChestsContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<ChestsContentMap>();
		}
	}
}

using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class GameContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<HideAndSeekGameMap>();
		}
	}
}

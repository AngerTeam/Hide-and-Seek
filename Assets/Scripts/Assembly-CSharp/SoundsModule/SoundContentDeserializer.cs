using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<SoundsContentMap>();
		}
	}
}

using CraftyEngine.Content;

namespace ProjectilesModule
{
	public class ProjectilesModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<ProjectilesContentMap>();
		}
	}
}

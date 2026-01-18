using CraftyEngine.Content;
using HudSystem;
using RecommendedToBuyModule;

namespace GameInfrastructure
{
	public class RecommendedToBuyModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<RecommendedToBuyModuleController>(layer);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<RecommendedToBuyModuleContentMap>();
			GuiModuleHolder.Add<RecommendedToBuyWindow>();
		}
	}
}

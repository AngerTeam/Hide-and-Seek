using CraftyEngine.Content;
using HudSystem;
using SpecialOffersModule;

namespace GameInfrastructure
{
	public class SpecialOffersModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<SpecialOffersModuleController>(layer);
			SingletonManager.Add<SpecialOffersManager>(layer);
			SingletonManager.Add<SpecialOffersOnlineController>(layer);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<SpecialOffersContentMap>();
			GuiModuleHolder.Add<SpecialOfferWindow>();
		}

		public override void Dispose()
		{
		}
	}
}

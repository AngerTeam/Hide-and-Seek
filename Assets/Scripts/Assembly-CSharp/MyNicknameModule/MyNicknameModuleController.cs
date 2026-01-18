using CraftyEngine.Content;
using HudSystem;
using MyNicknameModule.Content;

namespace MyNicknameModule
{
	public class MyNicknameModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<MyNicknameModuleController>(layer);
			SingletonManager.Add<MyNicknameManager>(layer);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<MyNicknameModuleContentMap>();
			GuiModuleHolder.Add<NicknameWindow>();
		}
	}
}

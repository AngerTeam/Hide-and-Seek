using Prompts;

namespace TutorialModule
{
	public class TutorialModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<PromptsManager>(layer);
		}
	}
}

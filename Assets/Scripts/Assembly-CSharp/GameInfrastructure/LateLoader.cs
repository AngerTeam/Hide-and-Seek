using CraftyEngine.Content;

namespace GameInfrastructure
{
	public class LateLoader : Singleton
	{
		public override void Init()
		{
			ContentLoaderModel contentLoaderModel = SingletonManager.Get<ContentLoaderModel>();
			contentLoaderModel.Load();
		}
	}
}

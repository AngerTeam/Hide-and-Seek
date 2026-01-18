using CraftyEngine.Content;
using MobsModule.Content;
using PlayerModule.Playmate;

namespace MobsModule
{
	public class MobBodyViewManager : Singleton
	{
		public override void Init()
		{
			PlayerBodyManager playerBodyManager = SingletonManager.Get<PlayerBodyManager>();
			playerBodyManager.RegisterType<MobBodyView>(4);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<MobsContentMap>();
		}
	}
}

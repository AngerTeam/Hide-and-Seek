using GameInfrastructure;

namespace HideAndSeekGame
{
	public class LobbyAsynStarter : Singleton
	{
		public override void Init()
		{
			HNSLobbyModuleController.Load(HideAndSeekGameMap.Islands[1].GetFullClientMapPath());
		}
	}
}

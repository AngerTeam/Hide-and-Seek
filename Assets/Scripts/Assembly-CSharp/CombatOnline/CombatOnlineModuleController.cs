using Combat;

namespace CombatOnline
{
	public class CombatOnlineModuleController
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<CombatInteraction>(layer);
			SingletonManager.AddAlias<SocketsPvpOnline, IPvpOnline>(layer);
			SingletonManager.Add<NetworkCombatManager>(layer);
		}
	}
}

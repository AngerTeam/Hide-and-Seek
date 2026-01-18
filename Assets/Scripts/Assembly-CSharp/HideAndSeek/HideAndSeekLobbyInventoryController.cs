using InventoryModule;

namespace HideAndSeek
{
	public class HideAndSeekLobbyInventoryController : Singleton
	{
		private GameInventoryWindowController inventoryModuleController_;

		public override void Init()
		{
			SingletonManager.Get<GameInventoryWindowController>(out inventoryModuleController_);
			inventoryModuleController_.SetLayout(0);
		}
	}
}

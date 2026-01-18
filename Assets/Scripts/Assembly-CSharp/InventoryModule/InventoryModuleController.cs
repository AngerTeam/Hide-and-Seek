using CraftyEngine.Utils;
using HudSystem;
using InventoryViewModule;
using WindowsModule;

namespace InventoryModule
{
	public class InventoryModuleController : Singleton
	{
		private InventoryModel inventoryModel_;

		public static ArtikulsEntries GetArticul(int artikulId, int? typeFilter = null)
		{
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out value) && (!typeFilter.HasValue || typeFilter.Value == value.type_id))
			{
				return value;
			}
			return InventoryContentMap.CraftSettings.handArtikul;
		}

		public static ArtikulsEntries GetInstrument(int artikulId)
		{
			return GetArticul(artikulId, 3);
		}

		public static ArtikulsEntries GetWeapon(int artikulId)
		{
			return GetArticul(artikulId, 4);
		}

		public static void InitModule()
		{
			int layer = 1;
			SingletonManager.Add<InventoryModuleContentDeserializer>(layer);
			SingletonManager.Add<WindowsManager>(layer);
			SingletonManager.Add<DebugButtonsManager>(layer);
			SingletonManager.Add<DialogWindowManager>(layer);
			SingletonManager.Add<MessageDisplay>(layer);
			SingletonManager.Add<InventoryModel>(layer);
			SingletonManager.Add<InvetnoryController>(layer);
			SingletonManager.Add<WearController>(layer);
			SingletonManager.Add<CraftManager>(layer);
			SingletonManager.Add<InventoryModuleController>(layer);
			SingletonManager.Add<InventoryInteractionController>(layer);
			SingletonManager.Add<SlotsUpdateManager>(layer);
			SingletonManager.AddAlias<SeparateSlotTypeBasedInventory, IInventoryLogic>(layer);
		}

		public override void OnDataLoaded()
		{
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			IInventoryLogic inventoryLogic = SingletonManager.Get<IInventoryLogic>();
			inventoryLogic.InitSlotGroups();
			SelectFirstSlot();
			GuiModuleHolder.Add<SelectedArtikulHud>();
			GuiModuleHolder.Add<RecipeLibraryWindow>();
		}

		private void SelectFirstSlot()
		{
			inventoryModel_.SelectSlot(inventoryModel_.Slots['p'][0]);
		}
	}
}

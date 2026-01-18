using System.Collections.Generic;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.Content;
using InventoryModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;

namespace HideAndSeek
{
	public class HideAndSeekController : Singleton
	{
		private SlotModel currentDefaultSlot_;

		private GameInventoryWindowController inventoryModuleController_;

		private IInventoryLogic invetnory_;

		private HideAndSeekModel model_;

		private ArtikulItem nonDefaultItemBackup_;

		private MyPlayerStatsModel player_;

		private WeaponTypesEntries weaponHideType_;

		private WeaponTypesEntries weaponUnhideType_;

		private GameModel gameModel_;

		public override void Dispose()
		{
			player_.stats.hideAndSeek.RoleChanged -= HandleRoleChanged;
			player_.stats.hideAndSeek = null;
		}

		public ArtikulsEntries GetArtikulByVoxel(int voxleId)
		{
			foreach (ArtikulsEntries value in InventoryContentMap.Artikuls.Values)
			{
				if (value.voxel_id == voxleId)
				{
					return value;
				}
			}
			return null;
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out player_);
			player_.stats.hideAndSeek = new PlayerHideAndSeekModel();
			PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
			prefabsManager.Load("HideAndSeek");
		}

		public override void OnDataLoaded()
		{
			SingletonManager.Get<HideAndSeekModel>(out model_);
			SingletonManager.Get<GameInventoryWindowController>(out inventoryModuleController_);
			SingletonManager.Get<GameModel>(out gameModel_);
			player_.stats.hideAndSeek.RoleChanged += HandleRoleChanged;
			model_.DefaultHideVoxelChanged += UpdateDefault;
			ContentDeserializer.Deserialize<HideAndSeekContentMap>();
			int id = CalculateFreeId();
			weaponHideType_ = new WeaponTypesEntries();
			weaponHideType_.icon = "Eye1_opened_trans";
			weaponHideType_.melee = 1;
			weaponUnhideType_ = new WeaponTypesEntries();
			weaponUnhideType_.icon = "Eye1_closed_trans";
			weaponUnhideType_.melee = 1;
			AddSlots();
			CreateFakeArtikuls(id);
			PlayerBodyManager playerBodyManager = SingletonManager.Get<PlayerBodyManager>();
			playerBodyManager.RegisterType<VoxelBodyView>(8);
			playerBodyManager.RegisterType<VoxelMosntrBodyView>(16);
			HandleRoleChanged();
		}

		private void HandleRoleChanged()
		{
			int currentGameHudState = 0;
			int layout = 0;
			switch (player_.stats.hideAndSeek.Role)
			{
			case HideAndSeekRole.Hidden:
				currentGameHudState = 25468930;
				layout = 2;
				break;
			case HideAndSeekRole.Hider:
				currentGameHudState = 25468931;
				layout = 2;
				break;
			case HideAndSeekRole.Monstr:
				currentGameHudState = 25468935;
				layout = 0;
				break;
			case HideAndSeekRole.Seeker:
				currentGameHudState = 25468935;
				layout = 1;
				break;
			case HideAndSeekRole.Idle:
				currentGameHudState = 25468935;
				layout = 0;
				break;
			case HideAndSeekRole.Dead:
				currentGameHudState = 1089536;
				layout = 0;
				break;
			}
			inventoryModuleController_.SetLayout(layout);
			gameModel_.CurrentGameHudState = currentGameHudState;
		}

		private static int CalculateFreeId()
		{
			int num = 0;
			foreach (ArtikulsEntries value in InventoryContentMap.Artikuls.Values)
			{
				if (value.id >= num)
				{
					num = value.id + 1;
				}
			}
			return num;
		}

		private void AddSlots()
		{
			SingletonManager.Get<IInventoryLogic>(out invetnory_);
			List<SlotModel> slots = invetnory_.Controller.AddSlotsGroup(')', HideAndSeekContentMap.HideVoxels.Count);
			model_.Slots = slots;
		}

		private void CreateFakeArtikuls(int id)
		{
			int num = 0;
			foreach (HideVoxelsEntries value in HideAndSeekContentMap.HideVoxels.Values)
			{
				ArtikulsEntries artikulsEntries = new ArtikulsEntries();
				artikulsEntries.id = id;
				InventoryContentMap.Artikuls[id] = artikulsEntries;
				value.artikul = artikulsEntries;
				VoxelContentMap.Voxels.TryGetValue(value.voxel_id, out value.voxel);
				FillArtikulData(value, artikulsEntries);
				SlotModel slotModel = model_.Slots[num];
				num++;
				slotModel.name = ')' + value.id.ToString();
				slotModel.GhostItem = new ArtikulItem(id);
				slotModel.GhostItem.infiniteLogic = true;
				slotModel.transparentAsGhost = false;
				slotModel.Splittable = false;
				slotModel.CanDrag = false;
				slotModel.CanDrop = false;
				slotModel.Movable = false;
				id++;
			}
		}

		private void FillArtikulData(HideVoxelsEntries voxelsEntries, ArtikulsEntries hideVoxelArtikul)
		{
			ArtikulsEntries artikulByVoxel = GetArtikulByVoxel(voxelsEntries.voxel_id);
			hideVoxelArtikul.icon = artikulByVoxel.icon;
			hideVoxelArtikul.large_icon = artikulByVoxel.large_icon;
			hideVoxelArtikul.title = artikulByVoxel.title;
			hideVoxelArtikul.voxel_id = artikulByVoxel.voxel_id;
			hideVoxelArtikul.type_id = 5498754;
			hideVoxelArtikul.hideVoxel = voxelsEntries;
			hideVoxelArtikul.iconId = artikulByVoxel.id;
			hideVoxelArtikul.stack_size = int.MaxValue;
			hideVoxelArtikul.weaponType = weaponHideType_;
		}

		private void RestoreDefault()
		{
			if (currentDefaultSlot_ != null)
			{
				currentDefaultSlot_.Insert(nonDefaultItemBackup_);
			}
		}

		private void UpdateDefault()
		{
			SlotModel slot;
			if (model_.DefaultHideVoxel == null)
			{
				RestoreDefault();
			}
			else if (model_.GetSlotById(model_.DefaultHideVoxel.id, out slot))
			{
				RestoreDefault();
				currentDefaultSlot_ = slot;
				nonDefaultItemBackup_ = slot.Item;
				ArtikulItem artikulItem = new ArtikulItem(slot.GhostItem);
				artikulItem.infiniteLogic = true;
				artikulItem.infiniteView = true;
				ArtikulItem newItem = artikulItem;
				slot.Insert(newItem);
			}
		}
	}
}

using System.Collections.Generic;
using InventoryModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectileInventoryController : Singleton
	{
		private MyPlayerStatsModel myPlayerStatsModel_;

		private InventoryModel inventoryModel_;

		private int lastRespawnGrenadesCount;

		public int MaxBattleProjectiles { get; private set; }

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			MaxBattleProjectiles = 8;
			myPlayerStatsModel_.stats.Respawned += HandleRespawned;
			inventoryModel_.SlotsUpdated += HandleSlotsUpdated;
		}

		public override void Dispose()
		{
			myPlayerStatsModel_.stats.Respawned -= HandleRespawned;
			inventoryModel_.SlotsUpdated -= HandleSlotsUpdated;
		}

		public ArtikulsEntries FindProjectileArtikul()
		{
			if (inventoryModel_.SelectedSlot.Entry != null && inventoryModel_.SelectedSlot.Entry.ProjectileEntry != null)
			{
				return inventoryModel_.SelectedSlot.Entry;
			}
			List<SlotModel> list = inventoryModel_.Slots['w'];
			for (int i = 0; i < list.Count; i++)
			{
				SlotModel slotModel = list[i];
				if (slotModel.Entry != null && slotModel.Entry.ProjectileEntry != null)
				{
					return slotModel.Entry;
				}
			}
			list = inventoryModel_.Slots['p'];
			for (int j = 0; j < list.Count; j++)
			{
				SlotModel slotModel2 = list[j];
				if (slotModel2.Entry != null && slotModel2.Entry.ProjectileEntry != null)
				{
					return slotModel2.Entry;
				}
			}
			return null;
		}

		public int CalcTotalProjectilesCount()
		{
			int num = 0;
			List<SlotModel> list = inventoryModel_.Slots['w'];
			for (int i = 0; i < list.Count; i++)
			{
				SlotModel slotModel = list[i];
				if (slotModel.Entry != null && slotModel.Entry.ProjectileEntry != null)
				{
					num += slotModel.Amount;
				}
			}
			list = inventoryModel_.Slots['p'];
			for (int j = 0; j < list.Count; j++)
			{
				SlotModel slotModel2 = list[j];
				if (slotModel2.Entry != null && slotModel2.Entry.ProjectileEntry != null)
				{
					num += slotModel2.Amount;
				}
			}
			return num;
		}

		private SlotModel FindProjectileSlot(int artikulId)
		{
			ArtikulsEntries articul = InventoryModuleController.GetArticul(artikulId);
			if (articul.ProjectileEntry == null)
			{
				return null;
			}
			if (inventoryModel_.SelectedSlot.ArtikulId == artikulId)
			{
				return inventoryModel_.SelectedSlot;
			}
			List<SlotModel> list = inventoryModel_.Slots['p'];
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].ArtikulId == artikulId)
				{
					return list[i];
				}
			}
			list = inventoryModel_.Slots['w'];
			for (int j = 0; j < list.Count; j++)
			{
				if (list[j].ArtikulId == artikulId)
				{
					return list[j];
				}
			}
			return null;
		}

		private void HandleRespawned()
		{
			int a = CalcTotalProjectilesCount();
			myPlayerStatsModel_.stats.GrenadeAmmo = Mathf.Min(a, MaxBattleProjectiles);
			lastRespawnGrenadesCount = myPlayerStatsModel_.stats.GrenadeAmmo;
		}

		private void HandleSlotsUpdated()
		{
			int a = CalcTotalProjectilesCount();
			int num = lastRespawnGrenadesCount - myPlayerStatsModel_.stats.GrenadeAmmo;
			myPlayerStatsModel_.stats.GrenadeAmmo = Mathf.Min(a, MaxBattleProjectiles - num);
			if (myPlayerStatsModel_.stats.GrenadeAmmo < 0)
			{
				myPlayerStatsModel_.stats.GrenadeAmmo = 0;
			}
		}
	}
}

using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyVoxelEngine;
using CraftyVoxelEngine.Content;
using DG.Tweening;
using LootModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace InventoryModule
{
	public class LootManager : Singleton
	{
		public float playerHeight;

		public bool respawnLootWhenFall;

		private GameObject gameObject_;

		private List<LootItem> lootList_;

		private float lootRespawnHeight_;

		private Vector3 lootRespawnPosition_ = new Vector3(0f, float.MinValue, 0f);

		private float lootScale_;

		private MyPlayerStatsModel myPlayerManager_;

		private IInventoryLogic inventoryLogic_;

		private CameraManager cameraManager_;

		public event EventHandler<LootEventArgs> LootStatusChanged;

		public override void Init()
		{
			playerHeight = 2f;
			gameObject_ = new GameObject("LootManager");
			lootList_ = new List<LootItem>();
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<IInventoryLogic>(out inventoryLogic_);
			UnityEvent singlton;
			SingletonManager.Get<UnityEvent>(out singlton);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
			singlton.Subscribe(UnityEventType.FixedUpdate, FixedUpdate);
			lootRespawnHeight_ = VoxelContentMap.VoxelSettings.DeathHeight;
			lootScale_ = InventoryContentMap.CraftSettings.lootItemSize;
		}

		public void DestroyLoot(LootItem loot)
		{
			loot.Destroy();
			lootList_.Remove(loot);
		}

		public void DropItemToLoot(DropItemToLootArgs e)
		{
			Transform transform = cameraManager_.Transform;
			Vector3 position = ((!e.IsDropFromPlayer) ? e.Position : (transform.position + transform.forward * 3f));
			SpawnLoot(count: e.Count, articulId: e.ArticulId, position: position, fromRef: e.FromRef, globalKey: null, isSpawnFromCraft: e.IsDropFromCraft);
		}

		public LootItem SpawnLoot(int articulId, Vector3 position, string fromRef = null, VoxelKey? globalKey = null, int count = 1, bool isSpawnFromCraft = false, bool isSpawnForUnet = false, int wear = 0, bool isTemp = false, int? id = null)
		{
			if (articulId == 0)
			{
				return null;
			}
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(articulId, out value) && !string.IsNullOrEmpty(value.client_version) && !VersionUtil.Compare(DataStorage.version, value.client_version))
			{
				Log.Info("Skipping Spawn Loot {0} by client version", articulId);
				return null;
			}
			ArtikulItem item = new ArtikulItem(articulId, count, wear, isTemp);
			LootItem lootItem = new LootItem(item, position, id);
			lootItem.sourceVoxelGlobalKey = globalKey;
			lootItem.spawnFromCraft = isSpawnFromCraft;
			lootItem.spawnForUnet = isSpawnForUnet;
			lootItem.idFrom = fromRef;
			lootItem.initial = false;
			lootItem.AddView(lootScale_);
			lootItem.GameObject.transform.SetParent(gameObject_.transform, true);
			lootList_.Add(lootItem);
			lootItem.PositionChanged += HandleLootPositionChanged;
			ReportSpawn(lootItem);
			return lootItem;
		}

		public void SylarLoot(LootItem loot)
		{
			if (!loot.flyToPlayer && !loot.spawned)
			{
				loot.flyToPlayer = true;
				loot.RigidBody.enabled = false;
				DOTween.To(() => loot.GameObject.transform.position, delegate(Vector3 x)
				{
					loot.GameObject.transform.position = x;
				}, myPlayerManager_.stats.Position, 0.35f).SetEase(Ease.Linear).OnComplete(delegate
				{
					TakeLoot(loot);
				});
			}
		}

		public void TakeLoot(LootItem loot)
		{
			loot.flyToPlayer = false;
			if (CanBePicked(loot))
			{
				if (this.LootStatusChanged != null)
				{
					LootEventArgs lootEventArgs = new LootEventArgs(LootEventType.TakeLoot);
					lootEventArgs.loot = loot;
					this.LootStatusChanged(this, lootEventArgs);
				}
				TakeLootSoundProvider.PlayTakeLootSound();
				DestroyLoot(loot);
			}
		}

		internal void SpawnInitialLootItems(List<LootItem> lootItems)
		{
			DestroyAllLoot();
			if (lootItems == null)
			{
				return;
			}
			foreach (LootItem lootItem in lootItems)
			{
				lootItem.initial = true;
				lootItem.PositionChanged += HandleLootPositionChanged;
				lootItem.AddView(lootScale_);
				lootItem.GameObject.transform.SetParent(gameObject_.transform, true);
				lootList_.Add(lootItem);
			}
		}

		private bool CanBePicked(LootItem loot)
		{
			SlotModel slot;
			return inventoryLogic_.GetFirstAvailableSlot(loot.item, out slot);
		}

		private bool CheckLootCloseToPlayer(LootItem item)
		{
			Vector3 position = myPlayerManager_.stats.Position;
			position.y += playerHeight;
			if (item.GameObject == null)
			{
				return false;
			}
			float num = CraftyEngine.Utils.Math.DistToSegment(item.GameObject.transform.position, myPlayerManager_.stats.Position, position);
			if (num < 1.5f)
			{
				return true;
			}
			return false;
		}

		private void DestroyAllLoot()
		{
			for (int i = 0; i < lootList_.Count; i++)
			{
				DestroyLoot(lootList_[i]);
			}
		}

		private void FixedUpdate()
		{
			for (int i = 0; i < lootList_.Count; i++)
			{
				LootItem lootItem = lootList_[i];
				if (!lootItem.flyToPlayer && CheckLootCloseToPlayer(lootItem) && CanBePicked(lootItem))
				{
					SylarLoot(lootItem);
				}
				if (respawnLootWhenFall && lootItem.GameObject.transform.position.y < lootRespawnHeight_)
				{
					lootItem.GameObject.transform.position = lootRespawnPosition_ + UnityEngine.Random.insideUnitSphere * 2f;
					lootItem.RigidBody.DropVelocity();
				}
			}
		}

		private void HandleLootPositionChanged(object sender, EventArgs e)
		{
			LootItem lootItem = (LootItem)sender;
			if (this.LootStatusChanged != null)
			{
				if (lootItem.initial)
				{
					lootItem.initial = false;
					return;
				}
				LootEventArgs lootEventArgs = new LootEventArgs(LootEventType.MoveLoot);
				lootEventArgs.loot = lootItem;
				lootEventArgs.itemPosition = lootItem.GameObject.transform.position;
				this.LootStatusChanged(this, lootEventArgs);
			}
		}

		private void ReportSpawn(LootItem loot)
		{
			if (this.LootStatusChanged != null)
			{
				LootEventArgs lootEventArgs = new LootEventArgs(LootEventType.SpawnLoot);
				lootEventArgs.loot = loot;
				lootEventArgs.itemPosition = loot.GameObject.transform.position;
				this.LootStatusChanged(this, lootEventArgs);
			}
		}
	}
}

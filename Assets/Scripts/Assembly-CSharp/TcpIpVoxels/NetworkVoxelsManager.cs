using System.Collections.Generic;
using CraftyVoxelEngine;
using CraftyVoxelEngine.Content;
using ExceptionsModule;
using Interlace.Amf;
using InventoryModule;
using LootModule;
using RemoteData;
using SyncOnlineModule;
using TcpIpVoxels.RemoteData;
using UnityEngine;

namespace TcpIpVoxels
{
	public class NetworkVoxelsManager : Singleton
	{
		private IVoxelsOnline voxelsOnline_;

		private VoxelEngine voxelEngine_;

		private VoxelInteraction voxelInteraction_;

		private LootManager lootManager_;

		private IInventoryLogic inventoryLogic_;

		private ExceptionsManager exceptionsManager_;

		public override void Dispose()
		{
			if (voxelInteraction_ != null)
			{
				lootManager_.LootStatusChanged -= HandleLootStatusChanged;
				voxelsOnline_.VoxelPacketRecieved -= HandleMapSyncPacket;
				voxelsOnline_.VoxelStatusChanged -= HandleVoxelStatusChanged;
				voxelsOnline_.SpawnLoot -= HandleSpawnLoot;
				voxelInteraction_.controller.VoxelBuilt -= HandleVoxelBuild;
				voxelInteraction_.controller.VoxelDestroyed -= HandleVoxelDestroyed;
				exceptionsManager_.RemoveHandler(HandleExceptions);
			}
		}

		public override void Init()
		{
			if (SingletonManager.TryGet<VoxelEngine>(out voxelEngine_))
			{
				SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
				SingletonManager.Get<IVoxelsOnline>(out voxelsOnline_);
				SingletonManager.Get<IInventoryLogic>(out inventoryLogic_);
				SingletonManager.Get<LootManager>(out lootManager_);
				SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
				lootManager_.LootStatusChanged += HandleLootStatusChanged;
				voxelsOnline_.VoxelPacketRecieved += HandleMapSyncPacket;
				voxelsOnline_.VoxelStatusChanged += HandleVoxelStatusChanged;
				voxelsOnline_.SpawnLoot += HandleSpawnLoot;
				voxelInteraction_.controller.VoxelBuilt += HandleVoxelBuild;
				voxelInteraction_.controller.VoxelDestroyed += HandleVoxelDestroyed;
				exceptionsManager_.AddHandler(HandleExceptions, 1100, 1101, 3203);
			}
		}

		private void HandleSpawnLoot(RemoteMessageEventArgs obj)
		{
			VoxelDestroyResponse voxelDestroyResponse = (VoxelDestroyResponse)obj.remoteMessage;
			for (int i = 0; i < voxelDestroyResponse.lootList.Length; i++)
			{
				LootMessage lootMessage = voxelDestroyResponse.lootList[i];
				bool isTemp = lootMessage.tmp == 1;
				lootManager_.SpawnLoot(id: lootMessage.lootId, articulId: (ushort)lootMessage.artikulId, position: lootMessage.ToVector3() + Vector3.one * 0.5f, fromRef: null, globalKey: null, count: lootMessage.count, isSpawnFromCraft: false, isSpawnForUnet: true, wear: 0, isTemp: isTemp);
			}
		}

		private bool HandleExceptions(ExceptionArgs args)
		{
			switch (args.Id)
			{
			case 1100:
			case 1101:
			{
				AmfObject amfObject = args.data as AmfObject;
				VoxelChangeMessage message;
				if (amfObject == null || !RemoteMessage.TryRead<VoxelChangeMessage>(amfObject, out message))
				{
					voxelsOnline_.SendSyncMap();
				}
				else
				{
					HandleVoxelChange(message);
				}
				return true;
			}
			case 3203:
				voxelsOnline_.SendSyncMap();
				return true;
			default:
				return false;
			}
		}

		private void HandleMapSyncPacket(RemoteMessageEventArgs args)
		{
			MapChunksMessage mapChunksMessage = (MapChunksMessage)args.remoteMessage;
			for (int i = 0; i < mapChunksMessage.chunks.Length; i++)
			{
				ChunkDiffMessage chunkDiffMessage = mapChunksMessage.chunks[i];
				if (ReadChunkByteString.valuesCache == null)
				{
					ReadChunkByteString.valuesCache = new Dictionary<int, VoxelValueRotation>();
				}
				ReadChunkByteString.valuesCache.Clear();
				ReadChunkByteString.ReadValues(chunkDiffMessage.voxelsDiff);
				ReadChunkByteString.ReadRotation(chunkDiffMessage.rotationsDiff);
				int chunkIndex3D = VoxelMath.KeyToIndexHex(chunkDiffMessage.x, chunkDiffMessage.y, chunkDiffMessage.z);
				foreach (VoxelValueRotation value in ReadChunkByteString.valuesCache.Values)
				{
					VoxelKey globalKey = VoxelMath.Index3DToGlobalKey(chunkIndex3D, value.index3D);
					voxelEngine_.voxelActions.SetVoxel(globalKey, value.value, value.rotation, false, default(Vector3), 0, false);
				}
			}
		}

		private void HandleVoxelBuild(VoxelEventArgs args)
		{
			voxelsOnline_.SendCreateVoxel(args.GlobalKey, inventoryLogic_.Model.SelectedSlot.name, args.Rotation);
		}

		private void HandleVoxelDestroyed(VoxelEventArgs args)
		{
			VoxelsEntries value;
			if (VoxelContentMap.Voxels.TryGetValue(args.PreviousValue, out value))
			{
				ushort articulId = (ushort)value.drop_artikul_id;
				voxelsOnline_.SendDestroyVoxel(args.GlobalKey, articulId);
			}
			else
			{
				string data = string.Format("Can't SendDestroyVoxel to server for voxel {0} {1}", args.GlobalKey, args.PreviousValue);
				Exc.Report(3203, null, data);
			}
		}

		private void HandleVoxelStatusChanged(RemoteMessageEventArgs obj)
		{
			VoxelChangeMessage message = (VoxelChangeMessage)obj.remoteMessage;
			HandleVoxelChange(message);
		}

		private void HandleVoxelChange(VoxelChangeMessage message)
		{
			VoxelKey globalKey = new VoxelKey(message.x, message.y, message.z);
			int chunkIndex3d;
			int localVoxelIndex3D;
			VoxelMath.GlobalKeyToIndex3D(globalKey, out chunkIndex3d, out localVoxelIndex3D);
			voxelEngine_.voxelActions.SetVoxel(globalKey, (ushort)message.voxelId, (byte)message.rotation, false, default(Vector3), 0, false);
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncVoxelsMessage message;
			if (SyncManager.TryRead<PlayerSyncVoxelsMessage>(out message) && message.loot != null && message.loot.Length > 0)
			{
				for (int i = 0; i < message.loot.Length; i++)
				{
					LootMessage lootMessage = message.loot[i];
					lootManager_.SpawnLoot(count: lootMessage.count, isTemp: lootMessage.tmp == 1, articulId: (ushort)lootMessage.artikulId, position: lootMessage.ToVector3(), fromRef: null, globalKey: null, isSpawnFromCraft: false, isSpawnForUnet: false, wear: 0, id: lootMessage.lootId);
				}
			}
			voxelsOnline_.SendSyncMap();
		}

		private void HandleLootStatusChanged(object sender, LootEventArgs e)
		{
			LootItem loot = e.loot;
			switch (e.type)
			{
			case LootEventType.SpawnLoot:
				if (loot.sourceVoxelGlobalKey.HasValue)
				{
					voxelsOnline_.SendDestroyVoxelAndDropLoot(loot.sourceVoxelGlobalKey.Value, loot.item.ArtikulId, loot.GameObject.transform.position, loot.Id);
				}
				break;
			case LootEventType.MoveLoot:
				voxelsOnline_.SendMoveLoot(loot.item.ArtikulId, loot.GameObject.transform.position, loot.Id);
				break;
			case LootEventType.TakeLoot:
			{
				SlotModel slot;
				if (inventoryLogic_.TryAddToPanelOrBackpack(loot.item, out slot))
				{
					TakeLootSoundProvider.PlayTakeLootSound();
					voxelsOnline_.SendTakeLootAndPutToSlot(loot.item.ArtikulId, loot.Id, slot.name, loot.item.Amount);
				}
				break;
			}
			}
		}
	}
}

using System;
using CraftyNetworkEngine.Sockets;
using CraftyVoxelEngine;
using Interlace.Amf;
using Interlace.Amf.Extended;
using RemoteData;
using TcpIpVoxels.RemoteData;
using UnityEngine;

namespace TcpIpVoxels
{
	public class SocketsVoxelsOnline : SocketsOnlineManagerApi, IVoxelsOnline, ISingleton
	{
		private int mapSyncPacketsRecievedCount_;

		private int mapSyncPacketsTotalCount_;

		private bool messUpVoxelsDebug_;

		public event Action<RemoteMessageEventArgs> SpawnLoot;

		public event Action<RemoteMessageEventArgs> VoxelPacketRecieved;

		public event Action<RemoteMessageEventArgs> VoxelStatusChanged;

		public override void Init()
		{
			messUpVoxelsDebug_ = false;
			base.Init();
			sockets.CommandRecieved += HandleCommand;
		}

		public void SendCreateLoot(int artikulId, int count, Vector3 lootPosition, int lootId)
		{
			Send(new LootDropCommand(null, artikulId, count, lootId, lootPosition.x, lootPosition.y, lootPosition.z));
		}

		public void SendCreateVoxel(VoxelKey globalKey, string slotName, byte rotation = 0)
		{
			if (messUpVoxelsDebug_)
			{
				globalKey.x++;
			}
			VoxelCreateCommand voxelCreateCommand = new VoxelCreateCommand(0, slotName, globalKey);
			if (rotation != 0)
			{
				voxelCreateCommand.rotation = rotation;
			}
			Send(voxelCreateCommand);
		}

		public void SendDestroyVoxel(VoxelKey globalKey, int articulId)
		{
			if (messUpVoxelsDebug_)
			{
				globalKey.x++;
			}
			VoxelDestroyCommand voxelDestroyCommand = new VoxelDestroyCommand(articulId, globalKey);
			voxelDestroyCommand.ResponceRecieved += HandleVoxelDestroy;
			Send(voxelDestroyCommand);
		}

		public void SendDestroyVoxelAndDropLoot(VoxelKey globalKey, int artikulId, Vector3 lootPosition, int lootId)
		{
			Send(new VoxelDestroyCommand(artikulId, globalKey));
		}

		public void SendDropLoot(string slotId, int artikulId, int count, Vector3 lootPosition, int lootId)
		{
			Send(new LootDropCommand(slotId, artikulId, count, lootId, lootPosition.x, lootPosition.y, lootPosition.z));
		}

		public void SendMoveLoot(int artikulId, Vector3 lootPosition, int lootId)
		{
			Send(new LootMoveCommand(artikulId, lootId, new IntVector3(lootPosition)));
		}

		public void SendSyncMap()
		{
			SyncMapCommand syncMapCommand = new SyncMapCommand();
			syncMapCommand.ResponceRecieved += HandleMapSync;
			Send(syncMapCommand);
		}

		public void SendTakeLootAndPutToSlot(int articulId, int lootId, string slotName, int count)
		{
			Send(new LootTakeCommand(articulId, lootId, slotName, count));
		}

		private void CompleteInitialisation()
		{
			mapSyncPacketsRecievedCount_ = 0;
			OptAmfVoxelDiffs.Clear();
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			switch (command)
			{
			case "voxel_change":
				ReportVoxelStateChanged(obj);
				break;
			case "map_chunks":
				HandleMapSyncPacket(obj);
				break;
			}
		}

		private void HandleMapSync(AmfObject obj)
		{
			MapSyncResponse mapSyncResponse = RemoteMessage.Read<MapSyncResponse>(obj);
			mapSyncPacketsTotalCount_ = mapSyncResponse.packets;
			if (mapSyncPacketsTotalCount_ == 0)
			{
				CompleteInitialisation();
			}
		}

		private void HandleMapSyncPacket(AmfObject obj)
		{
			MapChunksMessage remoteMessage = RemoteMessage.Read<MapChunksMessage>(obj);
			if (this.VoxelPacketRecieved != null)
			{
				this.VoxelPacketRecieved(new RemoteMessageEventArgs(remoteMessage));
			}
			mapSyncPacketsRecievedCount_++;
			if (mapSyncPacketsRecievedCount_ == mapSyncPacketsTotalCount_)
			{
				CompleteInitialisation();
			}
		}

		private void HandleVoxelDestroy(AmfObject obj)
		{
			VoxelDestroyResponse message;
			if (RemoteMessage.TryRead<VoxelDestroyResponse>(obj, out message) && this.SpawnLoot != null)
			{
				this.SpawnLoot(new RemoteMessageEventArgs(message));
			}
		}

		private void ReportVoxelStateChanged(AmfObject obj)
		{
			VoxelChangeMessage remoteMessage = RemoteMessage.Read<VoxelChangeMessage>(obj);
			if (this.VoxelStatusChanged != null)
			{
				this.VoxelStatusChanged(new RemoteMessageEventArgs(remoteMessage));
			}
		}
	}
}

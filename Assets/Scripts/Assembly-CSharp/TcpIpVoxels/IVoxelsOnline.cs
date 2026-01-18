using System;
using CraftyVoxelEngine;
using UnityEngine;

namespace TcpIpVoxels
{
	public interface IVoxelsOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> SpawnLoot;

		event Action<RemoteMessageEventArgs> VoxelStatusChanged;

		event Action<RemoteMessageEventArgs> VoxelPacketRecieved;

		void SendDestroyVoxelAndDropLoot(VoxelKey globalKey, int artikulId, Vector3 lootPosition, int lootId);

		void SendCreateLoot(int artikulId, int count, Vector3 lootPosition, int lootId);

		void SendMoveLoot(int artikulId, Vector3 lootPosition, int lootId);

		void SendDropLoot(string slotId, int artikulId, int count, Vector3 lootPosition, int lootId);

		void SendTakeLootAndPutToSlot(int articulId, int lootId, string slotName, int count);

		void SendCreateVoxel(VoxelKey globalKey, string slotName, byte rotation = 0);

		void SendDestroyVoxel(VoxelKey globalKey, int articulId);

		void SendSyncMap();
	}
}

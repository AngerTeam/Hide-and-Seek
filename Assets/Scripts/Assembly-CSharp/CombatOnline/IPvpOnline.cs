using System;
using System.Collections.Generic;
using CraftyVoxelEngine;
using UnityEngine;

namespace CombatOnline
{
	public interface IPvpOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> HitReceived;

		event Action<RemoteMessageEventArgs> HitResponseReceivedLowPriority;

		event Action<RemoteMessageEventArgs> HitResponseReceivedHighPriority;

		event Action<RemoteMessageEventArgs> DeathReceived;

		event Action<RemoteMessageEventArgs> DeathResponseReceived;

		event Action<RemoteMessageEventArgs> ProjectileShotReceived;

		event Action<RemoteMessageEventArgs> ProjectileShotResponseReceived;

		event Action<RemoteMessageEventArgs> ProjectileHitReceived;

		event Action<RemoteMessageEventArgs> ProjectileHitResponseReceived;

		void SendBattleStatsRequest();

		void SendHit(string persId, int typeId, Vector3 direction);

		void SendDeath();

		void SendProjectileShot(int? artikulId, Vector3 direction, Vector3[] trajectory);

		void SendProjectileHit(int clientProjectileId, Vector3 point, string[] targets, List<VoxelKey> voxels);
	}
}

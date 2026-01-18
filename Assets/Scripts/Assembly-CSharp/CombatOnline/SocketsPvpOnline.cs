using System;
using System.Collections.Generic;
using CraftyNetworkEngine.Sockets;
using CraftyVoxelEngine;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;
using UnityEngine;

namespace CombatOnline
{
	public class SocketsPvpOnline : SocketsOnlineManagerApi, IPvpOnline, ISingleton
	{
		public event Action<RemoteMessageEventArgs> DeathReceived;

		public event Action<RemoteMessageEventArgs> DeathResponseReceived;

		public event Action<RemoteMessageEventArgs> HitReceived;

		public event Action<RemoteMessageEventArgs> HitResponseReceivedHighPriority;

		public event Action<RemoteMessageEventArgs> HitResponseReceivedLowPriority;

		public event Action<RemoteMessageEventArgs> ProjectileShotReceived;

		public event Action<RemoteMessageEventArgs> ProjectileShotResponseReceived;

		public event Action<RemoteMessageEventArgs> ProjectileHitReceived;

		public event Action<RemoteMessageEventArgs> ProjectileHitResponseReceived;

		public override void Init()
		{
			base.Init();
			sockets.CommandRecieved += HandleCommand;
		}

		public void SendBattleStatsRequest()
		{
			throw new NotImplementedException();
		}

		public void SendDeath()
		{
			DeathCommand deathCommand = new DeathCommand();
			deathCommand.ResponceRecieved += HandleDeathResponce;
			Send(deathCommand);
		}

		public void SendHit(string persId, int typeId, Vector3 direction)
		{
			HitCommand hitCommand = new HitCommand(persId, typeId);
			hitCommand.direction = new VectorMessage(direction);
			hitCommand.ResponceRecieved += HandleHitResponce;
			Send(hitCommand);
		}

		public void SendProjectileShot(int? artikulId, Vector3 direction, Vector3[] trajectory)
		{
			VectorMessage[] trajectory2 = new List<Vector3>(trajectory).ConvertAll((Vector3 v) => new VectorMessage(v)).ToArray();
			ProjectileShotCommand projectileShotCommand = new ProjectileShotCommand(new VectorMessage(direction), trajectory2);
			projectileShotCommand.artikulId = artikulId;
			projectileShotCommand.ResponceRecieved += HandleProjectileShotResponce;
			Send(projectileShotCommand);
		}

		public void SendProjectileHit(int clientProjectileId, Vector3 point, string[] targets, List<VoxelKey> voxels)
		{
			VectorMessage[] voxels2 = voxels.ConvertAll((VoxelKey v) => new VectorMessage(v.ToVector())).ToArray();
			ProjectileHitCommand projectileHitCommand = new ProjectileHitCommand(clientProjectileId, new VectorMessage(point), targets, voxels2);
			projectileHitCommand.ResponceRecieved += HandleProjectileHitResponce;
			Send(projectileHitCommand);
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			switch (command)
			{
			case "hit":
				HandleHit(obj);
				break;
			case "death":
				HandleDeath(obj);
				break;
			case "player_projectile_shot":
				HandleProjectileShot(obj);
				break;
			case "player_projectile_hit":
				HandleProjectileHit(obj);
				break;
			}
		}

		private void HandleDeath(AmfObject obj)
		{
			DeathMessage remoteMessage = RemoteMessage.Read<DeathMessage>(obj);
			this.DeathReceived(new RemoteMessageEventArgs(remoteMessage));
		}

		private void HandleDeathResponce(AmfObject obj)
		{
			DeathResponse message;
			if (RemoteMessage.TryRead<DeathResponse>(obj, out message))
			{
				this.DeathResponseReceived(new RemoteMessageEventArgs(message));
			}
		}

		private void HandleHit(AmfObject obj)
		{
			HitMessage remoteMessage = RemoteMessage.Read<HitMessage>(obj);
			RemoteMessageEventArgs obj2 = new RemoteMessageEventArgs(remoteMessage);
			this.HitReceived(obj2);
		}

		private void HandleHitResponce(AmfObject obj)
		{
			HitResponseMessage message;
			if (RemoteMessage.TryRead<HitResponseMessage>(obj, out message))
			{
				RemoteMessageEventArgs obj2 = new RemoteMessageEventArgs(message);
				this.HitResponseReceivedHighPriority(obj2);
				this.HitResponseReceivedLowPriority(obj2);
			}
		}

		private void HandleProjectileShot(AmfObject obj)
		{
			PlayerProjectileShotMessage remoteMessage = RemoteMessage.Read<PlayerProjectileShotMessage>(obj);
			RemoteMessageEventArgs obj2 = new RemoteMessageEventArgs(remoteMessage);
			this.ProjectileShotReceived(obj2);
		}

		private void HandleProjectileShotResponce(AmfObject obj)
		{
			ProjectileShotResponse message;
			if (RemoteMessage.TryRead<ProjectileShotResponse>(obj, out message))
			{
				this.ProjectileShotResponseReceived(new RemoteMessageEventArgs(message));
			}
		}

		private void HandleProjectileHit(AmfObject obj)
		{
			PlayerProjectileHitMessage remoteMessage = RemoteMessage.Read<PlayerProjectileHitMessage>(obj);
			RemoteMessageEventArgs obj2 = new RemoteMessageEventArgs(remoteMessage);
			this.ProjectileHitReceived(obj2);
		}

		private void HandleProjectileHitResponce(AmfObject obj)
		{
			ProjectileHitResponse message;
			if (RemoteMessage.TryRead<ProjectileHitResponse>(obj, out message))
			{
				this.ProjectileHitResponseReceived(new RemoteMessageEventArgs(message));
			}
		}
	}
}

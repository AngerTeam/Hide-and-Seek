using System;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelInteractionController : IDisposable
	{
		private VoxelInteractionModel model_;

		private LogicVoxelManager logicManager_;

		private VoxelActions voxelActions_;

		private VoxelControllerManager voxelControllerManager_;

		private VoxelEngine engine_;

		public bool enableEvents;

		public event Action<VoxelEventArgs> VoxelDestroyed;

		public event Action<VoxelEventArgs> VoxelBuilt;

		public event Action<VoxelEventArgs> VoxelHit;

		public VoxelInteractionController(VoxelInteractionModel model)
		{
			enableEvents = true;
			SingletonManager.Get<VoxelEngine>(out engine_);
			SingletonManager.Get<LogicVoxelManager>(out logicManager_);
			SingletonManager.Get<VoxelControllerManager>(out voxelControllerManager_);
			voxelActions_ = engine_.voxelActions;
			voxelControllerManager_.VoxelDestroyed += HandleVoxelDestroyed;
			model_ = model;
		}

		public void SetVoxel(VoxelKey key, ushort voxelId, out byte rotation)
		{
			VoxelData data;
			engine_.GetVoxelData(voxelId, out data);
			rotation = VoxelMath.RotationLogic(data, model_.rayHit, model_.direction, logicManager_.IsLogicVoxel(voxelId));
			int sequence = voxelActions_.SetVoxel(key, voxelId, rotation);
			if (enableEvents && this.VoxelBuilt != null)
			{
				VoxelEventArgs obj = new VoxelEventArgs(sequence, key, model_.buildVoxelId, 0, rotation);
				this.VoxelBuilt(obj);
			}
		}

		public void SetVoxel(ushort voxelId, out byte rotation)
		{
			SetVoxel(model_.rayHit.Free, voxelId, out rotation);
		}

		private void HandleVoxelDestroyed(VoxelEventArgs obj)
		{
			PopVoxel(obj.GlobalKey);
		}

		public void PopVoxel()
		{
			PopVoxel(model_.globalKey);
		}

		public void PopVoxel(VoxelKey globalKey)
		{
			int sequence = voxelActions_.SetVoxel(globalKey, 0);
			if (enableEvents && this.VoxelDestroyed != null)
			{
				VoxelEventArgs obj = new VoxelEventArgs(sequence, globalKey, 0, model_.value);
				this.VoxelDestroyed(obj);
			}
		}

		public void HitVoxel()
		{
			if (!model_.rayHitSuccess)
			{
				return;
			}
			if (Input.GetKey(KeyCode.Y))
			{
				VoxelKey globalKey = model_.globalKey;
				for (int i = 0; i < 20; i++)
				{
					voxelControllerManager_.HitVoxel(globalKey, 1000, 10f, true);
					if (enableEvents && this.VoxelHit != null)
					{
						VoxelEventArgs obj = new VoxelEventArgs(0, globalKey, 0, model_.value);
						this.VoxelHit(obj);
					}
					globalKey.x++;
				}
			}
			else
			{
				voxelControllerManager_.HitVoxel(model_.globalKey, model_.selectedItemDamageWrongType, model_.selectedItemDigRate, true);
				if (enableEvents && this.VoxelHit != null)
				{
					VoxelEventArgs obj2 = new VoxelEventArgs(0, model_.globalKey, 0, model_.value);
					this.VoxelHit(obj2);
				}
			}
		}

		public void Dispose()
		{
			voxelControllerManager_.VoxelDestroyed -= HandleVoxelDestroyed;
		}
	}
}

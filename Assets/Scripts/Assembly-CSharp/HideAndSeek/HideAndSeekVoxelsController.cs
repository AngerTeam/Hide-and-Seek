using System.Collections.Generic;
using CraftyVoxelEngine;
using InventoryModule;
using UnityEngine;

namespace HideAndSeek
{
	public class HideAndSeekVoxelsController : Singleton
	{
		private VoxelEngine voxelEngine_;

		private Dictionary<VoxelKey, Voxel> originalVoxels_;

		private GameModel gameModel_;

		private IInventoryLogic inventory_;

		public override void Init()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<IInventoryLogic>(out inventory_);
			gameModel_.StageChanged += HandleStageChanged;
			originalVoxels_ = new Dictionary<VoxelKey, Voxel>();
			voxelEngine_.voxelEvents.VoxelChanged += HandleVoxelChanged;
		}

		public void SetPlayerVoxel(VoxelKey key, byte rotation, int voxelId)
		{
			Voxel voxel;
			if (gameModel_.CurrentStage != null && gameModel_.CurrentStage.id != 0 && (!voxelEngine_.core.GetVoxel(key, out voxel) || voxel.Value != (ushort)voxelId || voxel.Rotation != rotation))
			{
				voxelEngine_.voxelActions.SetVoxel(key, (ushort)voxelId, rotation, false, default(Vector3), 0, false);
			}
		}

		private void HandleStageChanged()
		{
			if (gameModel_.CurrentStage.id == 0)
			{
				Reset();
			}
		}

		public override void Dispose()
		{
			voxelEngine_.voxelEvents.VoxelChanged += HandleVoxelChanged;
			gameModel_.StageChanged -= HandleStageChanged;
			originalVoxels_.Clear();
		}

		private void Reset()
		{
			inventory_.Model.ClearTempSlots();
			KeyedVoxel[] array = new KeyedVoxel[originalVoxels_.Count];
			int num = 0;
			foreach (KeyValuePair<VoxelKey, Voxel> item in originalVoxels_)
			{
				array[num] = new KeyedVoxel(item.Key, item.Value);
				num++;
			}
			voxelEngine_.core.SetMultypleVoxels(array);
			originalVoxels_.Clear();
		}

		private void HandleVoxelChanged(MessageVoxelChanged obj)
		{
			if (!originalVoxels_.ContainsKey(obj.globalKey))
			{
				originalVoxels_[obj.globalKey] = new Voxel
				{
					Value = obj.oldValue
				};
			}
		}
	}
}

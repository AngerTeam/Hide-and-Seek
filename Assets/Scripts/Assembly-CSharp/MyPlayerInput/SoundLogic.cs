using System;
using CraftyVoxelEngine;
using Extensions;
using UnityEngine;

namespace MyPlayerInput
{
	public class SoundLogic
	{
		private VoxelEngine voxelEngine_;

		private float stepDistance_;

		private float landingMinimalHeight_;

		private float walkedDistanceAfterStep_;

		public event Action<int> Step;

		public event Action<float> FellOnGround;

		public SoundLogic(float landingMinimalHeight, float stepDistance)
		{
			landingMinimalHeight_ = landingMinimalHeight;
			stepDistance_ = stepDistance;
		}

		internal bool CheckLanding(float height)
		{
			walkedDistanceAfterStep_ += stepDistance_;
			if (height > landingMinimalHeight_)
			{
				float param = height / 5f;
				this.FellOnGround.SafeInvoke(param);
				return true;
			}
			return false;
		}

		internal bool CheckStep(float deltaDistance, Vector3 playerPosition)
		{
			if (voxelEngine_ != null || SingletonManager.TryGet<VoxelEngine>(out voxelEngine_))
			{
				walkedDistanceAfterStep_ += deltaDistance;
				if (walkedDistanceAfterStep_ > stepDistance_)
				{
					walkedDistanceAfterStep_ = 0f;
					VoxelKey voxelKey = new VoxelKey(playerPosition);
					Voxel voxel;
					if ((voxelEngine_.core.GetVoxel(voxelKey, out voxel) && voxel.Value != 0) || (voxelEngine_.core.GetVoxel(voxelKey - VoxelKey.KeyPY, out voxel) && voxel.Value != 0))
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(voxel.Value, out data))
						{
							this.Step.SafeInvoke(data.SoundGroupStp);
							return true;
						}
						return false;
					}
				}
			}
			return false;
		}
	}
}

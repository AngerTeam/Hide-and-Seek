using System.Collections.Generic;

namespace CraftyVoxelEngine
{
	public class VoxelInteractionLogic
	{
		public bool allowBuildUnderMyPlayer;

		public BuildValidation AdditionalBuildValidation;

		private VoxelInteractionModel model_;

		private VoxelEngine voxelEngine_;

		private List<IDynamicObstacle> dynamicObstacles_;

		public VoxelInteractionLogic(VoxelInteractionModel model)
		{
			model_ = model;
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			dynamicObstacles_ = new List<IDynamicObstacle>();
		}

		public void AddDynamic(IDynamicObstacle player)
		{
			dynamicObstacles_.Add(player);
		}

		public void RemoveDynamic(IDynamicObstacle player)
		{
			dynamicObstacles_.Remove(player);
		}

		private bool CheckObstaclesCollision(VoxelKey globalKey)
		{
			for (int i = 0; i < dynamicObstacles_.Count; i++)
			{
				IDynamicObstacle dynamicObstacle = dynamicObstacles_[i];
				if ((!allowBuildUnderMyPlayer || !dynamicObstacle.IsMyPlayer) && dynamicObstacle.HasPosition)
				{
					VoxelKey voxelKey = new VoxelKey(dynamicObstacle.Position);
					VoxelKey other = voxelKey + VoxelKey.KeyPY;
					if (globalKey.Equals(voxelKey) || globalKey.Equals(other))
					{
						return true;
					}
				}
			}
			return false;
		}

		public bool AllowTechnicalBuild(VoxelKey globalKey, bool silent = false)
		{
			if (!model_.rayHitSuccess)
			{
				return false;
			}
			if (CheckObstaclesCollision(model_.rayHit.Free))
			{
				return false;
			}
			if (globalKey.y >= model_.maxHeight)
			{
				ExcReport(silent, 3352);
				return false;
			}
			if (globalKey.x < 0 || globalKey.x >= model_.maxWidth || globalKey.z < 0 || globalKey.z >= model_.maxWidth)
			{
				ExcReport(silent, 3354);
				return false;
			}
			return true;
		}

		public bool AllowBuild(bool silent = false)
		{
			return AllowLogicalBuild(model_.rayHit.Free, true, silent);
		}

		public bool AllowLogicalBuild(VoxelKey globalKey, bool checkRegions = true, bool silent = false)
		{
			if (!AllowTechnicalBuild(globalKey, silent))
			{
				return false;
			}
			if (model_.buildVoxelId == 0)
			{
				return false;
			}
			if (AdditionalBuildValidation != null && !AdditionalBuildValidation(silent))
			{
				return false;
			}
			if (model_.isCreativeMode)
			{
				return true;
			}
			if (!model_.allowBuild)
			{
				ExcReport(silent, 3353);
				return false;
			}
			if (checkRegions)
			{
				VoxelRegion region = voxelEngine_.Manager.GetRegion(globalKey);
				if (region.type == 1)
				{
					if (region.allowBuild)
					{
						return true;
					}
					ExcReport(silent, 3355);
					return false;
				}
			}
			return true;
		}

		private void ExcReport(bool silent, int excId)
		{
			if (!silent && !model_.silentLogic)
			{
				Exc.Report(excId);
			}
		}

		public bool CanDig(bool silent)
		{
			if (model_.supressDig)
			{
				return false;
			}
			if (model_.isCreativeMode)
			{
				return true;
			}
			if (model_.rayHitSuccess && model_.rayHit.success)
			{
				if (!model_.allowDig)
				{
					ExcReport(silent, 3357);
					return false;
				}
				VoxelRegion region = voxelEngine_.Manager.GetRegion(model_.rayHit.Full);
				if (region.type != 1)
				{
					return true;
				}
				if (region.allowDig)
				{
					return true;
				}
				ExcReport(silent, 3358);
				return false;
			}
			return false;
		}

		public bool IsInteractive()
		{
			return model_.rayHitSuccess && model_.data.BuildingID != 0 && model_.data.Interactive;
		}
	}
}

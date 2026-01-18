using System;
using CraftyVoxelEngine;
using UnityEngine;

namespace PlayerModule
{
	[Serializable]
	public class ProjectileModel
	{
		public Vector3 target;

		public VoxelKey? targetKey;

		public Transform parent;

		public ProjectileTargetType targetType = ProjectileTargetType.Item;

		public ushort voxelValue;

		public string targetPersId;
	}
}

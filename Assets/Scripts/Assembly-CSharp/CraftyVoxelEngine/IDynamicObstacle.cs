using UnityEngine;

namespace CraftyVoxelEngine
{
	public interface IDynamicObstacle
	{
		bool IsMyPlayer { get; set; }

		bool HasPosition { get; }

		Vector3 Position { get; }
	}
}

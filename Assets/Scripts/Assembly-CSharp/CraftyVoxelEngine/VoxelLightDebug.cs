using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelLightDebug
	{
		public static VoxelEngine engine;

		public static void DisplayAt(VoxelKey key)
		{
		}

		public static void TestAt(VoxelKey key)
		{
			if (engine == null)
			{
				SingletonManager.Get<VoxelEngine>(out engine);
			}
			Voxel voxel;
			if (engine.core != null && engine.core.GetVoxel(key, out voxel))
			{
				Color color = voxel.Light;
				Color color2 = Color.white * color.a;
				color.a = (color2.a = 1f);
				DrawCube(key, color, 0.8f, 10f);
				DrawCube(key, color2, 0.6f, 10f);
			}
		}

		public static void DrawCube(VoxelKey key, Color color, float size, float duration)
		{
			Vector3 vector = key.ToVector() + Vector3.one * 0.5f;
			Vector3 vector2 = Vector3.one * -0.5f;
			Vector3 vector3 = vector2 + Vector3.right;
			Vector3 vector4 = vector3 + Vector3.forward;
			Vector3 vector5 = vector2 + Vector3.forward;
			Vector3 vector6 = vector2 + Vector3.up;
			Vector3 vector7 = vector3 + Vector3.up;
			Vector3 vector8 = vector4 + Vector3.up;
			Vector3 vector9 = vector5 + Vector3.up;
			vector2 = vector2 * size + vector;
			vector3 = vector3 * size + vector;
			vector4 = vector4 * size + vector;
			vector5 = vector5 * size + vector;
			vector6 = vector6 * size + vector;
			vector7 = vector7 * size + vector;
			vector8 = vector8 * size + vector;
			vector9 = vector9 * size + vector;
			Debug.DrawLine(vector2, vector3, color, duration);
			Debug.DrawLine(vector3, vector4, color, duration);
			Debug.DrawLine(vector4, vector5, color, duration);
			Debug.DrawLine(vector5, vector2, color, duration);
			Debug.DrawLine(vector6, vector7, color, duration);
			Debug.DrawLine(vector7, vector8, color, duration);
			Debug.DrawLine(vector8, vector9, color, duration);
			Debug.DrawLine(vector9, vector6, color, duration);
			Debug.DrawLine(vector2, vector6, color, duration);
			Debug.DrawLine(vector3, vector7, color, duration);
			Debug.DrawLine(vector4, vector8, color, duration);
			Debug.DrawLine(vector5, vector9, color, duration);
		}
	}
}

using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.MeshParser
{
	public class Face
	{
		public List<FaceIndex> indexes { get; private set; }

		public Face()
		{
			indexes = new List<FaceIndex>();
		}

		public bool TestX(List<Vector3> ver, float value)
		{
			bool result = true;
			float num = value - 0.001f;
			float num2 = value + 0.001f;
			foreach (FaceIndex index in indexes)
			{
				float x = ver[index.ver].x;
				if (x < num || x > num2)
				{
					result = false;
				}
			}
			return result;
		}

		public bool TestY(List<Vector3> ver, float value)
		{
			bool result = true;
			float num = value - 0.001f;
			float num2 = value + 0.001f;
			foreach (FaceIndex index in indexes)
			{
				float y = ver[index.ver].y;
				if (y < num || y > num2)
				{
					result = false;
				}
			}
			return result;
		}

		public bool TestZ(List<Vector3> ver, float value)
		{
			bool result = true;
			float num = value - 0.001f;
			float num2 = value + 0.001f;
			foreach (FaceIndex index in indexes)
			{
				float z = ver[index.ver].z;
				if (z < num || z > num2)
				{
					result = false;
				}
			}
			return result;
		}
	}
}

using UnityEngine;

namespace CraftyEngine.Utils
{
	public class Math
	{
		private static float DistToSegmentSquared(Vector3 point, Vector3 a, Vector3 b)
		{
			float num = Vector3.Distance(a, b);
			if (num == 0f)
			{
				return Vector3.Distance(point, a);
			}
			float num2 = ((point.x - a.x) * (b.x - a.x) + (point.y - a.y) * (b.y - a.y)) / num;
			if (num2 < 0f)
			{
				return Vector3.Distance(point, a);
			}
			if (num2 > 1f)
			{
				return Vector3.Distance(point, b);
			}
			return Vector3.Distance(point, new Vector3(a.x + num2 * (b.x - a.x), a.y + num2 * (b.y - a.y), a.z + num2 * (b.z - a.z)));
		}

		public static float DistToSegment(Vector3 point, Vector3 a, Vector3 b)
		{
			return Mathf.Sqrt(DistToSegmentSquared(point, a, b));
		}
	}
}

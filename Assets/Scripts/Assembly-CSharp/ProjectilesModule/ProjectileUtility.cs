using System;
using UnityEngine;

namespace ProjectilesModule
{
	public class ProjectileUtility
	{
		public static void CalcProjectileParam(Vector3 start, Vector3 end, float overHeight, out float startSpeed, out float angle, out float duration)
		{
			float magnitude = (new Vector3(end.x, 0f, end.z) - new Vector3(start.x, 0f, start.z)).magnitude;
			float num = 9.8f;
			float num2 = end.y - start.y;
			float num3 = ((!(num2 > 0f)) ? overHeight : (overHeight + num2));
			float num4 = Mathf.Sqrt(2f * num * num3);
			float num5 = num * 0.5f;
			float num6 = num4;
			float num7 = num2;
			float num8 = num6 * num6 - 4f * num5 * num7;
			if (num8 < 0f)
			{
				num8 = 0f;
			}
			float f = (0f - num6 - Mathf.Sqrt(num8)) / (2f * num5);
			float f2 = (0f - num6 + Mathf.Sqrt(num8)) / (2f * num5);
			duration = Mathf.Max(Mathf.Abs(f), Mathf.Abs(f2));
			float num9 = magnitude / duration;
			startSpeed = Mathf.Sqrt(num9 * num9 + num4 * num4);
			angle = Mathf.Atan2(num4, num9) * 57.29578f;
		}

		public static float CalcProjectileAngle(Vector3 start, Vector3 end, float startSpeed)
		{
			Vector3 vector = end - start;
			float magnitude = vector.magnitude;
			float num = 9.8f;
			float num2 = startSpeed * startSpeed / (2f * num);
			float num3 = startSpeed * startSpeed / num + ((!(end.y < start.y)) ? 0f : (start.y - end.y));
			float num4 = Mathf.Sqrt(num2 * num2 + num3 * num3);
			if (magnitude > num4)
			{
				end = start + vector.normalized * num4;
			}
			float num5 = start.y - end.y;
			float magnitude2 = (new Vector3(end.x, 0f, end.z) - new Vector3(start.x, 0f, start.z)).magnitude;
			float num6 = num * magnitude2 * magnitude2 / (2f * startSpeed * startSpeed);
			float num7 = 0f - magnitude2;
			float num8 = num6 - num5;
			float num9 = num7 * num7 - 4f * num6 * num8;
			if (num9 < 0f)
			{
				num9 = 0f;
			}
			float a = (0f - num7 - Mathf.Sqrt(num9)) / (2f * num6);
			float b = (0f - num7 + Mathf.Sqrt(num9)) / (2f * num6);
			float f = Mathf.Min(a, b);
			return Mathf.Atan(f) * 180f / (float)Math.PI;
		}
	}
}

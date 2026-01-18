using System;
using System.Globalization;
using UnityEngine;

public static class Vector3Utils
{
	private const char PARSE_SPLIT_CHAR = ';';

	public static Vector3 ResetX(this Vector3 vec)
	{
		Vector3 result = vec;
		result.x = 0f;
		return result;
	}

	public static Vector3 ResetY(this Vector3 vec)
	{
		Vector3 result = vec;
		result.y = 0f;
		return result;
	}

	public static Vector3 ResetZ(this Vector3 vec)
	{
		Vector3 result = vec;
		result.z = 0f;
		return result;
	}

	public static Vector3 MoveX(this Vector3 vector, float x)
	{
		return new Vector3(vector.x + x, vector.y, vector.z);
	}

	public static Vector3 MoveY(this Vector3 vector, float y)
	{
		return new Vector3(vector.x, vector.y + y, vector.z);
	}

	public static Vector3 MoveZ(this Vector3 vector, float z)
	{
		return new Vector3(vector.x, vector.y, vector.z + z);
	}

	public static string ToString(Vector4 source)
	{
		return string.Format("{0}{4}{1}{4}{2}{4}{3}", source.x, source.y, source.z, source.w, ';');
	}

	public static string ToString(Vector3 source)
	{
		return string.Format("{0}{3}{1}{3}{2}", source.x, source.y, source.z, ';');
	}

	public static Vector4 SafeParse4(string source, char splitChar = ';')
	{
		try
		{
			string[] array = source.Split(splitChar);
			float x = FloatParce(array[0]);
			float y = FloatParce(array[1]);
			float z = FloatParce(array[2]);
			float w = FloatParce(array[3]);
			return new Vector4(x, y, z, w);
		}
		catch
		{
			return Vector4.zero;
		}
	}

	public static Vector3 SafeParse(string source, char splitChar = ';')
	{
		try
		{
			string[] array = source.Split(splitChar);
			float x = FloatParce(array[0]);
			float y = FloatParce(array[1]);
			float z = FloatParce(array[2]);
			return new Vector3(x, y, z);
		}
		catch
		{
			return Vector3.zero;
		}
	}

	private static float FloatParce(string source)
	{
		if (source.EndsWith("f"))
		{
			source = source.Remove(source.Length - 1, 1);
		}
		if (source.StartsWith(".") || source.StartsWith(","))
		{
			source = "0" + source;
		}
		return float.Parse(source, CultureInfo.InvariantCulture);
	}

	public static Vector3 RoundTo(Vector3 source, int to = 0)
	{
		return new Vector3((float)Math.Round(source.x, to), (float)Math.Round(source.y, to), (float)Math.Round(source.z, to));
	}

	public static bool CheckIfWithinDistance(Vector3 position, Vector3 target, float distance)
	{
		return (target - position).sqrMagnitude <= distance * distance;
	}

	public static Vector2 RestrictPos(Vector2 startPos, Vector2 newPos, float maxDistance)
	{
		float num = Vector2.Distance(startPos, newPos);
		if (num > maxDistance)
		{
			num = maxDistance;
		}
		return startPos + (newPos - startPos).normalized * num;
	}

	public static Vector3 CenterVoxel(Vector3 pos)
	{
		return new Vector3(pos.x + 0.5f, pos.y + 0.5f, pos.z + 0.5f);
	}

	public static Vector3 CenterVoxelHorizontally(Vector3 pos)
	{
		return new Vector3(pos.x + 0.5f, pos.y, pos.z + 0.5f);
	}
}

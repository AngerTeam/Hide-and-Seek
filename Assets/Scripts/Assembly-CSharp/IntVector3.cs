using UnityEngine;

public class IntVector3 : IIntVector3
{
	public Vector3 vector;

	public int X
	{
		get
		{
			return (int)vector.x;
		}
		set
		{
			vector.x = value;
		}
	}

	public int Y
	{
		get
		{
			return (int)vector.y;
		}
		set
		{
			vector.y = value;
		}
	}

	public int Z
	{
		get
		{
			return (int)vector.z;
		}
		set
		{
			vector.z = value;
		}
	}

	public IntVector3(Vector3 vector)
	{
		this.vector = vector;
	}
}

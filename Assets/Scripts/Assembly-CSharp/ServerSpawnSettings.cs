using System;
using System.Runtime.InteropServices;
using UnityEngine;

[Serializable]
public class ServerSpawnSettings
{
	public int side;

	public float p_x;

	public float p_y;

	public float p_z;

	public float r_x;

	public float r_y;

	public float r_z;

	public ServerSpawnSettings(int Side = 0, Vector3 pos = default(Vector3), Vector3 rot = default(Vector3))
	{
		side = Side;
		p_x = pos.x;
		p_y = pos.y;
		p_z = pos.z;
		r_x = rot.x;
		r_y = rot.y;
		r_z = rot.z;
	}
}

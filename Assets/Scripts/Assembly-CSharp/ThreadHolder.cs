using System;
using UnityEngine;

public class ThreadHolder
{
	public string debugName = "idle";

	public ThreadProfiler profiler;

	public bool reserved;

	public long started = DateTime.Now.Ticks;

	public override string ToString()
	{
		return string.Format("ThreadHolder {0} reserved:{1}", debugName, reserved);
	}

	internal void AddProfiler()
	{
		GameObject gameObject = new GameObject();
		profiler = gameObject.AddComponent<ThreadProfiler>();
	}
}

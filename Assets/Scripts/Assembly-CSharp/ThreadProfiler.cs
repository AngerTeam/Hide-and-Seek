using System;
using UnityEngine;

public class ThreadProfiler : MonoBehaviour
{
	public Action action;

	public string debugName;

	private void Update()
	{
		if (this.action != null)
		{
			base.name = debugName;
			Action action = this.action;
			this.action = null;
			action();
		}
	}
}

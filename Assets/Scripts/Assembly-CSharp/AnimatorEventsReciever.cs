using System;
using CraftyBundles;
using Extensions;
using UnityEngine;

public class AnimatorEventsReciever : MonoBehaviour
{
	public string[] id;

	public AnimatorData[] data;

	public event Action Step;

	public event Action PowerUpStarted;

	public void PowerUpStart()
	{
		if (this.PowerUpStarted != null)
		{
			this.PowerUpStarted();
		}
	}

	public void TestEvent()
	{
	}

	public void NewEvent()
	{
	}

	public void contact()
	{
	}

	public void step()
	{
		this.Step.SafeInvoke();
	}
}

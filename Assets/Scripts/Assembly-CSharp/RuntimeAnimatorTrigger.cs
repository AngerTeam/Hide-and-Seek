using UnityEngine;

[RequireComponent(typeof(Animator))]
public class RuntimeAnimatorTrigger : MonoBehaviour
{
	private Animator animator;

	public RuntimeAnimatorTriggerEntry[] triggers;

	private void Start()
	{
		animator = GetComponent<Animator>();
	}

	private void Update()
	{
		for (int i = 0; i < triggers.Length; i++)
		{
			RuntimeAnimatorTriggerEntry runtimeAnimatorTriggerEntry = triggers[i];
			if (runtimeAnimatorTriggerEntry.set)
			{
				animator.SetTrigger(runtimeAnimatorTriggerEntry.name);
			}
			if (runtimeAnimatorTriggerEntry.setOnce)
			{
				runtimeAnimatorTriggerEntry.setOnce = false;
				animator.SetTrigger(runtimeAnimatorTriggerEntry.name);
			}
		}
	}
}

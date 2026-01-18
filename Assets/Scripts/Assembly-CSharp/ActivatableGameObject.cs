using UnityEngine;

public class ActivatableGameObject<T> : ActivatableGameObject where T : Component
{
	public T value;

	public ActivatableGameObject(T value)
		: base((!((Object)value == (Object)null)) ? value.gameObject : null)
	{
		this.value = value;
	}
}
public class ActivatableGameObject
{
	private bool active_;

	public bool Active
	{
		get
		{
			return active_;
		}
		set
		{
			if (active_ != value)
			{
				active_ = value;
				if (GameObject != null)
				{
					GameObject.SetActive(active_);
				}
			}
		}
	}

	public GameObject GameObject { get; private set; }

	public ActivatableGameObject(GameObject gameObject)
	{
		GameObject = gameObject;
		if (gameObject != null)
		{
			active_ = gameObject.activeSelf;
		}
	}

	public void SetActive(bool value)
	{
		Active = value;
	}
}

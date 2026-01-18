using UnityEngine;

public class TutorialGameObject
{
	public int ID;

	public int x;

	public int y;

	public GameObject gameObject;

	internal bool isBackpackCraft;

	public TutorialGameObject()
	{
	}

	public TutorialGameObject(GameObject gameObject)
	{
		this.gameObject = gameObject;
	}

	public override string ToString()
	{
		string arg = ((x <= 0 && y <= 0) ? string.Empty : string.Format("{0}x{1}", x, y));
		return string.Format("TutorialGameObject {0} {1} {2}", ID, gameObject, arg);
	}
}

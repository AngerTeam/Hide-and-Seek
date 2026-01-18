using CraftyEngine.Infrastructure;
using UnityEngine;

public class ActionButtonHierarchy : MonoBehaviour
{
	public UIWidget widget;

	public UIButtonExtended button;

	public UISprite icon;

	public UISprite cooldownSprite;

	public ClickUtility<ActionButtonHierarchy> click;

	public InputInstance inputInstance;
}

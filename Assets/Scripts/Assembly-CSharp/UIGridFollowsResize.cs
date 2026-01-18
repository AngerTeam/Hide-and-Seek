using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(UIGrid))]
public class UIGridFollowsResize : MonoBehaviour
{
	private UIGrid uiGrid_;

	private List<Transform> childList_ = new List<Transform>();

	public Vector2 padding;

	private void Start()
	{
		OnEnable();
	}

	private void OnDisable()
	{
		uiGrid_.onReposition = null;
	}

	private void OnEnable()
	{
		uiGrid_ = GetComponent<UIGrid>();
		uiGrid_.onReposition = UpdateGrid;
	}

	public void UpdateGrid()
	{
		int width = (int)Math.Floor(uiGrid_.cellWidth - padding.x);
		int height = (int)Math.Floor(uiGrid_.cellHeight - padding.y);
		childList_ = uiGrid_.GetChildList();
		foreach (Transform item in childList_)
		{
			UIWidget component = item.GetComponent<UIWidget>();
			component.width = width;
			component.height = height;
		}
	}
}

using System.Collections.Generic;
using UnityEngine;

public class UINewsGrid : MonoBehaviour
{
	public float CellWidth;

	public float CellHeight;

	[ContextMenu("Execute")]
	public void Reposition()
	{
		int num = 0;
		foreach (object item in base.transform)
		{
			((Transform)item).localPosition = new Vector3(0f, (float)(-num) * CellHeight, 0f);
			num++;
		}
	}

	public void Sort(List<NewsItem> list)
	{
		for (int i = 0; i < list.Count; i++)
		{
			list[i].hierarchy.transform.localPosition = new Vector3(0f, (float)(-i) * CellHeight, 0f);
		}
	}
}

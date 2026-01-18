using System;
using UnityEngine;

[Serializable]
public class ScrollerElement
{
	public ScrollerElement prevElement;

	public ScrollerElement nextElement;

	public Transform element;

	public int index;

	public ScrollerElement(Transform element, int index)
	{
		this.element = element;
		this.index = index;
	}

	public ScrollerElement(ScrollerElement item)
	{
		element = item.element;
		index = item.index;
	}

	public void Dispose()
	{
		UnityEngine.Object.Destroy(element.gameObject);
	}
}

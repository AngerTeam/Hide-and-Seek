using System.Collections.Generic;
using UnityEngine;

public class UIItemsGrid : MonoBehaviour
{
	public enum Align
	{
		Horizontal = 0,
		Vertical = 1
	}

	public Align Arrangement;

	public int Limit;

	public int CellWidth;

	public int CellHeight;

	private List<Transform> elements_;

	public void Clear()
	{
		if (elements_ != null)
		{
			elements_.Clear();
			elements_ = null;
		}
	}

	public void Reposition()
	{
		if (elements_ == null)
		{
			return;
		}
		if (Limit <= 0)
		{
			for (int i = 0; i < elements_.Count; i++)
			{
				elements_[i].localPosition = new Vector3(CellWidth * i, 0f, 0f);
			}
			return;
		}
		switch (Arrangement)
		{
		case Align.Horizontal:
		{
			int num = 0;
			int num2 = 0;
			for (int k = 0; k < elements_.Count; k++)
			{
				if (num2 >= Limit)
				{
					num2 = 0;
					num++;
				}
				elements_[k].localPosition = new Vector3(num * CellWidth, -num2 * CellHeight, 0f);
				num2++;
			}
			break;
		}
		case Align.Vertical:
		{
			int num = 0;
			int num2 = 0;
			for (int j = 0; j < elements_.Count; j++)
			{
				if (num >= Limit)
				{
					num = 0;
					num2++;
				}
				elements_[j].localPosition = new Vector3(num * CellWidth, -num2 * CellHeight, 0f);
				num++;
			}
			break;
		}
		}
	}

	public void AddElement(Transform element)
	{
		if (elements_ == null)
		{
			elements_ = new List<Transform>();
		}
		if (!(element == null))
		{
			elements_.Add(element);
			Reposition();
		}
	}
}

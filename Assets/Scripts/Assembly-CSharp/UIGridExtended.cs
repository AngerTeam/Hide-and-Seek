using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("NGUI/Interaction/Grid Extended")]
public class UIGridExtended : UIGrid
{
	public enum CellFitMode
	{
		None = 0,
		CellFitToChild = 1,
		ChildFitToCell = 2
	}

	public CellFitMode cellHorizontalFit;

	public CellFitMode cellVerticalFit;

	public Vector2 spacing;

	public bool wrapByWidget;

	private UIWidget wrapWidget;

	public Vector2 GetCellPosition(int index, UIWidget.Pivot cellPivot = UIWidget.Pivot.TopLeft)
	{
		int x;
		int y;
		GetCell(index, out x, out y);
		Vector2 pivotOffset = NGUIMath.GetPivotOffset(cellPivot);
		float num = Mathf.Lerp(0f, cellWidth, pivotOffset.x);
		float num2 = Mathf.Lerp(cellHeight, 0f, pivotOffset.y);
		float x2 = (float)x * (cellWidth + spacing.x) + num;
		float y2 = (float)(-y) * (cellHeight + spacing.y) - num2;
		return new Vector2(x2, y2);
	}

	public Vector2 GetGridSize(int cellCount)
	{
		if (cellCount <= 0)
		{
			return Vector2.zero;
		}
		int y;
		int x;
		GetCell(cellCount - 1, out x, out y);
		y++;
		x++;
		float x2 = (float)x * (cellWidth + spacing.x) - spacing.x;
		float y2 = (float)y * (cellHeight + spacing.y) - spacing.y;
		return new Vector2(x2, y2);
	}

	public Vector2 GetGridSize()
	{
		int count = GetChildList().Count;
		if (count <= 0)
		{
			return Vector2.zero;
		}
		int y;
		int x;
		GetCell(count - 1, out x, out y);
		y++;
		x++;
		float x2 = (float)x * (cellWidth + spacing.x) - spacing.x;
		float y2 = (float)y * (cellHeight + spacing.y) - spacing.y;
		return new Vector2(x2, y2);
	}

	private void GetCell(int index, out int x, out int y)
	{
		if (arrangement == Arrangement.Horizontal)
		{
			x = ((maxPerLine != 0) ? (index % maxPerLine) : index);
			y = ((maxPerLine != 0) ? (index / maxPerLine) : 0);
		}
		else
		{
			x = ((maxPerLine != 0) ? (index / maxPerLine) : 0);
			y = ((maxPerLine != 0) ? (index % maxPerLine) : index);
		}
	}

	protected override void ResetPosition(List<Transform> list)
	{
		CalculateCellSize(list);
		mReposition = false;
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		Transform transform = base.transform;
		Vector3 min = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
		Vector3 max = new Vector3(float.MinValue, float.MinValue, float.MinValue);
		Bounds bounds = default(Bounds);
		bounds.SetMinMax(min, max);
		int i = 0;
		for (int count = list.Count; i < count; i++)
		{
			Transform transform2 = list[i];
			Vector3 vector = transform2.localPosition;
			float z = vector.z;
			if (arrangement == Arrangement.CellSnap)
			{
				if (cellWidth > 0f)
				{
					vector.x = Mathf.Round(vector.x / cellWidth) * cellWidth;
				}
				if (cellHeight > 0f)
				{
					vector.y = Mathf.Round(vector.y / cellHeight) * cellHeight;
				}
			}
			else
			{
				vector = ((arrangement != 0) ? new Vector3(cellWidth * (float)num2 + (float)num2 * spacing.x, (0f - cellHeight) * (float)num - (float)num * spacing.y, z) : new Vector3(cellWidth * (float)num + (float)num * spacing.x, (0f - cellHeight) * (float)num2 - (float)num2 * spacing.y, z));
			}
			if (animateSmoothly && Application.isPlaying && Vector3.SqrMagnitude(transform2.localPosition - vector) >= 0.0001f)
			{
				SpringPosition springPosition = SpringPosition.Begin(transform2.gameObject, vector, 15f);
				springPosition.updateScrollView = true;
				springPosition.ignoreTimeScale = true;
			}
			else
			{
				transform2.localPosition = vector;
			}
			num3 = Mathf.Max(num3, num);
			num4 = Mathf.Max(num4, num2);
			bounds.Encapsulate(new Vector3(vector.x, vector.y));
			if (++num >= maxPerLine && maxPerLine > 0)
			{
				num = 0;
				num2++;
			}
		}
		if (pivot != 0)
		{
			Vector2 pivotOffset = NGUIMath.GetPivotOffset(pivot);
			float num5;
			float num6;
			if (arrangement == Arrangement.Horizontal)
			{
				num5 = Mathf.Lerp(0f, (float)num3 * cellWidth, pivotOffset.x);
				num6 = Mathf.Lerp((float)(-num4) * cellHeight, 0f, pivotOffset.y);
			}
			else
			{
				num5 = Mathf.Lerp(0f, (float)num4 * cellWidth, pivotOffset.x);
				num6 = Mathf.Lerp((float)(-num3) * cellHeight, 0f, pivotOffset.y);
			}
			for (int j = 0; j < transform.childCount; j++)
			{
				Transform child = transform.GetChild(j);
				SpringPosition component = child.GetComponent<SpringPosition>();
				if (component != null)
				{
					component.target.x -= num5;
					component.target.y -= num6;
					continue;
				}
				Vector3 localPosition = child.localPosition;
				localPosition.x -= num5;
				localPosition.y -= num6;
				child.localPosition = localPosition;
			}
		}
		if (wrapByWidget)
		{
			wrapWidget = wrapWidget ?? GetWrapWidget();
			if (list.Count > 0)
			{
				wrapWidget.SetRect(0f, 0f, bounds.size.x + cellWidth, bounds.size.y + cellHeight);
				wrapWidget.enabled = true;
			}
			else
			{
				wrapWidget.enabled = false;
			}
		}
	}

	protected void CalculateCellSize(List<Transform> list)
	{
		if (cellHorizontalFit == CellFitMode.None && cellVerticalFit == CellFitMode.None)
		{
			return;
		}
		Vector2 vector = new Vector2((cellHorizontalFit == CellFitMode.CellFitToChild) ? 0f : cellWidth, (cellVerticalFit == CellFitMode.CellFitToChild) ? 0f : cellHeight);
		int i = 0;
		for (int count = list.Count; i < count; i++)
		{
			Transform transform = list[i];
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(transform);
			UIWidget uIWidget = null;
			if (cellHorizontalFit == CellFitMode.CellFitToChild)
			{
				vector.x = Mathf.Max(vector.x, bounds.size.x);
			}
			else
			{
				uIWidget = transform.GetComponent<UIWidget>();
				if (uIWidget != null)
				{
					uIWidget.width = Mathf.RoundToInt(cellWidth);
				}
			}
			if (cellVerticalFit == CellFitMode.CellFitToChild)
			{
				vector.y = Mathf.Max(vector.y, bounds.size.y);
				continue;
			}
			uIWidget = uIWidget ?? transform.GetComponent<UIWidget>();
			if (uIWidget != null)
			{
				uIWidget.height = Mathf.RoundToInt(cellHeight);
			}
		}
		cellWidth = vector.x;
		cellHeight = vector.y;
	}

	private UIWidget GetWrapWidget()
	{
		UIWidget uIWidget = GetComponent<UIWidget>() ?? base.gameObject.AddComponent<UIWidget>();
		uIWidget.autoResizeBoxCollider = true;
		uIWidget.pivot = pivot;
		if (uIWidget.GetComponent<BoxCollider>() == null)
		{
			uIWidget.gameObject.AddComponent<BoxCollider>();
		}
		return uIWidget;
	}
}

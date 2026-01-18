using UnityEngine;

public class DistributeWidgets
{
	public static void Distribute(float distance, params UIWidget[] widgets)
	{
		float num = 0f;
		foreach (UIWidget uIWidget in widgets)
		{
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(uIWidget.transform.parent, uIWidget.transform);
			float num2 = bounds.max.x - bounds.min.x;
			float num3 = Mathf.Lerp(num, num + num2, uIWidget.pivotOffset.x);
			Transform transform = uIWidget.transform;
			Vector3 localPosition = transform.localPosition;
			localPosition.x = Mathf.Floor(num3 + 0.5f);
			transform.localPosition = localPosition;
			if ((bool)uIWidget.leftAnchor.target)
			{
				uIWidget.leftAnchor.SetHorizontal(transform.parent, num);
			}
			if ((bool)uIWidget.rightAnchor.target)
			{
				uIWidget.rightAnchor.SetHorizontal(transform.parent, num + num2);
			}
			num += distance + num2;
		}
	}
}

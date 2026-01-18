using UnityEngine;

namespace NguiTools
{
	public class NguiUtils
	{
		public static Vector3 GetPivotOffset(UIWidget widget)
		{
			Vector3 zero = Vector3.zero;
			switch (widget.pivot)
			{
			case UIWidget.Pivot.Top:
			case UIWidget.Pivot.Center:
			case UIWidget.Pivot.Bottom:
				zero.x -= (float)widget.width * 0.5f;
				break;
			case UIWidget.Pivot.TopRight:
			case UIWidget.Pivot.Right:
			case UIWidget.Pivot.BottomRight:
				zero.x -= widget.width;
				break;
			}
			switch (widget.pivot)
			{
			case UIWidget.Pivot.Left:
			case UIWidget.Pivot.Center:
			case UIWidget.Pivot.Right:
				zero.y -= (float)widget.height * 0.5f;
				break;
			case UIWidget.Pivot.TopLeft:
			case UIWidget.Pivot.Top:
			case UIWidget.Pivot.TopRight:
				zero.y -= widget.height;
				break;
			}
			return zero;
		}

		public static void SetScreenPosition(Transform transform, Vector3 pos, Camera uiCamera)
		{
			pos.x = Mathf.Clamp01(pos.x / (float)Screen.width);
			pos.y = Mathf.Clamp01(pos.y / (float)Screen.height);
			transform.position = uiCamera.ViewportToWorldPoint(pos);
			if (uiCamera.orthographic)
			{
				Vector3 localPosition = transform.localPosition;
				localPosition.x = Mathf.Round(localPosition.x);
				localPosition.y = Mathf.Round(localPosition.y);
				transform.localPosition = localPosition;
			}
		}
	}
}

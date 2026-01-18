using UnityEngine;

public class NGUIAnchors
{
	public const float HorizontalCenter = 0.5f;

	public const float HorizontalLeft = 0f;

	public const float HorizontalRight = 1f;

	public const float VerticalBottom = 0f;

	public const float VerticalCenter = 0.5f;

	public const float VerticalTop = 1f;

	public static void SetWidth(UIWidget widget, Transform parent)
	{
		widget.leftAnchor.target = parent;
		widget.leftAnchor.relative = 0f;
		widget.rightAnchor.target = parent;
		widget.rightAnchor.relative = 1f;
	}
}

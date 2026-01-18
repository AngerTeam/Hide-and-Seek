using UnityEngine;

public class UISliderHierarchy : MonoBehaviour
{
	public UISlider slider;

	public UILabel descriptionLabel;

	public UILabel valueLabel;

	public UIButton plusButton;

	public UIButton minusButton;

	public UIWidget sliderRoot;

	public UIWidget foreground;

	public UIWidget background;

	public void SetWidth(int width = 200)
	{
		sliderRoot.width = width;
		foreground.width = width;
	}
}

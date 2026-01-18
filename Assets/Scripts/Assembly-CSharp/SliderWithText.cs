using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Slider))]
public class SliderWithText : MonoBehaviour
{
	public string format = "{0:P0}";

	public Text text;

	private void Start()
	{
		Slider component = GetComponent<Slider>();
		component.onValueChanged.AddListener(HandleValueChanged);
	}

	private void HandleValueChanged(float value)
	{
		text.text = string.Format(format, value);
	}
}

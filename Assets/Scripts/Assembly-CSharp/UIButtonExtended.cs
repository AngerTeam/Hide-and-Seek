using System;

public class UIButtonExtended : UIButton
{
	public bool autoDisableOnPress;

	public event Action onReset;

	public event Action onPress;

	protected override void OnPress(bool isPressed)
	{
		base.OnPress(isPressed);
		if (isEnabled && isPressed && this.onPress != null)
		{
			if (autoDisableOnPress)
			{
				isEnabled = false;
				SetState(State.Pressed, true);
			}
			this.onPress();
		}
	}

	public void Reset()
	{
		isEnabled = true;
		SetState(State.Normal, true);
		if (this.onReset != null)
		{
			this.onReset();
		}
	}
}

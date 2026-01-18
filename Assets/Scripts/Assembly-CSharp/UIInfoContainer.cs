using DG.Tweening;
using UnityEngine;

public class UIInfoContainer : MonoBehaviour
{
	public UIWidget Widget;

	public UILabel Label;

	public float Time;

	public float MinWidth;

	public float MinHeight;

	public float MaxWidth;

	public float MaxHeight;

	private Sequence sequence_;

	private float currentAlpha_;

	private float currentWidth_;

	private float currentHeight_;

	private bool status_;

	private bool visible_;

	public void Switch()
	{
		if (!status_)
		{
			if (visible_)
			{
				Hide();
			}
			else
			{
				Show();
			}
		}
	}

	public void Show()
	{
		if (!status_ && !visible_)
		{
			SetVisibility(true);
			if (sequence_ != null)
			{
				sequence_.Kill(true);
				sequence_ = null;
			}
			SwitchStatus(true);
			sequence_ = DOTween.Sequence();
			float duration = Time / 2f;
			currentWidth_ = MinWidth;
			currentHeight_ = MinHeight;
			currentAlpha_ = 0f;
			sequence_.Append(DOTween.To(() => MinWidth, delegate(float s)
			{
				currentWidth_ = s;
				UpdateWidget();
			}, MaxWidth, duration).SetEase(Ease.InOutQuad));
			sequence_.Append(DOTween.To(() => MinHeight, delegate(float s)
			{
				currentHeight_ = s;
				UpdateWidget();
			}, MaxHeight, duration).SetEase(Ease.InOutQuad));
			sequence_.Append(DOTween.To(() => 0f, delegate(float s)
			{
				currentAlpha_ = s;
				UpdateWidget();
			}, 1f, duration).SetEase(Ease.InOutQuad)).OnComplete(delegate
			{
				SwitchStatus(false);
			});
		}
	}

	public void Hide(bool instantly = false)
	{
		if (!status_ && visible_)
		{
			if (sequence_ != null)
			{
				sequence_.Kill(true);
				sequence_ = null;
			}
			SwitchStatus(true);
			sequence_ = DOTween.Sequence();
			float duration = Time / 2f;
			if (instantly)
			{
				duration = 0f;
			}
			currentWidth_ = MaxWidth;
			currentHeight_ = MaxHeight;
			sequence_.Append(DOTween.To(() => 1f, delegate(float s)
			{
				currentAlpha_ = s;
				UpdateWidget();
			}, 0f, duration).SetEase(Ease.InOutQuad));
			sequence_.Append(DOTween.To(() => MaxWidth, delegate(float s)
			{
				currentWidth_ = s;
				UpdateWidget();
			}, MinWidth, duration).SetEase(Ease.InOutQuad));
			sequence_.Append(DOTween.To(() => MaxHeight, delegate(float s)
			{
				currentHeight_ = s;
				UpdateWidget();
			}, MinHeight, duration).SetEase(Ease.InOutQuad)).OnComplete(delegate
			{
				SwitchStatus(false);
				SetVisibility(false);
			});
		}
	}

	private void SwitchStatus(bool status)
	{
		status_ = status;
	}

	private void SetVisibility(bool visible)
	{
		visible_ = visible;
		base.gameObject.SetActive(visible_);
	}

	private void UpdateWidget()
	{
		Color color = Label.color;
		Widget.width = (int)currentWidth_;
		Widget.height = (int)currentHeight_;
		color.a = currentAlpha_;
		Label.color = color;
	}
}

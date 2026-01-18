using System;
using CraftyGameEngine.Gui.Fx;
using DG.Tweening;
using Extensions;
using UnityEngine;

public class PurchasePopupWindowHierarchy : MonoBehaviour
{
	public UIWidget RaysWidget;

	public UIWidget ContainerWidget;

	public UIWidget ForegroundWidget;

	public UIWidget BackgroundWidget;

	public UIWidget IconWidget;

	public UISprite IconArtikulSprite;

	public UITexture Icon3DTexture;

	public UITexture IconArtikulTexture;

	public UITexture IconSkinTexture;

	public UILabel DescriptionLabel;

	private Vector3 foregroundWidgetPosition_;

	private Vector3 backgroundWidgetPosition_;

	private RayGlow rayGlow_;

	private Sequence sequence_;

	private bool active_;

	public event Action AnimationComplete;

	public void Init()
	{
		foregroundWidgetPosition_ = ForegroundWidget.transform.localPosition;
		backgroundWidgetPosition_ = BackgroundWidget.transform.localPosition;
		ResetContainer();
	}

	private void ResetContainer()
	{
		ContainerWidget.color = new Color(1f, 1f, 1f, 1f);
		RaysWidget.color = new Color(1f, 1f, 1f, 0f);
		IconWidget.color = new Color(1f, 1f, 1f, 0f);
		DescriptionLabel.color = new Color(1f, 1f, 1f, 0f);
		IconWidget.transform.localScale = new Vector3(1.2f, 1.2f, 1.2f);
		ForegroundWidget.transform.localPosition = foregroundWidgetPosition_;
		BackgroundWidget.transform.localPosition = backgroundWidgetPosition_;
		if (sequence_ != null)
		{
			sequence_.Kill();
		}
		sequence_ = null;
		if (rayGlow_ == null)
		{
			rayGlow_ = new RayGlow();
			rayGlow_.RandomizeRays();
			rayGlow_.SetParent(RaysWidget.transform);
		}
	}

	public void Show()
	{
		ResetContainer();
		sequence_ = DOTween.Sequence();
		sequence_.SetEase(Ease.InOutSine);
		sequence_.Insert(0f, ForegroundWidget.transform.DOLocalMoveX(0f, 0.4f, true).SetEase(Ease.OutQuint));
		sequence_.Insert(0f, BackgroundWidget.transform.DOLocalMoveX(0f, 0.5f, true).SetEase(Ease.OutBack));
		sequence_.Insert(0.3f, IconWidget.transform.DOScale(1f, 1f).SetEase(Ease.OutBack));
		sequence_.Insert(0.3f, DOTween.ToAlpha(() => DescriptionLabel.color, delegate(Color s)
		{
			DescriptionLabel.color = s;
		}, 1f, 0.5f));
		sequence_.Insert(0.4f, DOTween.ToAlpha(() => IconWidget.color, delegate(Color s)
		{
			IconWidget.color = s;
		}, 1f, 0.5f));
		sequence_.Insert(0.4f, DOTween.ToAlpha(() => RaysWidget.color, delegate(Color s)
		{
			RaysWidget.color = s;
		}, 1f, 0.5f));
		sequence_.AppendInterval(2.5f);
		sequence_.Append(DOTween.ToAlpha(() => ContainerWidget.color, delegate(Color s)
		{
			ContainerWidget.color = s;
		}, 0f, 0.5f));
		sequence_.AppendCallback(delegate
		{
			this.AnimationComplete.SafeInvoke();
		});
	}
}

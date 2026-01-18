using System;
using CraftyEngine.Utils;
using DG.Tweening;
using UnityEngine;

namespace HudSystem
{
	public class ButtonSetData
	{
		private class WidgetData
		{
			public float originalAlpha;

			public Tweener tween;

			public UIWidget widget;
		}

		private const float LOCK_DURATION = 0.3f;

		private Action action_;

		private UIButton button_;

		private bool enabledByGroup_;

		private ButtonSetGroup group_;

		private bool locked_;

		private UnityTimer timer_;

		private UnityTimerManager unityTimerManager_;

		private WidgetData[] widgets_;

		public ButtonSetData(UIButton button, Action action, ButtonSetGroup group)
		{
			group_ = group;
			button_ = button;
			action_ = action;
			Setup(button.gameObject);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
		}

		public ButtonSetData(UIWidget widget, ButtonSetGroup group)
		{
			group_ = group;
			Setup(widget.gameObject);
		}

		internal void Handle()
		{
			if (!locked_ && enabledByGroup_)
			{
				Lock(true);
				timer_ = unityTimerManager_.SetTimer(0.3f);
				timer_.Completeted += Reset;
				action_();
				ButtonSet.ReportExecuted();
			}
		}

		internal void Reset()
		{
			timer_.Stop();
			timer_ = null;
			Lock(false);
		}

		private void HandleGroupUpdated(ButtonSetGroup group, bool enable)
		{
			if (group_ == group)
			{
				enabledByGroup_ = enable;
				if (widgets_ == null)
				{
					ButtonSet.GroupUpdated -= HandleGroupUpdated;
				}
			}
		}

		private void Lock(bool value)
		{
			locked_ = value;
			if (button_ != null)
			{
				if (value)
				{
					button_.enabled = false;
				}
				button_.SetState(value ? UIButtonColor.State.Pressed : UIButtonColor.State.Normal, true);
				if (!value)
				{
					button_.enabled = true;
				}
			}
		}

		private void RefreshOriginalAlpha()
		{
			if (widgets_ != null)
			{
				for (int i = 0; i < widgets_.Length; i++)
				{
					WidgetData widgetData = widgets_[i];
					widgetData.originalAlpha = widgetData.widget.alpha;
				}
			}
		}

		private void SetAlpha(bool value)
		{
			if (widgets_ == null)
			{
				return;
			}
			float num = ((!enabledByGroup_) ? 0f : ((!value) ? 0.35f : 1f));
			for (int i = 0; i < widgets_.Length; i++)
			{
				WidgetData widgetData = widgets_[i];
				if (widgetData.widget == null)
				{
					continue;
				}
				float num2 = widgetData.originalAlpha * num;
				if (widgetData.tween != null)
				{
					widgetData.tween.Kill();
				}
				if (widgetData.widget.alpha != num2)
				{
					UIWidget widget = widgetData.widget;
					widgetData.tween = DOTween.To(() => widget.alpha, delegate(float a)
					{
						widget.alpha = a;
					}, num2, 0.3f);
				}
			}
		}

		private void Setup(GameObject source)
		{
			enabledByGroup_ = true;
			UIWidget[] componentsInChildren = source.GetComponentsInChildren<UIWidget>();
			if (componentsInChildren != null && componentsInChildren.Length > 0)
			{
				widgets_ = new WidgetData[componentsInChildren.Length];
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					WidgetData widgetData = new WidgetData();
					widgetData.widget = componentsInChildren[i];
					widgetData.originalAlpha = widgetData.widget.alpha;
					widgets_[i] = widgetData;
				}
			}
			ButtonSet.GroupUpdated += HandleGroupUpdated;
		}
	}
}

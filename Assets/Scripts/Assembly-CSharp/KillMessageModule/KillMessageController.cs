using System;
using Combat;
using DG.Tweening;
using NguiTools;
using UnityEngine;

namespace KillMessageModule
{
	public class KillMessageController : IDisposable
	{
		private UIKillMessageBox uiKillMessage_;

		private Sequence sequence_;

		public KillMessageController()
		{
			KillMessageController killMessageController = this;
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			NguiManager singlton2;
			SingletonManager.Get<NguiManager>(out singlton2);
			singlton.Load("KillMessageModule");
			uiKillMessage_ = singlton.InstantiateNGUIIn<UIKillMessageBox>("UIKillMessageBox", singlton2.UiRoot.UpperCenterMessageContainer.gameObject);
			uiKillMessage_.gameObject.SetActive(false);
			UIWidget widget = uiKillMessage_.widget;
			Transform transform = widget.transform;
			Vector3 endValue = Vector3.one * 1.2f;
			Vector3 endValue2 = Vector3.one * 0.2f;
			float num = 0.5f;
			float duration = 1.5f;
			sequence_ = DOTween.Sequence();
			sequence_.Pause();
			sequence_.SetAutoKill(false);
			sequence_.AppendCallback(Reset);
			sequence_.Insert(0f, DOTween.ToAlpha(() => widget.color, delegate(Color c)
			{
				widget.color = c;
			}, 1f, num));
			sequence_.Insert(num, DOTween.ToAlpha(() => widget.color, delegate(Color c)
			{
				widget.color = c;
			}, 0f, duration));
			sequence_.Insert(0f, DOTween.To(() => transform.localScale, delegate(Vector3 c)
			{
				transform.localScale = c;
			}, endValue, num));
			sequence_.Insert(num, DOTween.To(() => transform.localScale, delegate(Vector3 c)
			{
				transform.localScale = c;
			}, endValue2, duration));
			sequence_.AppendCallback(delegate
			{
				killMessageController.uiKillMessage_.gameObject.SetActive(false);
			});
		}

		private void Reset()
		{
			uiKillMessage_.gameObject.SetActive(true);
			uiKillMessage_.widget.color = new Color(1f, 1f, 1f, 0f);
			uiKillMessage_.widget.transform.localScale = Vector3.one * 0.2f;
		}

		public void SetKillMessage(string text, KillMessageType type)
		{
			if (uiKillMessage_ != null)
			{
				uiKillMessage_.killWidget.gameObject.SetActive(false);
				uiKillMessage_.killStreakWidget.gameObject.SetActive(false);
				uiKillMessage_.killAssistWidget.gameObject.SetActive(false);
				UIWidget uIWidget;
				UILabel uILabel;
				switch (type)
				{
				default:
					uIWidget = uiKillMessage_.killWidget;
					uILabel = uiKillMessage_.killLabel;
					break;
				case KillMessageType.KillStreak:
					uIWidget = uiKillMessage_.killStreakWidget;
					uILabel = uiKillMessage_.killStreakLabel;
					break;
				case KillMessageType.Assist:
					uIWidget = uiKillMessage_.killAssistWidget;
					uILabel = uiKillMessage_.killAssistLabel;
					break;
				}
				uIWidget.gameObject.SetActive(true);
				uILabel.text = text;
				sequence_.Restart();
			}
		}

		public void Dispose()
		{
			sequence_.Kill();
			UnityEngine.Object.Destroy(uiKillMessage_.gameObject);
		}
	}
}

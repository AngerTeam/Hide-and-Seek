using DG.Tweening;
using HudSystem;

namespace HideAndSeek
{
	public class CastBarHud : HeadUpDisplay
	{
		private CastBarWidgetHierarchy castBarWidgetHierarchy_;

		private Tweener tweener_;

		public CastBarHud()
		{
			castBarWidgetHierarchy_ = prefabsManager.InstantiateNGUIIn<CastBarWidgetHierarchy>("UICastBarWidget", nguiManager.UiRoot.CastBarContainer.gameObject);
			castBarWidgetHierarchy_.Label.text = Localisations.Get("HideAndSeek_UI_HIDING_CAST");
			hudStateSwitcher.Register(16777216, castBarWidgetHierarchy_);
			SetupTween(1f);
		}

		public override void Dispose()
		{
			if (tweener_ != null)
			{
				tweener_.Kill();
			}
		}

		public override void Resubscribe()
		{
			castBarWidgetHierarchy_.Widget.gameObject.SetActive(false);
		}

		public void ShowCast(bool enable, float duration = 0f)
		{
			castBarWidgetHierarchy_.Widget.gameObject.SetActive(enable);
			if (enable && duration > 0f)
			{
				SetupTween(duration);
				castBarWidgetHierarchy_.Slider.value = 0f;
				tweener_.Rewind();
				tweener_.PlayForward();
			}
		}

		private void SetupTween(float duration)
		{
			if (tweener_ == null || tweener_.Duration() != duration)
			{
				if (tweener_ != null)
				{
					tweener_.Kill();
				}
				tweener_ = DOTween.To(() => castBarWidgetHierarchy_.Slider.value, delegate(float v)
				{
					castBarWidgetHierarchy_.Slider.value = v;
				}, 1f, duration).SetAutoKill(false).SetEase(Ease.Linear)
					.Pause();
			}
		}
	}
}

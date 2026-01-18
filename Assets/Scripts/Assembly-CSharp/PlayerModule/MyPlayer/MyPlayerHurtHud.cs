using CraftyEngine.Sounds;
using DG.Tweening;
using HudSystem;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerHurtHud : HeadUpDisplay
	{
		private const float FLASH_ALPHA = 0.35f;

		private const float FLASH_TIME = 1f;

		private MistScreenHierarchy hierarchy_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private Tweener tween_;

		public MyPlayerHurtHud()
		{
			prefabsManager.Load("PlayerUiPrefabHolder");
			hierarchy_ = prefabsManager.InstantiateNGUIIn<MistScreenHierarchy>("UIRedMistScreen", nguiManager.UiRoot.gameObject);
			hierarchy_.widget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			hierarchy_.widget.alpha = 0f;
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			myPlayerStatsModel_.stats.HealthChanged += HandleHealthUpdate;
			myPlayerStatsModel_.stats.BlinkRed += BlinkRed;
		}

		private void HandleHealthUpdate(int previous, int current, string persId)
		{
			if (current < previous && persId != null)
			{
				PlayHurtSound(persId, current <= 0);
				BlinkRed();
			}
		}

		private void BlinkRed()
		{
			if (tween_ != null)
			{
				tween_.Kill();
			}
			hierarchy_.widget.alpha = 0.35f;
			tween_ = DOTween.To(() => hierarchy_.widget.alpha, delegate(float a)
			{
				hierarchy_.widget.alpha = a;
			}, 0f, 1f).SetEase(Ease.Linear);
		}

		private void PlayHurtSound(string persId, bool death)
		{
			if (death)
			{
				SoundProvider.PlaySingleSound2D(36);
			}
			else
			{
				SoundProvider.PlayGroupSound2D(4, 1f);
			}
		}

		public override void Dispose()
		{
			Object.Destroy(hierarchy_);
			if (myPlayerStatsModel_ != null)
			{
				myPlayerStatsModel_.stats.HealthChanged -= HandleHealthUpdate;
				myPlayerStatsModel_.stats.BlinkRed -= BlinkRed;
			}
			myPlayerStatsModel_ = null;
		}
	}
}

using System;
using Extensions;
using HudSystem;

namespace RateMeModule
{
	public class RateMeWindow : BaseRateWindow
	{
		private RateMeWindowHierarchy hierarchy_;

		public event Action ClosedForever;

		public event Action ClosedForNow;

		public event Action<int> Rated;

		public RateMeWindow()
			: base(false, false)
		{
			prefabsManager.Load("RateMePrefabHolder");
			hierarchy_ = prefabsManager.InstantiateNGUIIn<RateMeWindowHierarchy>("UIRateMeWindow", nguiManager.UiRoot.gameObject);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			ButtonSet.Up(hierarchy_.closeForNowButton, delegate
			{
				this.ClosedForNow.SafeInvoke();
			}, ButtonSetGroup.InWindow);
			ButtonSet.Up(hierarchy_.closeForeverButton, delegate
			{
				this.ClosedForever.SafeInvoke();
			}, ButtonSetGroup.InWindow);
			SetRateElements(hierarchy_.starsButtons, hierarchy_.emptyStar.spriteName, hierarchy_.fullStar.spriteName);
		}

		protected override void Rate(int value)
		{
			base.Rate(value);
			this.Rated.SafeInvoke(value);
		}

		public void Localize(int rewardAmount)
		{
			hierarchy_.closeForNowLabel.text = Localisations.Get("UI_RateWindow_Refuse");
			hierarchy_.closeForeverLabel.text = Localisations.Get("UI_RateWindow_RefuseForever");
			hierarchy_.ratePrompt.text = Localisations.Get("UI_RateWindow_RatePrompt");
			if (rewardAmount > 0)
			{
				hierarchy_.rewardTitleLabel.text = Localisations.Get("UI_RateWindow_Bonus");
				hierarchy_.rewardAmontLabel.text = rewardAmount.ToString();
			}
			else
			{
				hierarchy_.rateGroupWidget.gameObject.SetActive(false);
			}
		}
	}
}

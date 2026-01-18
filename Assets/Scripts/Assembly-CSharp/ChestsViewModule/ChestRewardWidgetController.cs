using System;
using NguiTools;
using NotificationsModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace ChestsViewModule
{
	public class ChestRewardWidgetController : IDisposable
	{
		private Transform container_;

		private ChestRewardWidget hierarchy_;

		private MyPlayerStatsModel myPlayerModel_;

		private NguiManager nguiManager_;

		public ChestRewardWidgetController(Transform container)
		{
			container_ = container;
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerModel_);
			singlton.Load("ChestsPrefabsHolder");
			hierarchy_ = singlton.InstantiateNGUIIn<ChestRewardWidget>("UIChestRewardWidget", container_.gameObject);
			hierarchy_.chestsFullLabel.text = Localisations.Get("UI_Chest_Slots_Full");
			hierarchy_.rewardLabel.text = Localisations.Get("UI_Your_Reward");
			myPlayerModel_.stats.RewardUpdated += UpdateMyReward;
			UpdateMyReward();
		}

		public void Dispose()
		{
			myPlayerModel_.stats.RewardUpdated -= UpdateMyReward;
			UnityEngine.Object.Destroy(hierarchy_.gameObject);
		}

		public void Update()
		{
			bool flag = ChestsManagerBase.GotEmptyRewardChestsSlots(false);
			nguiManager_.SetIconSprite(hierarchy_.rewardIcon, myPlayerModel_.stats.reward.ToString());
			hierarchy_.chestsFullLabel.gameObject.SetActive(!flag);
			if (flag)
			{
				INotifications singlton;
				SingletonManager.Get<INotifications>(out singlton);
				singlton.SetChestGotIdleNotification();
			}
		}

		private void UpdateMyReward()
		{
			bool flag = myPlayerModel_.stats.reward > 0;
			container_.gameObject.SetActive(flag);
			if (flag)
			{
				Update();
			}
		}
	}
}

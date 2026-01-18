using CraftyEngine.Content;

namespace ChestsViewModule.Content
{
	public class ChestSettingsEntries : ContentItem
	{
		public int ADS_CHEST_ARTIKUL_ID = 327;

		public int ADS_CHEST = 9;

		public int ASSASSINS_CHEST_ARTIKUL_ID = 303;

		public int CHEST = 6;

		public int rewardChestsMaxCount = 4;

		public int REWARD_CHEST_ID = 53;

		public int SECRET_CHEST = 7;

		public int assassinChestBonusId = 99;

		public int assassinChestKills = 15;

		public int adChestBonusId = 101;

		public int DAILY_CHEST_ARTIKUL_ID = 482;

		public override void Deserialize()
		{
			ADS_CHEST_ARTIKUL_ID = TryGetInt(ChestsContentKeys.ADS_CHEST_ARTIKUL_ID, 327);
			ADS_CHEST = TryGetInt(ChestsContentKeys.ADS_CHEST, 9);
			ASSASSINS_CHEST_ARTIKUL_ID = TryGetInt(ChestsContentKeys.ASSASSINS_CHEST_ARTIKUL_ID, 303);
			CHEST = TryGetInt(ChestsContentKeys.CHEST, 6);
			rewardChestsMaxCount = TryGetInt(ChestsContentKeys.rewardChestsMaxCount, 4);
			REWARD_CHEST_ID = TryGetInt(ChestsContentKeys.REWARD_CHEST_ID, 53);
			SECRET_CHEST = TryGetInt(ChestsContentKeys.SECRET_CHEST, 7);
			assassinChestBonusId = TryGetInt(ChestsContentKeys.assassinChestBonusId, 99);
			assassinChestKills = TryGetInt(ChestsContentKeys.assassinChestKills, 15);
			adChestBonusId = TryGetInt(ChestsContentKeys.adChestBonusId, 101);
			DAILY_CHEST_ARTIKUL_ID = TryGetInt(ChestsContentKeys.DAILY_CHEST_ARTIKUL_ID, 482);
			base.Deserialize();
		}
	}
}

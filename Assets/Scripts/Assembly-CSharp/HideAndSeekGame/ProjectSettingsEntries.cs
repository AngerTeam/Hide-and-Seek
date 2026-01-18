using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class ProjectSettingsEntries : ContentItem
	{
		public int adEnabled = 1;

		public int adViewReward = 1;

		public int energyMax = 3;

		public int energyRefillTime = 1800;

		public int NickLengthMax = 20;

		public int NickLengthMin = 3;

		public int oneLifePriceInCrystals = 5;

		public float overrideDefaultDamage = 0.2f;

		public float overrideNonInstrumentDamage = 0.2f;

		public int promptsCountInPack = 10;

		public int promptsPriceInCrystals = 30;

		public int rateBonus = 15;

		public int rateBonusId = 143;

		public int rateBonusIdIos = 142;

		public int startingCrystalsCount = 40;

		public int startingPromptsCount = 10;

		public float AutosaveDelay = 180f;

		public int mapUpdateTimeout = 60;

		public float wearToMoneyFactor = 0.01f;

		public int playerMapRecentlyCount = 10;

		public int MapSpawnPointsCountMax = 10;

		public int mapSearchStringLengthMax = 20;

		public int mapSearchTimeout = 1;

		public int regBonusId = 1;

		public override void Deserialize()
		{
			adEnabled = TryGetInt(HideAndSeekGametKeys.adEnabled, 1);
			adViewReward = TryGetInt(HideAndSeekGametKeys.adViewReward, 1);
			energyMax = TryGetInt(HideAndSeekGametKeys.energyMax, 3);
			energyRefillTime = TryGetInt(HideAndSeekGametKeys.energyRefillTime, 1800);
			NickLengthMax = TryGetInt(HideAndSeekGametKeys.NickLengthMax, 20);
			NickLengthMin = TryGetInt(HideAndSeekGametKeys.NickLengthMin, 3);
			oneLifePriceInCrystals = TryGetInt(HideAndSeekGametKeys.oneLifePriceInCrystals, 5);
			overrideDefaultDamage = TryGetFloat(HideAndSeekGametKeys.overrideDefaultDamage, 0.2f);
			overrideNonInstrumentDamage = TryGetFloat(HideAndSeekGametKeys.overrideNonInstrumentDamage, 0.2f);
			promptsCountInPack = TryGetInt(HideAndSeekGametKeys.promptsCountInPack, 10);
			promptsPriceInCrystals = TryGetInt(HideAndSeekGametKeys.promptsPriceInCrystals, 30);
			rateBonus = TryGetInt(HideAndSeekGametKeys.rateBonus, 15);
			rateBonusId = TryGetInt(HideAndSeekGametKeys.rateBonusId, 143);
			rateBonusIdIos = TryGetInt(HideAndSeekGametKeys.rateBonusIdIos, 142);
			startingCrystalsCount = TryGetInt(HideAndSeekGametKeys.startingCrystalsCount, 40);
			startingPromptsCount = TryGetInt(HideAndSeekGametKeys.startingPromptsCount, 10);
			AutosaveDelay = TryGetFloat(HideAndSeekGametKeys.AutosaveDelay, 180f);
			mapUpdateTimeout = TryGetInt(HideAndSeekGametKeys.mapUpdateTimeout, 60);
			wearToMoneyFactor = TryGetFloat(HideAndSeekGametKeys.wearToMoneyFactor, 0.01f);
			playerMapRecentlyCount = TryGetInt(HideAndSeekGametKeys.playerMapRecentlyCount, 10);
			MapSpawnPointsCountMax = TryGetInt(HideAndSeekGametKeys.MapSpawnPointsCountMax, 10);
			mapSearchStringLengthMax = TryGetInt(HideAndSeekGametKeys.mapSearchStringLengthMax, 20);
			mapSearchTimeout = TryGetInt(HideAndSeekGametKeys.mapSearchTimeout, 1);
			regBonusId = TryGetInt(HideAndSeekGametKeys.regBonusId, 1);
			base.Deserialize();
		}
	}
}

using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundSettingsEntries : ContentItem
	{
		public int ambientCastle = 47;

		public int ambientDesert = 48;

		public int battleDefeat = 67;

		public int battleDraw = 68;

		public int battleVictory = 66;

		public int clickGroup = 1;

		public int CombatSoundDistance = 15;

		public int damage = 4;

		public int death = 36;

		public int defaultHitSoundId = 7;

		public float effectsVolume = 0.8f;

		public int endOfTimer = 65;

		public int langingGroup = 13;

		public int levelUpSound = 66;

		public float musicSwitchDelay = 3f;

		public float musicVolume = 0.5f;

		public int objectChange = 16;

		public int objectDropChange = 16;

		public int objectDropToSlot = 15;

		public int objectTakeFromSlot = 14;

		public int openChest = 52;

		public int openRewardChest = 70;

		public int purchaseCompleted = 81;

		public int takeLoot = 14;

		public int windowCloseGroup = 3;

		public int windowOpenGroup = 2;

		public int mapPublished = 66;

		public int defaultStepSoundId = 9;

		public int useAnimationEvent = 1;

		public override void Deserialize()
		{
			ambientCastle = TryGetInt(SoundsContentKeys.ambientCastle, 47);
			ambientDesert = TryGetInt(SoundsContentKeys.ambientDesert, 48);
			battleDefeat = TryGetInt(SoundsContentKeys.battleDefeat, 67);
			battleDraw = TryGetInt(SoundsContentKeys.battleDraw, 68);
			battleVictory = TryGetInt(SoundsContentKeys.battleVictory, 66);
			clickGroup = TryGetInt(SoundsContentKeys.clickGroup, 1);
			CombatSoundDistance = TryGetInt(SoundsContentKeys.CombatSoundDistance, 15);
			damage = TryGetInt(SoundsContentKeys.damage, 4);
			death = TryGetInt(SoundsContentKeys.death, 36);
			defaultHitSoundId = TryGetInt(SoundsContentKeys.defaultHitSoundId, 7);
			effectsVolume = TryGetFloat(SoundsContentKeys.effectsVolume, 0.8f);
			endOfTimer = TryGetInt(SoundsContentKeys.endOfTimer, 65);
			langingGroup = TryGetInt(SoundsContentKeys.langingGroup, 13);
			levelUpSound = TryGetInt(SoundsContentKeys.levelUpSound, 66);
			musicSwitchDelay = TryGetFloat(SoundsContentKeys.musicSwitchDelay, 3f);
			musicVolume = TryGetFloat(SoundsContentKeys.musicVolume, 0.5f);
			objectChange = TryGetInt(SoundsContentKeys.objectChange, 16);
			objectDropChange = TryGetInt(SoundsContentKeys.objectDropChange, 16);
			objectDropToSlot = TryGetInt(SoundsContentKeys.objectDropToSlot, 15);
			objectTakeFromSlot = TryGetInt(SoundsContentKeys.objectTakeFromSlot, 14);
			openChest = TryGetInt(SoundsContentKeys.openChest, 52);
			openRewardChest = TryGetInt(SoundsContentKeys.openRewardChest, 70);
			purchaseCompleted = TryGetInt(SoundsContentKeys.purchaseCompleted, 81);
			takeLoot = TryGetInt(SoundsContentKeys.takeLoot, 14);
			windowCloseGroup = TryGetInt(SoundsContentKeys.windowCloseGroup, 3);
			windowOpenGroup = TryGetInt(SoundsContentKeys.windowOpenGroup, 2);
			mapPublished = TryGetInt(SoundsContentKeys.mapPublished, 66);
			defaultStepSoundId = TryGetInt(SoundsContentKeys.defaultStepSoundId, 9);
			useAnimationEvent = TryGetInt(SoundsContentKeys.useAnimationEvent, 1);
			base.Deserialize();
		}
	}
}

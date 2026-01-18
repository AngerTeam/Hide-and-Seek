using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class PvpSettingsEntries : ContentItem
	{
		public float cooldownMinimalView = 0.7f;

		public int expForDamage = 7;

		public float expForDamageMultp = 1.5f;

		public int expForKill = 1;

		public int expForKillSeries = 5;

		public int expKillSeriesMin = 3;

		public int forceRespawnTime = 30;

		public int Health = 100;

		public int HealthMax = 100;

		public float Hit1Cooldown = 0.3f;

		public int Hit1Damage = 3;

		public float Hit2Cooldown = 0.3f;

		public int Hit2Damage = 5;

		public float HitDistance = 2f;

		public int HPVisibleTime = 10;

		public int InvisibleTime = 5;

		public int pingTimeInterval = 300;

		public int RegenPerSecond1 = 5;

		public int RegenPerSecond2 = 2;

		public int RegenPerSecond3 = 1;

		public int RegenTime1;

		public int RegenTime2;

		public int RegenTime3;

		public float respawnInterval = 5f;

		public override void Deserialize()
		{
			cooldownMinimalView = TryGetFloat(PvpModuleContentKeys.cooldownMinimalView, 0.7f);
			expForDamage = TryGetInt(PvpModuleContentKeys.expForDamage, 7);
			expForDamageMultp = TryGetFloat(PvpModuleContentKeys.expForDamageMultp, 1.5f);
			expForKill = TryGetInt(PvpModuleContentKeys.expForKill, 1);
			expForKillSeries = TryGetInt(PvpModuleContentKeys.expForKillSeries, 5);
			expKillSeriesMin = TryGetInt(PvpModuleContentKeys.expKillSeriesMin, 3);
			forceRespawnTime = TryGetInt(PvpModuleContentKeys.forceRespawnTime, 30);
			Health = TryGetInt(PvpModuleContentKeys.Health, 100);
			HealthMax = TryGetInt(PvpModuleContentKeys.HealthMax, 100);
			Hit1Cooldown = TryGetFloat(PvpModuleContentKeys.Hit1Cooldown, 0.3f);
			Hit1Damage = TryGetInt(PvpModuleContentKeys.Hit1Damage, 3);
			Hit2Cooldown = TryGetFloat(PvpModuleContentKeys.Hit2Cooldown, 0.3f);
			Hit2Damage = TryGetInt(PvpModuleContentKeys.Hit2Damage, 5);
			HitDistance = TryGetFloat(PvpModuleContentKeys.HitDistance, 2f);
			HPVisibleTime = TryGetInt(PvpModuleContentKeys.HPVisibleTime, 10);
			InvisibleTime = TryGetInt(PvpModuleContentKeys.InvisibleTime, 5);
			pingTimeInterval = TryGetInt(PvpModuleContentKeys.pingTimeInterval, 300);
			RegenPerSecond1 = TryGetInt(PvpModuleContentKeys.RegenPerSecond1, 5);
			RegenPerSecond2 = TryGetInt(PvpModuleContentKeys.RegenPerSecond2, 2);
			RegenPerSecond3 = TryGetInt(PvpModuleContentKeys.RegenPerSecond3, 1);
			RegenTime1 = TryGetInt(PvpModuleContentKeys.RegenTime1);
			RegenTime2 = TryGetInt(PvpModuleContentKeys.RegenTime2);
			RegenTime3 = TryGetInt(PvpModuleContentKeys.RegenTime3);
			respawnInterval = TryGetFloat(PvpModuleContentKeys.respawnInterval, 5f);
			base.Deserialize();
		}
	}
}

using CraftyEngine.Content;

namespace FxModule
{
	public class FxSettingsEntries : ContentItem
	{
		public int BLOOD_ARTIKUL_ID = 62;

		public int projectileAmountMax = 50;

		public float projectileDuration = 7f;

		public override void Deserialize()
		{
			BLOOD_ARTIKUL_ID = TryGetInt(FxContentKeys.BLOOD_ARTIKUL_ID, 62);
			projectileAmountMax = TryGetInt(FxContentKeys.projectileAmountMax, 50);
			projectileDuration = TryGetFloat(FxContentKeys.projectileDuration, 7f);
			base.Deserialize();
		}
	}
}

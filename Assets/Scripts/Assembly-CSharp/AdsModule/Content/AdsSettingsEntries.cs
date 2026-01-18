using CraftyEngine.Content;

namespace AdsModule.Content
{
	public class AdsSettingsEntries : ContentItem
	{
		public int adChestBonusId = 101;

		public int adChestTimeout = 60;

		public int adShowingCooldown = 180;

		public string appodealAppKeyAndroid = "9bc5b4534ee9c61c55b43fdffe84d827200ea872da4228a1";

		public string appodealAppKeyIos = "e436f43f1fb956e6575c97e4885c48bfea49701a13dcdebd";

		public override void Deserialize()
		{
			adChestBonusId = TryGetInt(AdsContentKeys.adChestBonusId, 101);
			adChestTimeout = TryGetInt(AdsContentKeys.adChestTimeout, 60);
			adShowingCooldown = TryGetInt(AdsContentKeys.adShowingCooldown, 180);
			appodealAppKeyAndroid = TryGetString(AdsContentKeys.appodealAppKeyAndroid, "9bc5b4534ee9c61c55b43fdffe84d827200ea872da4228a1");
			appodealAppKeyIos = TryGetString(AdsContentKeys.appodealAppKeyIos, "e436f43f1fb956e6575c97e4885c48bfea49701a13dcdebd");
			base.Deserialize();
		}
	}
}

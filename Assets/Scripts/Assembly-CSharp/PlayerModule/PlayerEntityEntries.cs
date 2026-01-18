using CraftyEngine.Content;

namespace PlayerModule
{
	public class PlayerEntityEntries : ContentItem
	{
		public int defaultHealth = 100;

		public int pvpHpVisibleTime = 10;

		public int defaultSkinId = 17;

		public float torsoMaxVerticalAngle = 60f;

		public float torsoMinVerticalAngle = -30f;

		public int allowMultiHit;

		public override void Deserialize()
		{
			defaultHealth = TryGetInt(PlayerContentKeys.defaultHealth, 100);
			pvpHpVisibleTime = TryGetInt(PlayerContentKeys.pvpHpVisibleTime, 10);
			defaultSkinId = TryGetInt(PlayerContentKeys.defaultSkinId, 17);
			torsoMaxVerticalAngle = TryGetFloat(PlayerContentKeys.torsoMaxVerticalAngle, 60f);
			torsoMinVerticalAngle = TryGetFloat(PlayerContentKeys.torsoMinVerticalAngle, -30f);
			allowMultiHit = TryGetInt(PlayerContentKeys.allowMultiHit);
			base.Deserialize();
		}
	}
}

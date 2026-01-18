using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class ProjectPicturesEntries : ContentItem
	{
		public string RandomMapLargeIcon = "randomMapIcon.jpg";

		public string TutorialScreenImage = "TutorialScreen.png";

		public override void Deserialize()
		{
			RandomMapLargeIcon = TryGetString(HideAndSeekGametKeys.RandomMapLargeIcon, "randomMapIcon.jpg");
			TutorialScreenImage = TryGetString(HideAndSeekGametKeys.TutorialScreenImage, "TutorialScreen.png");
			base.Deserialize();
		}
	}
}

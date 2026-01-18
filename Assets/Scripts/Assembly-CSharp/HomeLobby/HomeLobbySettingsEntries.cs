using CraftyEngine.Content;

namespace HomeLobby
{
	public class HomeLobbySettingsEntries : ContentItem
	{
		public string lobbyCameraTweenAmplitude = "3;0.5;2";

		public float lobbyCameraTweenDuration = 10f;

		public string playerInLobbyPosition = "133.5;134;162.85";

		public override void Deserialize()
		{
			lobbyCameraTweenAmplitude = TryGetString(HomeLobbyKeys.lobbyCameraTweenAmplitude, "3;0.5;2");
			lobbyCameraTweenDuration = TryGetFloat(HomeLobbyKeys.lobbyCameraTweenDuration, 10f);
			playerInLobbyPosition = TryGetString(HomeLobbyKeys.playerInLobbyPosition, "133.5;134;162.85");
			base.Deserialize();
		}
	}
}

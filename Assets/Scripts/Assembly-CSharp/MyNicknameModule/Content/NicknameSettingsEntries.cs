using CraftyEngine.Content;

namespace MyNicknameModule.Content
{
	public class NicknameSettingsEntries : ContentItem
	{
		public int NickLengthMax = 20;

		public int NickLengthMin = 3;

		public override void Deserialize()
		{
			NickLengthMax = TryGetInt(MyNicknameModuleContentKeys.NickLengthMax, 20);
			NickLengthMin = TryGetInt(MyNicknameModuleContentKeys.NickLengthMin, 3);
			base.Deserialize();
		}
	}
}

using CraftyEngine.Content;

namespace MyNicknameModule.Content
{
	public class NicknamesEntries : ContentItem
	{
		public int id;

		public string nickname;

		public int deploy_on;

		public override void Deserialize()
		{
			id = TryGetInt(MyNicknameModuleContentKeys.id);
			intKey = id;
			nickname = TryGetString(MyNicknameModuleContentKeys.nickname, string.Empty);
			deploy_on = TryGetInt(MyNicknameModuleContentKeys.deploy_on);
			base.Deserialize();
		}
	}
}

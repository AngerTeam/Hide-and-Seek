using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class NicknamesEntries : ContentItem
	{
		public int id;

		public string nickname;

		public int deploy_on;

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			nickname = TryGetString(PvpModuleContentKeys.nickname, string.Empty);
			deploy_on = TryGetInt(PvpModuleContentKeys.deploy_on);
			base.Deserialize();
		}
	}
}

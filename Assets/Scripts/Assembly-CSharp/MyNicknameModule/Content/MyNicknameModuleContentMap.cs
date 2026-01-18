using System.Collections.Generic;
using CraftyEngine.Content;

namespace MyNicknameModule.Content
{
	public class MyNicknameModuleContentMap : ContentMapBase
	{
		public static NicknameSettingsEntries NicknameSettings;

		public static Dictionary<int, NicknamesEntries> Nicknames;

		public override void Deserialize()
		{
			MyNicknameModuleContentKeys.Deserialize();
			NicknameSettings = FillSettings<NicknameSettingsEntries>("settings");
			Nicknames = ReadInt<NicknamesEntries>(MyNicknameModuleContentKeys.nicknames);
			base.Deserialize();
		}
	}
}

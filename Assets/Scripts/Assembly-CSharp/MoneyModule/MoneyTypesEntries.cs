using CraftyEngine.Content;

namespace MoneyModule
{
	public class MoneyTypesEntries : ContentItem
	{
		public int id;

		public string title;

		public string icon;

		public static int crystalId = 2;

		public string GetFullIconPath()
		{
			return MoneyTypesContentKeys.GetFullIconPath8 + icon;
		}

		public override void Deserialize()
		{
			id = TryGetInt(MoneyTypesContentKeys.id);
			intKey = id;
			title = TryGetString(MoneyTypesContentKeys.title, string.Empty);
			icon = TryGetString(MoneyTypesContentKeys.icon, string.Empty);
			base.Deserialize();
		}
	}
}

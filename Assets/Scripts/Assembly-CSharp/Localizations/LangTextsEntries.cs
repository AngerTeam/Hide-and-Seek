using CraftyEngine.Content;

namespace Localizations
{
	public class LangTextsEntries : ContentItem
	{
		public string id;

		public int lang_id;

		public int type_id;

		public string text;

		public override void Deserialize()
		{
			id = TryGetString(LocalizationContentKeys.id, string.Empty);
			stringKey = id;
			lang_id = TryGetInt(LocalizationContentKeys.lang_id);
			type_id = TryGetInt(LocalizationContentKeys.type_id);
			text = TryGetString(LocalizationContentKeys.text, string.Empty);
			base.Deserialize();
		}
	}
}

using System.Collections.Generic;
using CraftyEngine.Content;

namespace Localizations
{
	public class LocalizationContentMap : ContentMapBase
	{
		public static Dictionary<string, LangTextsEntries> LangTexts;

		public override void Deserialize()
		{
			LocalizationContentKeys.Deserialize();
			LangTexts = ReadString<LangTextsEntries>(LocalizationContentKeys.lang_texts);
			base.Deserialize();
		}
	}
}

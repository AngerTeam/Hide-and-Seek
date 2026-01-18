using CraftyEngine.Content;

namespace Localizations
{
	public class LocalizationsContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<LocalizationContentMap>();
			Localisations.Getter = LocalisationGetter;
		}

		public override void Dispose()
		{
			Localisations.Getter = null;
		}

		private string LocalisationGetter(string key)
		{
			LangTextsEntries value;
			if (LocalizationContentMap.LangTexts != null && LocalizationContentMap.LangTexts.TryGetValue(key, out value) && !string.IsNullOrEmpty(value.text))
			{
				return value.text;
			}
			return null;
		}
	}
}

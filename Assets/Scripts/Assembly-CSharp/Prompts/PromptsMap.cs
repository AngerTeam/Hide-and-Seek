using System.Collections.Generic;
using CraftyEngine.Content;

namespace Prompts
{
	public class PromptsMap : ContentMapBase
	{
		public static TutorialEntries Tutorial;

		public static Dictionary<int, LocationPromptsEntries> LocationPrompts;

		public static Dictionary<int, PromptsEntries> Prompts;

		public static Dictionary<int, PromptCoordinatesEntries> PromptCoordinates;

		public static Dictionary<int, PromptFinalArtikulsEntries> PromptFinalArtikuls;

		public static Dictionary<int, PromptFinalInstrumentsEntries> PromptFinalInstruments;

		public static Dictionary<int, PromptRequiredArtikulsEntries> PromptRequiredArtikuls;

		public override void Deserialize()
		{
			PromptsKeys.Deserialize();
			Tutorial = FillSettings<TutorialEntries>("settings");
			LocationPrompts = ReadInt<LocationPromptsEntries>(PromptsKeys.location_prompts);
			Prompts = ReadInt<PromptsEntries>(PromptsKeys.prompts);
			PromptCoordinates = ReadInt<PromptCoordinatesEntries>(PromptsKeys.prompt_coordinates);
			PromptFinalArtikuls = ReadInt<PromptFinalArtikulsEntries>(PromptsKeys.prompt_final_artikuls);
			PromptFinalInstruments = ReadInt<PromptFinalInstrumentsEntries>(PromptsKeys.prompt_final_instruments);
			PromptRequiredArtikuls = ReadInt<PromptRequiredArtikulsEntries>(PromptsKeys.prompt_required_artikuls);
			base.Deserialize();
		}
	}
}

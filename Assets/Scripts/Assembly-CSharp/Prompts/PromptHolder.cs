using System.Collections.Generic;
using InventoryModule;

namespace Prompts
{
	public class PromptHolder
	{
		public PromptsEntries entry;

		public List<PromptArrowHolder> arrows;

		public List<PromptArticul> resultArticuls;

		public List<PromptArticul> requiredArticuls;

		public PromptZone zone;

		internal bool completed;

		internal RecipeModel recipe;
	}
}

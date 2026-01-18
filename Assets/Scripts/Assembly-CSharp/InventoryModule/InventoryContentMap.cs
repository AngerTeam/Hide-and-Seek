using System.Collections.Generic;
using CraftyEngine.Content;

namespace InventoryModule
{
	public class InventoryContentMap : ContentMapBase
	{
		public static CraftSettingsEntries CraftSettings;

		public static Dictionary<int, ArtikulsEntries> Artikuls;

		public static Dictionary<int, ArtikulGroupsEntries> ArtikulGroups;

		public static Dictionary<int, BonusesEntries> Bonuses;

		public static Dictionary<int, BonusItemsEntries> BonusItems;

		public static Dictionary<int, RecipesEntries> Recipes;

		public static Dictionary<int, RecipeGroupsEntries> RecipeGroups;

		public static Dictionary<int, RecipeBuildingsEntries> RecipeBuildings;

		public static Dictionary<int, RecipeItemsEntries> RecipeItems;

		public static Dictionary<int, RarityEntries> Rarity;

		public static Dictionary<int, WeaponTypesEntries> WeaponTypes;

		public static Dictionary<int, InstrumentsEntries> Instruments;

		public override void Deserialize()
		{
			InventoryContentKeys.Deserialize();
			CraftSettings = FillSettings<CraftSettingsEntries>("settings");
			Artikuls = ReadInt<ArtikulsEntries>(InventoryContentKeys.artikuls);
			ArtikulGroups = ReadInt<ArtikulGroupsEntries>(InventoryContentKeys.artikul_groups);
			Bonuses = ReadInt<BonusesEntries>(InventoryContentKeys.bonuses);
			BonusItems = ReadInt<BonusItemsEntries>(InventoryContentKeys.bonus_items);
			Recipes = ReadInt<RecipesEntries>(InventoryContentKeys.recipes);
			RecipeGroups = ReadInt<RecipeGroupsEntries>(InventoryContentKeys.recipe_groups);
			RecipeBuildings = ReadInt<RecipeBuildingsEntries>(InventoryContentKeys.recipe_buildings);
			RecipeItems = ReadInt<RecipeItemsEntries>(InventoryContentKeys.recipe_items);
			Rarity = ReadInt<RarityEntries>(InventoryContentKeys.rarity);
			WeaponTypes = ReadInt<WeaponTypesEntries>(InventoryContentKeys.weapon_types);
			Instruments = ReadInt<InstrumentsEntries>(InventoryContentKeys.instruments);
			base.Deserialize();
		}
	}
}

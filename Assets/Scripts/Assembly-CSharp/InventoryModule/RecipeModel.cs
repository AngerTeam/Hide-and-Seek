using System;
using System.Collections.Generic;

namespace InventoryModule
{
	public class RecipeModel
	{
		public RecipesEntries entry;

		public float groupSortValue;

		public int wear;

		public bool isHandmade;

		public bool visibleAtOnce;

		public int dimensionX;

		public int dimensionY;

		public List<RecipeItemsEntries> recipeItems;

		public List<int> recipeBuildings;

		public int RecipeId
		{
			get
			{
				return entry.id;
			}
		}

		public int ArtikulResultId
		{
			get
			{
				return entry.artikul_id;
			}
		}

		public int ArtikulResultCount
		{
			get
			{
				return entry.artikul_cnt;
			}
		}

		public string HashCode
		{
			get
			{
				return entry.hash;
			}
		}

		public int CraftTime
		{
			get
			{
				return entry.duration;
			}
		}

		public RecipeModel(RecipesEntries recipeEntry)
		{
			recipeItems = new List<RecipeItemsEntries>();
			recipeBuildings = new List<int>();
			entry = recipeEntry;
			if (InventoryContentMap.RecipeGroups != null)
			{
				RecipeGroupsEntries value;
				InventoryContentMap.RecipeGroups.TryGetValue(recipeEntry.group_id, out value);
				if (value != null)
				{
					groupSortValue = value.sort_val;
				}
			}
			isHandmade = Convert.ToBoolean(recipeEntry.handmade);
			visibleAtOnce = Convert.ToBoolean(recipeEntry.visible_at_once);
		}
	}
}

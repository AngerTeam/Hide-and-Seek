using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using Extensions;
using InventoryViewModule;
using PlayerModule.MyPlayer;

namespace InventoryModule
{
	public class CraftManager : Singleton
	{
		public readonly Dictionary<string, RecipeModel> recipes = new Dictionary<string, RecipeModel>();

		public RecipeModel selectedRecipe;

		private int craftResultMultiplier_ = 1;

		private List<SlotModel> currentSlots_;

		private InventoryInteractionController interaction_;

		private IInventoryLogic inventory_;

		private MyPlayerStatsModel playerModel_;

		private SlotController resultCraftSlot_;

		public BuildingModel Building { get; private set; }

		public string BuildingRef { get; private set; }

		public List<SlotModel> CraftSlots
		{
			get
			{
				return inventory_.Model.Slots['c'];
			}
		}

		public CraftState CraftState { get; private set; }

		public event Action BuildingChanged;

		public event EventHandler<CraftGetResultArgs> OnCraftGetResult;

		public event Action StateUpdated;

		public void CallBuildingChanged()
		{
			this.BuildingChanged.SafeInvoke();
		}

		public override void Dispose()
		{
			this.OnCraftGetResult = null;
		}

		public void DropCraftConsumables()
		{
			foreach (SlotModel craftSlot in CraftSlots)
			{
				SlotModel result;
				if (!craftSlot.IsEmpty && inventory_.TryAddToPanelOrBackpack(craftSlot, out result))
				{
					craftSlot.Clear();
				}
			}
			TryUpdateResult();
		}

		public bool IsLevelRestriction(RecipesEntries recipeEntry)
		{
			return recipeEntry.level_min > playerModel_.stats.experiance.level;
		}

		public override void OnDataLoaded()
		{
			currentSlots_ = new List<SlotModel>();
			SingletonManager.Get<IInventoryLogic>(out inventory_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<InventoryInteractionController>(out interaction_);
			foreach (RecipesEntries value in InventoryContentMap.Recipes.Values)
			{
				RecipeModel recipeModel = FillRecipe(value);
				if (!recipes.ContainsKey(recipeModel.HashCode))
				{
					recipes[recipeModel.HashCode] = recipeModel;
				}
			}
			interaction_.SlotDragged += HandleSlotDragged;
			interaction_.SlotClicked += HandleSlotClicked;
		}

		public void RemoveGhostRecipe()
		{
			foreach (SlotModel craftSlot in CraftSlots)
			{
				craftSlot.GhostItem = null;
				craftSlot.Clear();
			}
			resultCraftSlot_.Model.GhostItem = null;
			resultCraftSlot_.Model.Clear();
			resultCraftSlot_.Redraw();
		}

		public void SetBuilding(string buildingRef, BuildingModel buildingModel)
		{
			BuildingRef = buildingRef;
			Building = buildingModel;
		}

		public void SetGhostRecipe(RecipeModel recipe)
		{
			foreach (SlotModel craftSlot in CraftSlots)
			{
				craftSlot.GhostItem = null;
				foreach (RecipeItemsEntries recipeItem in recipe.recipeItems)
				{
					if (recipeItem.x == craftSlot.x && recipeItem.y == craftSlot.y)
					{
						ArtikulItem ghostItem = new ArtikulItem(recipeItem.artikul_id, recipeItem.artikul_cnt);
						craftSlot.GhostItem = ghostItem;
						break;
					}
				}
				craftSlot.Dirty = true;
			}
			TryUpdateResult();
		}

		public void SetResultSlot(SlotController resultCraftSlot)
		{
			resultCraftSlot_ = resultCraftSlot;
			resultCraftSlot_.Model.slotType = '*';
			resultCraftSlot_.Model.AllowInsert = false;
			resultCraftSlot_.Model.AllowEvents = false;
			resultCraftSlot_.Model.system = true;
		}

		public void TryUpdateResult()
		{
			currentSlots_.Clear();
			string hashCode;
			if (GetRecipieHashCode(out hashCode))
			{
				RecipeModel value;
				if (recipes.TryGetValue(hashCode, out value))
				{
					TryUpdateResultByRecipie(value);
				}
				else
				{
					SetCraftResult(null);
				}
			}
			else
			{
				SetCraftResult(null);
			}
		}

		private RecipeModel FillRecipe(RecipesEntries recipeData)
		{
			RecipeModel recipeModel = new RecipeModel(recipeData);
			foreach (RecipeItemsEntries value in InventoryContentMap.RecipeItems.Values)
			{
				if (value.recipe_id == recipeModel.RecipeId)
				{
					recipeModel.dimensionX = System.Math.Max(recipeModel.dimensionX, value.x);
					recipeModel.dimensionY = System.Math.Max(recipeModel.dimensionY, value.y);
					recipeModel.recipeItems.Add(value);
				}
			}
			recipeModel.recipeItems.Sort(delegate(RecipeItemsEntries a, RecipeItemsEntries b)
			{
				int num = a.y.CompareTo(b.y);
				return (num != 0) ? num : a.x.CompareTo(b.x);
			});
			foreach (RecipeBuildingsEntries value2 in InventoryContentMap.RecipeBuildings.Values)
			{
				if (value2.recipe_id == recipeModel.RecipeId)
				{
					recipeModel.recipeBuildings.Add(value2.building_id);
				}
			}
			return recipeModel;
		}

		private void GetInstantCraftResult(SlotModel slot)
		{
			RemoveCraftMaterials();
			if (this.OnCraftGetResult != null)
			{
				RemoveGhostRecipe();
				this.OnCraftGetResult(this, new CraftGetResultArgs(selectedRecipe.RecipeId, selectedRecipe.ArtikulResultId, selectedRecipe.ArtikulResultCount * craftResultMultiplier_, craftResultMultiplier_, slot.name, BuildingRef));
			}
		}

		private bool GetRecipieHashCode(out string hashCode)
		{
			hashCode = null;
			int num = 100;
			int num2 = 100;
			int num3 = 0;
			int num4 = 0;
			bool flag = true;
			foreach (SlotModel craftSlot in CraftSlots)
			{
				if (!craftSlot.IsEmpty)
				{
					flag = false;
					num = System.Math.Min(craftSlot.x, num);
					num3 = System.Math.Max(craftSlot.x, num3);
					num2 = System.Math.Min(craftSlot.y, num2);
					num4 = System.Math.Max(craftSlot.y, num4);
				}
			}
			if (flag)
			{
				return false;
			}
			string text = string.Format("|{0}|{1}|", 1 + num3 - num, 1 + num4 - num2);
			foreach (SlotModel craftSlot2 in CraftSlots)
			{
				if (craftSlot2.x >= num && craftSlot2.x <= num3 && craftSlot2.y >= num2 && craftSlot2.y <= num4)
				{
					if (!craftSlot2.IsEmpty)
					{
						text += string.Format("{0}/", craftSlot2.ArtikulId);
						currentSlots_.Add(craftSlot2);
					}
					else
					{
						text += "_/";
					}
				}
			}
			hashCode = Hashing.CreateMD5(text);
			return true;
		}

		private void HandleSlotClicked(SlotController slot)
		{
			if (slot.Model.slotType == 'c' || (inventory_.Model.SplittingSlot != null && inventory_.Model.SplittingSlot.slotType == 'c'))
			{
				TryUpdateResult();
			}
		}

		private void HandleSlotDragged(SlotModel slotFrom, SlotModel slotTo)
		{
			if (slotFrom.slotType == '*' && selectedRecipe != null)
			{
				int amount = selectedRecipe.ArtikulResultCount * craftResultMultiplier_;
				SlotMergeStatus slotMergeStatus = inventory_.CheckStatus(slotFrom, slotTo, amount);
				Log.Info("SlotMergeStatus {0}", slotMergeStatus);
				if (slotMergeStatus == SlotMergeStatus.Merge || slotMergeStatus == SlotMergeStatus.Move)
				{
					inventory_.Controller.MoveSlot(slotFrom, slotTo, amount);
					GetInstantCraftResult(slotTo);
				}
			}
			if (slotTo.slotType == 'c' || slotFrom.slotType == 'c')
			{
				TryUpdateResult();
			}
		}

		private void RemoveCraftMaterials()
		{
			for (int i = 0; i < selectedRecipe.recipeItems.Count; i++)
			{
				RecipeItemsEntries recipeItemsEntries = selectedRecipe.recipeItems[i];
				SlotModel slotModel = currentSlots_[i];
				if (slotModel.ArtikulId == recipeItemsEntries.artikul_id || slotModel.Amount >= recipeItemsEntries.artikul_cnt * craftResultMultiplier_)
				{
					slotModel.Item.Amount -= recipeItemsEntries.artikul_cnt * craftResultMultiplier_;
					if (slotModel.Amount == 0)
					{
						slotModel.Clear();
					}
					continue;
				}
				Log.Warning("сraftItem mismatch with recipeItem");
				break;
			}
		}

		private void SetCraftResult(RecipeModel recipe, bool isTemp = false)
		{
			selectedRecipe = recipe;
			resultCraftSlot_.Model.Clear();
			ArtikulItem artikulItem = null;
			if (recipe != null)
			{
				artikulItem = new ArtikulItem(recipe.ArtikulResultId, recipe.ArtikulResultCount * craftResultMultiplier_, recipe.wear, isTemp);
			}
			if (recipe == null)
			{
				CraftState = CraftState.Initial;
				resultCraftSlot_.Model.CanDrag = false;
			}
			else if (IsLevelRestriction(recipe.entry))
			{
				CraftState = CraftState.LevelRestricted;
				resultCraftSlot_.Model.GhostItem = artikulItem;
				resultCraftSlot_.Model.CanDrag = false;
			}
			else
			{
				CraftState = CraftState.CanCraft;
				resultCraftSlot_.Model.CanDrag = true;
				resultCraftSlot_.Model.Insert(artikulItem);
			}
			resultCraftSlot_.Redraw();
			this.StateUpdated.SafeInvoke();
		}

		private void TryUpdateResultByRecipie(RecipeModel recipe)
		{
			if (!recipe.isHandmade && (Building == null || (Building != null && !recipe.recipeBuildings.Contains(Building.BuildingType))))
			{
				SetCraftResult(null);
				return;
			}
			craftResultMultiplier_ = int.MaxValue;
			bool isTemp = false;
			for (int i = 0; i < recipe.recipeItems.Count; i++)
			{
				RecipeItemsEntries recipeItemsEntries = recipe.recipeItems[i];
				SlotModel slotModel = currentSlots_[i];
				if (slotModel.ArtikulId != recipeItemsEntries.artikul_id || slotModel.Amount < recipeItemsEntries.artikul_cnt)
				{
					SetCraftResult(null);
					return;
				}
				if (slotModel.IsTemp)
				{
					isTemp = true;
				}
				int val = slotModel.Amount / recipeItemsEntries.artikul_cnt;
				craftResultMultiplier_ = System.Math.Min(craftResultMultiplier_, val);
			}
			SetCraftResult(recipe, isTemp);
		}
	}
}

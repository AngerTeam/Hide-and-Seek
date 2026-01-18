using System;
using System.Collections.Generic;
using CraftyEngine.Content;
using CraftyVoxelEngine;
using InventoryModule;
using NguiTools;

namespace Prompts
{
	public class PromptsManager : Singleton
	{
		public bool freeMode;

		private List<PromptHolder> prompts_;

		private InvetnoryController inventoryController_;

		private InventoryModel inventoryModel_;

		public PromptsView view;

		private VoxelEngine voxelEngine_;

		private VoxelManager voxelManager_;

		private NguiManager nguiManager_;

		private Dictionary<int, PromptZone> zones_;

		private CraftManager craftManager_;

		public PromptHolder CurrentPrompt { get; private set; }

		public event Action<int> PromptActivated;

		public event Action<int> PromptCompleted;

		public AvaliblePrompt HasAnyPrmpts()
		{
			PromptHolder actualPrompt;
			return HasAnyPrmpts(out actualPrompt);
		}

		public override void Init()
		{
			freeMode = false;
			SingletonManager.Get<InvetnoryController>(out inventoryController_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			SingletonManager.Get<CraftManager>(out craftManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			if (SingletonManager.TryGet<VoxelEngine>(out voxelEngine_))
			{
				voxelManager_ = voxelEngine_.Manager;
			}
			prompts_ = new List<PromptHolder>();
			zones_ = new Dictionary<int, PromptZone>();
			if (view == null)
			{
				view = new PromptsView();
				view.SetPromptText += SetPromptText;
			}
			else
			{
				ClosePrompt();
			}
			craftManager_.BuildingChanged -= HandleBuildingChanged;
			craftManager_.BuildingChanged += HandleBuildingChanged;
			inventoryModel_.SelectedSlotChanged -= HandleSlotChanged;
			inventoryModel_.SelectedSlotChanged += HandleSlotChanged;
		}

		public void SetPromptText(string text)
		{
			nguiManager_.UiRoot.TutorialPromptLabel.text = string.Empty;
			nguiManager_.UiRoot.TutorialPromptLabel.text = text;
		}

		private void ClosePrompt()
		{
			CurrentPrompt = null;
			craftManager_.RemoveGhostRecipe();
		}

		private void HandleBuildingChanged()
		{
			TrySetGhostRecipe();
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<PromptsMap>();
			if (voxelManager_ != null)
			{
				voxelEngine_.PlayerEnterTrigger -= HandlePlayerEnterTrigger;
				voxelEngine_.PlayerEnterTrigger += HandlePlayerEnterTrigger;
			}
		}

		public override void OnReset()
		{
			for (int i = 0; i < prompts_.Count; i++)
			{
				PromptHolder promptHolder = prompts_[i];
				view.ClearArrows(promptHolder);
			}
			prompts_.Clear();
		}

		public void ShowActualPrompt()
		{
			PromptHolder actualPrompt = null;
			if (HasAnyPrmpts(out actualPrompt) == AvaliblePrompt.New)
			{
				HideCurrentPrompt();
				CurrentPrompt = actualPrompt;
				List<RecipeModel> recipes = new List<RecipeModel>();
				GetAllRecipies(actualPrompt, recipes);
				GetCraftableRecipie(actualPrompt, recipes);
				view.SetText(actualPrompt.entry.description);
				view.AddArrows(actualPrompt);
				TrySetGhostRecipe();
				if (this.PromptActivated != null)
				{
					this.PromptActivated(actualPrompt.entry.id);
				}
			}
		}

		private static void GetAllRecipies(PromptHolder currentPrompt, List<RecipeModel> recipes)
		{
			CraftManager craftManager = SingletonManager.Get<CraftManager>();
			if (currentPrompt.recipe != null || currentPrompt.resultArticuls.Count != 1)
			{
				return;
			}
			int id = currentPrompt.resultArticuls[0].id;
			foreach (RecipeModel value in craftManager.recipes.Values)
			{
				if (value.ArtikulResultId == id)
				{
					recipes.Add(value);
				}
			}
		}

		private void TrySetGhostRecipe()
		{
			if (CurrentPrompt != null && CurrentPrompt.recipe != null)
			{
				craftManager_.SetGhostRecipe(CurrentPrompt.recipe);
			}
		}

		public static void GetCraftableRecipie(PromptHolder currentPrompt, List<RecipeModel> recipes)
		{
			InvetnoryController invetnoryController = SingletonManager.Get<InvetnoryController>();
			Dictionary<ushort, int> dictionary = new Dictionary<ushort, int>();
			currentPrompt.recipe = null;
			for (int i = 0; i < recipes.Count; i++)
			{
				for (int j = 0; j < recipes[i].recipeItems.Count; j++)
				{
					RecipeItemsEntries recipeItemsEntries = recipes[i].recipeItems[j];
					ushort key = (ushort)recipeItemsEntries.artikul_id;
					if (!dictionary.ContainsKey(key))
					{
						dictionary[key] = 0;
					}
					int num = dictionary[key];
					num += recipeItemsEntries.artikul_cnt;
					dictionary[key] = num;
				}
				bool flag = true;
				foreach (KeyValuePair<ushort, int> item in dictionary)
				{
					if (!invetnoryController.HasArtikul(item.Key, item.Value))
					{
						flag = false;
					}
				}
				dictionary.Clear();
				if (flag)
				{
					currentPrompt.recipe = recipes[i];
					break;
				}
			}
		}

		internal void HandleLevelStarted(int levelId)
		{
			foreach (LocationPromptsEntries value in PromptsMap.LocationPrompts.Values)
			{
				if (value.location_id == levelId)
				{
					AddPrompt(value.prompt_id);
				}
			}
			prompts_.Sort(delegate(PromptHolder x, PromptHolder y)
			{
				int num = x.entry.progress.CompareTo(y.entry.progress);
				return (num == 0) ? x.entry.id.CompareTo(y.entry.id) : num;
			});
		}

		private void AddPrompt(int prompt_id)
		{
			PromptHolder promptHolder = new PromptHolder();
			promptHolder.entry = PromptsMap.Prompts[prompt_id];
			prompts_.Add(promptHolder);
			promptHolder.arrows = new List<PromptArrowHolder>();
			promptHolder.resultArticuls = new List<PromptArticul>();
			promptHolder.requiredArticuls = new List<PromptArticul>();
			promptHolder.zone = new PromptZone();
			promptHolder.zone.id = promptHolder.entry.zone_number;
			zones_[promptHolder.zone.id] = promptHolder.zone;
			foreach (PromptFinalArtikulsEntries value in PromptsMap.PromptFinalArtikuls.Values)
			{
				if (value.prompt_id == prompt_id)
				{
					promptHolder.resultArticuls.Add(new PromptArticul
					{
						id = value.artikul_id,
						count = value.cnt
					});
				}
			}
			foreach (PromptRequiredArtikulsEntries value2 in PromptsMap.PromptRequiredArtikuls.Values)
			{
				if (value2.prompt_id == prompt_id)
				{
					promptHolder.requiredArticuls.Add(new PromptArticul
					{
						id = value2.artikul_id,
						count = value2.cnt
					});
				}
			}
			foreach (PromptCoordinatesEntries value3 in PromptsMap.PromptCoordinates.Values)
			{
				if (value3.prompt_id == prompt_id)
				{
					PromptArrowHolder promptArrowHolder = new PromptArrowHolder();
					promptArrowHolder.position = Vector3Utils.SafeParse(value3.position);
					promptArrowHolder.text = value3.text;
					PromptArrowHolder item = promptArrowHolder;
					promptHolder.arrows.Add(item);
				}
			}
		}

		private void CompletePreviousPrompts(PromptZone zone)
		{
			bool flag = true;
			for (int i = 0; i < prompts_.Count; i++)
			{
				PromptHolder promptHolder = prompts_[i];
				if (!flag && promptHolder.zone != zone)
				{
					break;
				}
				if (promptHolder.zone.id == zone.id)
				{
					flag = false;
				}
				if (!promptHolder.completed)
				{
					promptHolder.completed = true;
				}
			}
		}

		private void HandleSlotChanged()
		{
			RefreshAllPrompts();
			HidePromptIfCompleted();
		}

		private void HandlePlayerEnterTrigger(RegionEventArgs triggerEventArgs)
		{
			int id = triggerEventArgs.region.id;
			PromptZone value;
			if (zones_.TryGetValue(id, out value))
			{
				value.completed = true;
				CompletePreviousPrompts(value);
			}
			HidePromptIfCompleted();
		}

		private AvaliblePrompt HasAnyPrmpts(out PromptHolder actualPrompt)
		{
			actualPrompt = null;
			HidePromptIfCompleted();
			RefreshAllPrompts();
			for (int i = 0; i < prompts_.Count; i++)
			{
				PromptHolder promptHolder = prompts_[i];
				if (!promptHolder.completed)
				{
					actualPrompt = promptHolder;
					break;
				}
			}
			if (actualPrompt == null)
			{
				return AvaliblePrompt.None;
			}
			if (actualPrompt == CurrentPrompt)
			{
				return AvaliblePrompt.Same;
			}
			return AvaliblePrompt.New;
		}

		private void HideCurrentPrompt()
		{
			if (CurrentPrompt != null)
			{
				view.ClearArrows(CurrentPrompt);
				view.SetText(string.Empty);
				if (this.PromptCompleted != null)
				{
					this.PromptCompleted(CurrentPrompt.entry.id);
				}
				ClosePrompt();
			}
		}

		private void HidePromptIfCompleted()
		{
			if (CurrentPrompt != null && CurrentPrompt.completed)
			{
				HideCurrentPrompt();
				if (freeMode)
				{
					ShowActualPrompt();
				}
			}
		}

		private void RefreshAllPrompts()
		{
			for (int i = 0; i < prompts_.Count; i++)
			{
				RefreshPromptState(prompts_[i]);
			}
		}

		private void RefreshPromptState(PromptHolder promptHolder)
		{
			if (promptHolder.completed || promptHolder.resultArticuls.Count <= 0)
			{
				return;
			}
			bool flag = true;
			foreach (PromptArticul resultArticul in promptHolder.resultArticuls)
			{
				if (!inventoryController_.HasArtikul((ushort)resultArticul.id, resultArticul.count))
				{
					flag = false;
				}
			}
			if (flag)
			{
				promptHolder.completed = true;
			}
		}

		private bool TryShow(PromptHolder promptHolder)
		{
			foreach (PromptArticul resultArticul in promptHolder.resultArticuls)
			{
				if (!inventoryController_.HasArtikul((ushort)resultArticul.id, resultArticul.count))
				{
					return true;
				}
			}
			return true;
		}

		public void Clear()
		{
			nguiManager_.UiRoot.TutorialPromptLabel.text = string.Empty;
		}
	}
}

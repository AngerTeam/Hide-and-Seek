using CraftyEngine.Infrastructure;
using InventoryModule;
using NguiTools;
using Prompts;
using UnityEngine;

namespace TutorialModule
{
	public class TutorialView
	{
		private UITutorialArrowHierarchy arrow_;

		private TutorialState currentState_;

		private PromptsManager promptsManager_;

		private UnityEvent unityEvent_;

		private bool enabled_;

		public UITutorialWidgetHierarchy Hierarchy { get; private set; }

		public TutorialView()
		{
			NguiManager singlton;
			SingletonManager.Get<NguiManager>(out singlton);
			PrefabsManager singlton2;
			SingletonManager.Get<PrefabsManager>(out singlton2);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<PromptsManager>(out promptsManager_);
			singlton2.Load("TutorialPrefabsHolder");
			Hierarchy = singlton2.InstantiateIn<UITutorialWidgetHierarchy>("UITutorialWidget", singlton.UiRoot.transform);
			UIWidget widget = Hierarchy.widget;
			widget.SetAnchor(singlton.UiRoot.gameObject, 0, 0, 0, 0);
			Hierarchy.gameObject.SetActive(false);
			Hierarchy.GetComponent<UIPanel>().depth = 950;
			enabled_ = false;
		}

		public static TutorialGameObject FindTutorialObject(int id, int x = 0, int y = 0, bool isBackpack = false)
		{
			for (int i = 0; i < TutorialStorage.list.Count; i++)
			{
				TutorialGameObject tutorialGameObject = TutorialStorage.list[i];
				if (tutorialGameObject.gameObject != null && tutorialGameObject.ID == id && tutorialGameObject.x == x && tutorialGameObject.y == y && tutorialGameObject.isBackpackCraft == isBackpack)
				{
					return tutorialGameObject;
				}
			}
			TutorialObject[] array = Object.FindObjectsOfType<TutorialObject>();
			foreach (TutorialObject tutorialObject in array)
			{
				if (tutorialObject.ID == id)
				{
					TutorialGameObject tutorialGameObject2 = new TutorialGameObject();
					tutorialGameObject2.ID = id;
					tutorialGameObject2.gameObject = tutorialObject.gameObject;
					return tutorialGameObject2;
				}
			}
			return null;
		}

		internal void Close()
		{
			Hierarchy.gameObject.SetActive(false);
			if (enabled_)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UpdateScreen);
			}
			enabled_ = false;
			Update(null);
		}

		internal void Update(TutorialState state)
		{
			if (state == null)
			{
				currentState_ = null;
				return;
			}
			currentState_ = state;
			if (state.invisible && Hierarchy.gameObject.activeSelf)
			{
				Hierarchy.gameObject.SetActive(false);
				return;
			}
			if (!state.invisible && !Hierarchy.gameObject.activeSelf)
			{
				Hierarchy.gameObject.SetActive(true);
			}
			if (!enabled_)
			{
				enabled_ = true;
				unityEvent_.Subscribe(UnityEventType.Update, UpdateScreen);
			}
			Hierarchy.labelSide.gameObject.SetActive(false);
			Hierarchy.labelRight.gameObject.SetActive(false);
			Hierarchy.labelCenter.gameObject.SetActive(false);
			Hierarchy.labelLeft.gameObject.SetActive(false);
			Hierarchy.arrowRight.gameObject.SetActive(false);
			Hierarchy.arrowTop.gameObject.SetActive(false);
			Hierarchy.arrowBottom.gameObject.SetActive(false);
			Hierarchy.arrowLeft.gameObject.SetActive(false);
			if (!currentState_.invisible)
			{
				SetupState();
			}
		}

		private void SetupState()
		{
			if (currentState_.arrow == null)
			{
				currentState_.arrow = new TutorialHighlight();
			}
			TutorialHighlight label = currentState_.label;
			TutorialHighlight arrow = currentState_.arrow;
			if (arrow.anchor == TutorialAnchor.Undefined)
			{
				arrow.anchor = label.anchor;
			}
			UILabel uILabel = ((label.anchor == TutorialAnchor.Left) ? Hierarchy.labelLeft : ((label.anchor == TutorialAnchor.Right) ? Hierarchy.labelRight : ((label.anchor != TutorialAnchor.Side) ? Hierarchy.labelCenter : Hierarchy.labelSide)));
			if (arrow.anchor == TutorialAnchor.Left)
			{
				arrow_ = Hierarchy.arrowLeft;
			}
			else if (arrow.anchor == TutorialAnchor.Right)
			{
				arrow_ = Hierarchy.arrowRight;
			}
			else
			{
				arrow_ = Hierarchy.arrowTop;
			}
			arrow_.gameObject.SetActive(true);
			uILabel.gameObject.SetActive(true);
			if (string.IsNullOrEmpty(currentState_.title))
			{
				uILabel.text = Localisations.Get("Missing message");
				Log.Error("Missing title for {0}", currentState_.GetType());
				return;
			}
			string text = Localisations.Get(currentState_.title);
			if (promptsManager_.CurrentPrompt != null && promptsManager_.CurrentPrompt.recipe != null)
			{
				if (text.Contains("%recipie%"))
				{
					text = text.Replace("%recipie%", promptsManager_.CurrentPrompt.recipe.entry.title);
				}
				if (text.Contains("%recipe_group%"))
				{
					RecipeGroupsEntries recipeGroupsEntries = InventoryContentMap.RecipeGroups[promptsManager_.CurrentPrompt.recipe.entry.group_id];
					text = text.Replace("%recipe_group%", recipeGroupsEntries.title);
				}
			}
			uILabel.text = text;
		}

		private void PlaceIn(TutorialHighlight highlight, bool label)
		{
			GameObject gameObject = highlight.tutorialObject.gameObject;
			UIWidget uIWidget = gameObject.GetComponent<UIWidget>();
			if (uIWidget == null)
			{
				uIWidget = gameObject.GetComponentInChildren<UIWidget>();
			}
			UISprite uISprite = ((!label) ? Hierarchy.holeArrow : Hierarchy.holeLabel);
			uISprite.width = uIWidget.width;
			uISprite.height = uIWidget.height;
			uISprite.transform.position = uIWidget.transform.position;
			uISprite.transform.localPosition += NguiUtils.GetPivotOffset(uIWidget);
			if (label)
			{
				return;
			}
			if (arrow_ == Hierarchy.arrowTop)
			{
				if (uISprite.transform.position.y > 0f)
				{
					arrow_.gameObject.SetActive(false);
					arrow_ = Hierarchy.arrowBottom;
					arrow_.gameObject.SetActive(true);
				}
			}
			else if (arrow_ == Hierarchy.arrowBottom && uISprite.transform.position.y < 0f)
			{
				arrow_.gameObject.SetActive(false);
				arrow_ = Hierarchy.arrowTop;
				arrow_.gameObject.SetActive(true);
			}
		}

		private void PlaceView(TutorialHighlight view, bool label)
		{
			if (view.tutorialObject == null)
			{
				if (!label && view.itemId == 0 && currentState_.label.tutorialObject != null)
				{
					currentState_.arrow.tutorialObject = currentState_.label.tutorialObject;
					PlaceIn(view, label);
				}
				else if (view.itemId != 0)
				{
					view.tutorialObject = FindTutorialObject(view.itemId);
					if (view.tutorialObject != null && view.tutorialObject.gameObject != null)
					{
						PlaceIn(view, label);
						return;
					}
					Hierarchy.gameObject.SetActive(false);
					Log.Error("Unalbe to find tutorial element {0} ({1})", currentState_.GetType(), view.itemId);
				}
			}
			else
			{
				PlaceIn(view, label);
			}
		}

		private void UpdateScreen()
		{
			if (currentState_ != null && !currentState_.invisible)
			{
				PlaceView(currentState_.label, true);
				PlaceView(currentState_.arrow, false);
			}
		}
	}
}

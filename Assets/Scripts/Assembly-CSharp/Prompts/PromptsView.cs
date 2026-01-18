using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using DG.Tweening;
using Extensions;
using HideAndSeekGame;
using NguiTools;
using PlayerCameraModule;
using ShapesModule;
using UnityEngine;

namespace Prompts
{
	public class PromptsView
	{
		private FileHolder arrowLoader_;

		private PromptHolder currentPromptHolder_;

		private static GameObject directionArrowInstance_;

		private static GameObject promptArrowPrefab_;

		public event Action<string> SetPromptText;

		internal void AddArrow(Vector3 position, string text, bool addExtraArrow = false, bool addLabel = false)
		{
			PromptHolder promptHolder = new PromptHolder();
			promptHolder.arrows = new List<PromptArrowHolder>();
			promptHolder.arrows.Add(new PromptArrowHolder
			{
				position = position,
				text = text
			});
			AddArrows(promptHolder);
		}

		internal void AddArrows(PromptHolder promptHolder, bool addExtraArrow = false, bool addLabel = false)
		{
			currentPromptHolder_ = promptHolder;
			if (promptHolder.arrows.Count > 0 && addExtraArrow)
			{
				directionArrowInstance_.SetActive(true);
				PlayerCameraManager singlton = null;
				SingletonManager.Get<PlayerCameraManager>(out singlton);
				directionArrowInstance_.transform.SetParent(singlton.PlayerCamera.transform);
				directionArrowInstance_.transform.localPosition = new Vector3(0f, 0.1f, 0.3f);
				directionArrowInstance_.transform.localScale = Vector3.one * 0.05f;
				directionArrowInstance_.layer = 9;
			}
			for (int i = 0; i < promptHolder.arrows.Count; i++)
			{
				PromptArrowHolder arrow = promptHolder.arrows[i];
				AddArrowInstance(arrow);
				if (addLabel)
				{
					AddArrowText(arrow);
				}
			}
		}

		private void AddArrowInstance(PromptArrowHolder arrow)
		{
			arrow.instance = UnityEngine.Object.Instantiate(promptArrowPrefab_);
			arrow.instance.transform.position = arrow.position;
			arrow.instance.SetActive(true);
			Sequence sequence = DOTween.Sequence();
			float num = 0.5f;
			sequence.Insert(0f, DOTween.To(() => arrow.instance.transform.position, delegate(Vector3 x)
			{
				arrow.instance.transform.position = x;
			}, arrow.position + Vector3.up, num).SetEase(Ease.InOutQuad));
			sequence.Insert(num, DOTween.To(() => arrow.instance.transform.position, delegate(Vector3 x)
			{
				arrow.instance.transform.position = x;
			}, arrow.position, num).SetEase(Ease.InQuad));
			sequence.SetLoops(-1, LoopType.Restart);
		}

		private static void AddArrowText(PromptArrowHolder arrow)
		{
			if (!string.IsNullOrEmpty(arrow.text))
			{
				PlayerCameraManager singlton = null;
				SingletonManager.Get<PlayerCameraManager>(out singlton);
				NguiManager nguiManager = SingletonManager.Get<NguiManager>();
				PrefabsManagerNGUI prefabsManagerNGUI = SingletonManager.Get<PrefabsManagerNGUI>();
				prefabsManagerNGUI.Load("TutorialPrefabsHolder");
				arrow.label = prefabsManagerNGUI.InstantiateNGUIInAndSetUIText<UILabel>("UIPromptArrowLabel", nguiManager.UiRoot.gameObject, arrow.text);
				arrow.label.overflowMethod = UILabel.Overflow.ResizeFreely;
				arrow.anchor = new GameObject("anchor");
				arrow.anchor.transform.position = arrow.position;
				UIFollowTarget uIFollowTarget = arrow.label.gameObject.AddComponent<UIFollowTarget>();
				uIFollowTarget.gameCamera = singlton.PlayerCamera;
				uIFollowTarget.disableIfInvisible = true;
				uIFollowTarget.target = arrow.anchor.transform;
			}
		}

		internal void ClearArrows(PromptHolder promptHolder)
		{
			for (int i = 0; i < promptHolder.arrows.Count; i++)
			{
				PromptArrowHolder promptArrowHolder = promptHolder.arrows[i];
				UnityEngine.Object.Destroy(promptArrowHolder.instance);
				if (promptArrowHolder.label != null)
				{
					UnityEngine.Object.Destroy(promptArrowHolder.label.gameObject);
					UnityEngine.Object.Destroy(promptArrowHolder.anchor);
				}
			}
			promptHolder.arrows.Clear();
			directionArrowInstance_.SetActive(false);
			directionArrowInstance_.transform.SetParent(null);
		}

		public void LoadModel()
		{
			if (directionArrowInstance_ == null && arrowLoader_ == null)
			{
				ObjectModelsEntries objectModelsEntries = ShapesContentMap.ObjectModels[HideAndSeekGameMap.GameConstants.PROMPT_ARROW_MODEL];
				FilesManager singlton;
				SingletonManager.Get<FilesManager>(out singlton);
				QueueManager singlton2;
				SingletonManager.Get<QueueManager>(out singlton2);
				arrowLoader_ = singlton.AddLoadBundleTask(objectModelsEntries.GetFullBundlePath());
				singlton2.AddTask(SaveArrowPrefab);
			}
		}

		internal void SetText(string description)
		{
			this.SetPromptText.SafeInvoke(description);
		}

		private void SaveArrowPrefab()
		{
			promptArrowPrefab_ = (GameObject)arrowLoader_.Instantiate();
			directionArrowInstance_ = UnityEngine.Object.Instantiate(promptArrowPrefab_);
			UnityEngine.Object.DontDestroyOnLoad(promptArrowPrefab_);
			UnityEngine.Object.DontDestroyOnLoad(directionArrowInstance_);
			promptArrowPrefab_.SetActive(false);
			directionArrowInstance_.SetActive(false);
			UnityEvent singlton;
			SingletonManager.Get<UnityEvent>(out singlton, 1);
			singlton.Subscribe(UnityEventType.Update, UnityUpdate);
		}

		private void UnityUpdate()
		{
			if (!directionArrowInstance_.activeSelf)
			{
				return;
			}
			float num = float.MaxValue;
			Vector3 worldPosition = Vector3.zero;
			for (int i = 0; i < currentPromptHolder_.arrows.Count; i++)
			{
				Vector3 position = currentPromptHolder_.arrows[i].position;
				float num2 = Vector3.Distance(position, directionArrowInstance_.transform.position);
				if (num2 < num)
				{
					num = num2;
					worldPosition = position;
				}
			}
			directionArrowInstance_.transform.LookAt(worldPosition);
			directionArrowInstance_.transform.Rotate(0f, 180f, 0f);
		}
	}
}

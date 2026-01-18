using System;
using CraftyEngine.Utils;
using Extensions;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace MiniGameCraft.GameStates
{
	public class RespawnHud : GuiModlule
	{
		private bool disposed_;

		private UiRoller roller_;

		private UnityTimer rollerTimer_;

		private SpawnButtonHierarchy spawnButtonHierarchy_;

		private SpawnTimerHierarchy timerHierarchy_;

		public event Action ReadyClicked;

		public RespawnHud()
		{
			PrefabsManagerNGUI prefabsManagerNGUI = SingletonManager.Get<PrefabsManagerNGUI>();
			prefabsManagerNGUI.Load("SpawnHudModulePrefabsHolder");
			NguiManager nguiManager = SingletonManager.Get<NguiManager>();
			timerHierarchy_ = prefabsManagerNGUI.InstantiateNGUIIn<SpawnTimerHierarchy>("UISpawnCounter", nguiManager.UiRoot.TopLeftContainer.gameObject);
			spawnButtonHierarchy_ = prefabsManagerNGUI.InstantiateNGUIIn<SpawnButtonHierarchy>("UIStartButton", nguiManager.UiRoot.BottomRightContainer.gameObject);
			ButtonSet.Up(spawnButtonHierarchy_.startButton, StartButtonClicked, ButtonSetGroup.Hud);
			roller_ = new UiRoller(spawnButtonHierarchy_.rollerContainer);
			roller_.Widget.gameObject.SetActive(false);
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			rollerTimer_ = unityTimerManager.SetTimer(5f, false);
			rollerTimer_.repeat = true;
			rollerTimer_.Completeted += HandleCompleteted;
			UILabel componentInChildren = spawnButtonHierarchy_.startButton.GetComponentInChildren<UILabel>();
			componentInChildren.text = Localisations.Get("UI_lobby_PvpButton");
			SetVisible(false);
		}

		public override void Dispose()
		{
			disposed_ = true;
			UnityEngine.Object.Destroy(timerHierarchy_.gameObject);
			UnityEngine.Object.Destroy(spawnButtonHierarchy_.gameObject);
			rollerTimer_.Stop();
			roller_.Dispose();
			this.ReadyClicked = null;
		}

		public void SetTime(string time)
		{
			if (!disposed_ && timerHierarchy_.gameObject.activeSelf)
			{
				string text = Localisations.Get("UI_PvpForceRespawnCounterText");
				text = text.Replace("%time%", string.Empty);
				timerHierarchy_.titleLabel.text = text;
				timerHierarchy_.countLabel.text = time;
			}
		}

		public void SetVisible(bool visible)
		{
			timerHierarchy_.gameObject.SetActive(visible);
			spawnButtonHierarchy_.gameObject.SetActive(visible);
		}

		private void HandleCompleteted()
		{
			roller_.Widget.gameObject.SetActive(false);
			spawnButtonHierarchy_.startButton.gameObject.SetActive(true);
		}

		private void StartButtonClicked()
		{
			this.ReadyClicked.SafeInvoke();
			roller_.Widget.gameObject.SetActive(true);
			spawnButtonHierarchy_.startButton.gameObject.SetActive(false);
			rollerTimer_.enable = true;
		}
	}
}

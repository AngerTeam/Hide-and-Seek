using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using CraftyGameEngine.Player;
using CraftyMultiplayerEngine;
using HudSystem;
using PlayerModule;
using PlayerModule.MyPlayer;
using UnityEngine;
using WindowsModule;

namespace Modules.KillCam
{
	public class KillCamModule : IDisposable
	{
		private ActorHolder actorHolder_;

		private Transform killCamBack_;

		private KillCamHud hud_;

		private MyPlayerStatsModel myPlayerManager_;

		private PlayerModelsHolder playerModelsHolder_;

		private Camera camera_;

		private int layer_;

		private WindowsManager windowsManager_;

		public KillCamModule(int layer = 17, int cameraMask = 131072)
		{
			layer_ = layer;
			GameObject gameObject = new GameObject("KillCamCamera");
			camera_ = gameObject.AddComponent<Camera>();
			camera_.depth = 20f;
			camera_.cullingMask = cameraMask;
			camera_.clearFlags = CameraClearFlags.Depth;
			NetworkShopManager singlton;
			SingletonManager.Get<NetworkShopManager>(out singlton);
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			PrefabsManager singlton2;
			SingletonManager.Get<PrefabsManager>(out singlton2);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
			SingletonManager.Get<PlayerModelsHolder>(out playerModelsHolder_);
			HudStateSwitcher singlton3;
			SingletonManager.Get<HudStateSwitcher>(out singlton3);
			singlton2.Load("KillCamPrefabHolder");
			hud_ = GuiModuleHolder.Add<KillCamHud>();
			hud_.BuyButtonPressed += singlton.BuyArtikul;
			killCamBack_ = singlton2.InstantiateIn<Transform>("KillCamBack", camera_.transform);
			GameObjectUtils.SetLayerRecursive(killCamBack_.gameObject, layer_);
			singlton3.Register(1048576, camera_.gameObject);
			windowsManager_.WindowsCountChanged += HandleWindowsCountChanged;
			HandleWindowsCountChanged();
		}

		private void HandleWindowsCountChanged()
		{
			camera_.enabled = !windowsManager_.AnyWindowIsOpen;
		}

		public void Dispose()
		{
			if (actorHolder_ != null)
			{
				actorHolder_.Dispose();
			}
			UnityEngine.Object.Destroy(killCamBack_.gameObject);
			UnityEngine.Object.Destroy(camera_.gameObject);
			GuiModuleHolder.Remove(hud_);
			windowsManager_.WindowsCountChanged -= HandleWindowsCountChanged;
		}

		private void SetKiller(string killerNick, int killerLevel, int artikulId, int playerLevel)
		{
			hud_.SetDetails(KillCamType.Killer, killerNick, killerLevel, artikulId);
			hud_.SetRecommendedToBuy(playerLevel);
			killCamBack_.gameObject.transform.localPosition = new Vector3(0.051f, -2.634f, 7.578f);
			killCamBack_.gameObject.transform.localEulerAngles = new Vector3(-4.94f, -44.69f, 6.97f);
			killCamBack_.gameObject.SetActive(true);
			camera_.gameObject.SetActive(true);
		}

		private void SetSuicide()
		{
			hud_.SetDetails(KillCamType.Suicide, string.Empty, 0, 0);
			hud_.DisableRecommended();
			killCamBack_.gameObject.SetActive(false);
			camera_.gameObject.SetActive(false);
		}

		private void SetEmpty()
		{
			hud_.SetDetails(KillCamType.Empty, string.Empty, 0, 0);
			hud_.DisableRecommended();
			killCamBack_.gameObject.SetActive(false);
			camera_.gameObject.SetActive(false);
		}

		public void Hide()
		{
			SetEmpty();
			if (actorHolder_ != null)
			{
				actorHolder_.Dispose();
			}
		}

		public void SetDead(string killerPersId, bool isSuicide, bool isEmpty)
		{
			PlayerStatsModel value;
			if (isEmpty)
			{
				SetEmpty();
			}
			else if (isSuicide || killerPersId == null)
			{
				SetSuicide();
			}
			else if (playerModelsHolder_.Models.TryGetValue(killerPersId, out value))
			{
				PlayerStatsModel playerStatsModel = PlayerStatsModel.Clone(value);
				playerStatsModel.SetPosition(new Vector3(0f, -1.45f, 7.49f), new Vector3(3.92f, 176.43f, -0.65f));
				playerStatsModel.IsDummy = true;
				actorHolder_ = new ActorHolder();
				actorHolder_.AddActor(playerStatsModel, false, 1.3f);
				actorHolder_.PlaymateEntity.Controller.BodyViewUpdated += HandleBodyViewUpdated;
				SetKiller(value.nickname, value.experiance.level, playerStatsModel.SelectedArtikul, myPlayerManager_.stats.experiance.level);
			}
		}

		private void HandleBodyViewUpdated()
		{
			Transform transform = actorHolder_.PlaymateEntity.Model.visual.Transform;
			transform.SetParent(camera_.transform, false);
			GameObjectUtils.SetLayerRecursive(transform.gameObject, layer_);
		}
	}
}

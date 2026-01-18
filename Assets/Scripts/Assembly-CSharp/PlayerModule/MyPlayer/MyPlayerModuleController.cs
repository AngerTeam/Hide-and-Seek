using System;
using Animations;
using ArticulView;
using CraftyEngine;
using CraftyEngine.Content;
using Extensions;
using FxModule;
using InventoryModule;
using MyPlayerInput;
using PlayerModule.Playmate;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerModuleController : PermanentSingleton
	{
		private MyPlayerStatsModel model_;

		private InventoryModel inventoryModel_;

		private MyPlayerEntity entity_;

		private MyPlayerInputModel inputModel_;

		public PlaymateEntity PlaymateEntity { get; private set; }

		public event Action ContactHappened;

		public event Action Fallen;

		public event Action<int> ActionChanged;

		public event Action<string> ProjectileHitHappened;

		public override void Dispose()
		{
			inputModel_.Jumped -= HandleJumped;
			if (entity_ != null)
			{
				entity_.Dispose();
			}
			if (PlaymateEntity != null)
			{
				PlaymateEntity.Dispose();
			}
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerInputModel>(out inputModel_);
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
		}

		public void ResetPlayerPosition(Vector3 position, Vector3 rotation, bool teleport = false)
		{
			entity_.Controller.ResetPosition(position, rotation, teleport);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<PlayerContentMap>();
			ContentDeserializer.Deserialize<ArticulViewContentMap>();
			ContentDeserializer.Deserialize<FxContentMap>();
			model_.stats.HealthMax = PlayerContentMap.PlayerEntity.defaultHealth;
			model_.stats.IsMyPlayer = true;
			model_.stats.Reset();
			model_.stats.PositionUpdated += HandlePositionUpdated;
			inputModel_.Jumped += HandleJumped;
			entity_ = new MyPlayerEntity();
			entity_.Controller.ActionsHandler.ContactHappened += HandleContactHappened;
			entity_.Controller.ActionsHandler.ActionChanged += delegate(int action)
			{
				this.ActionChanged.SafeInvoke(action);
			};
			entity_.Controller.Fallen += delegate
			{
				this.Fallen.SafeInvoke();
			};
			entity_.Controller.ProjectileHitHappened += delegate(string targetPersId)
			{
				this.ProjectileHitHappened.SafeInvoke(targetPersId);
			};
			PlaymateEntity = new PlaymateEntity(model_.stats, true, true);
			PlaymateEntity.Controller.AllowInterpolate(false);
			inventoryModel_.SelectedSlotChanged += HandleActiveSlotChanged;
			MyPlayerInputMobule.InitHud();
		}

		private void HandleContactHappened()
		{
			this.ContactHappened.SafeInvoke();
		}

		private void HandleJumped()
		{
			model_.stats.visual.jumpPending = true;
		}

		private void HandleActiveSlotChanged()
		{
			model_.stats.SelectedArtikul = inventoryModel_.SelectedSlot.ArtikulId;
		}

		private void HandlePositionUpdated(bool interpolate)
		{
			if (interpolate)
			{
				return;
			}
			try
			{
				if (entity_.Controller.inputMobule != null)
				{
					entity_.Controller.inputMobule.Reset();
				}
			}
			catch
			{
			}
		}

		public override void OnSyncRecieved()
		{
			entity_.Controller.AddUi();
		}

		public static void InitModel(int layer)
		{
			SingletonManager.Add<MyPlayerStatsModel>(layer);
			AdjustableSettings.Register<GameSettings>();
		}

		public static void InitModule(int layer)
		{
			SingletonManager.Add<PlayerBodyManager>(layer);
			SingletonManager.Add<AnimatonsCacheHolder>(layer);
			SingletonManager.Add<MyPlayerModuleController>(layer);
			SingletonManager.Add<LoadArtikulModelManager>(layer);
			SingletonManager.Add<AnimationsFileManager>(layer);
			SingletonManager.Add<PlaymatePositionManager>(layer);
		}
	}
}

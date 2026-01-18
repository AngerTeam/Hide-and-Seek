using System;
using CraftyEngine.Utils;
using CraftyVoxelEngine;
using CraftyVoxelEngine.FX;
using Extensions;
using HudSystem;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace HideAndSeek
{
	public class HideAndSeekMyPlayerView : Singleton
	{
		private CastBarHud castBarHud_;

		private HideCastVoxelView hideCastVoxelView_;

		private UnityTimer hidingCastTimer_;

		private UnityTimer hidingVoxelDestroyTimer_;

		private MyPlayerStatsModel player_;

		private UnityTimerManager unityTimerManager_;

		private VoxelControllerManager voxelControllerManager_;

		private VoxelInteractionEffects effects_;

		public event Action HideCastSucceeded;

		public void CancelTimer()
		{
			if (hidingCastTimer_ != null)
			{
				hidingCastTimer_.Completeted -= HandleHideCastSucceeded;
				hidingCastTimer_.Stop();
				hidingCastTimer_ = null;
			}
			castBarHud_.ShowCast(false, 0f);
		}

		public void DestroyHideCastVoxel()
		{
			if (hideCastVoxelView_ != null)
			{
				hideCastVoxelView_.Dispose();
				hideCastVoxelView_ = null;
			}
			if (hidingVoxelDestroyTimer_ != null)
			{
				hidingVoxelDestroyTimer_.Completeted -= DestroyHideCastVoxel;
				hidingVoxelDestroyTimer_.Stop();
				hidingVoxelDestroyTimer_ = null;
			}
		}

		public override void Dispose()
		{
			GuiModuleHolder.Remove(castBarHud_);
			ClearHiderFx();
		}

		public override void Init()
		{
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out player_);
			SingletonManager.Get<VoxelControllerManager>(out voxelControllerManager_);
			SingletonManager.Get<VoxelInteractionEffects>(out effects_);
			castBarHud_ = GuiModuleHolder.Add<CastBarHud>();
			voxelControllerManager_.VoxelViewManager.ChunkRenderedUnityEvent += OnChunkRendered;
		}

		public void SetHiderFx()
		{
			if (player_.stats.hideAndSeek.IsHidden)
			{
				effects_.voxelCursor.SetRainbowCursor(player_.stats.hideAndSeek.HidePosition);
			}
		}

		public void StartCast(VoxelKey key)
		{
			float hideCastTime = HideAndSeekContentMap.HideSeekSettings.hideCastTime;
			DestroyHideCastVoxel();
			Vector3 position = key.ToVector() + Vector3.one * 0.5f;
			hideCastVoxelView_ = new HideCastVoxelView((ushort)player_.stats.hideAndSeek.HideVoxelId, position, hideCastTime + 1f);
			hidingCastTimer_ = unityTimerManager_.SetTimer(hideCastTime);
			hidingCastTimer_.Completeted += HandleHideCastSucceeded;
			hidingVoxelDestroyTimer_ = unityTimerManager_.SetTimer(hideCastTime + 5f);
			hidingVoxelDestroyTimer_.Completeted += DestroyHideCastVoxel;
			castBarHud_.ShowCast(true, hideCastTime);
		}

		private void HandleHideCastSucceeded()
		{
			castBarHud_.ShowCast(false, 0f);
			this.HideCastSucceeded.SafeInvoke();
		}

		private void OnChunkRendered(VoxelKey key)
		{
			if (hideCastVoxelView_ != null && player_.stats.hideAndSeek.IsHidden)
			{
				DestroyHideCastVoxel();
			}
		}

		public void ClearHiderFx()
		{
			effects_.voxelCursor.HideRainbowCursor();
		}
	}
}

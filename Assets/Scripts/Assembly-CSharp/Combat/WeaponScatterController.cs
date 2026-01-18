using System;
using InventoryModule;
using MyPlayerInput;
using PlayerCameraModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace Combat
{
	public class WeaponScatterController : IDisposable
	{
		private readonly MyPlayerStatsModel myPlayerStatsModel_;

		private readonly PlayerCameraManager cameraManager_;

		private ArtikulsEntries artikul_;

		private float shotScatter_;

		private float moveScatter_;

		private float lastShotMoment_;

		private float MaxScatterAngle
		{
			get
			{
				float num = artikul_.scatter_first_angle + artikul_.scatter_max_angle + artikul_.scatter_running_angle;
				return (!myPlayerStatsModel_.stats.Aiming) ? num : (num * artikul_.scatter_aim_ratio);
			}
		}

		private float MinScatterAngle
		{
			get
			{
				return (!myPlayerStatsModel_.stats.Aiming) ? artikul_.scatter_first_angle : (artikul_.scatter_first_angle * artikul_.scatter_aim_ratio);
			}
		}

		public WeaponScatterController()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			myPlayerStatsModel_.stats.SelectedArtikulChanged += HandleSelectedArtikulChanged;
			myPlayerStatsModel_.stats.ActionChanged += HandleActionChanged;
			myPlayerStatsModel_.stats.AimingChanged += HandleAimingChanged;
			HandleSelectedArtikulChanged(myPlayerStatsModel_.stats.SelectedArtikul);
		}

		public void Dispose()
		{
			myPlayerStatsModel_.stats.SelectedArtikulChanged -= HandleSelectedArtikulChanged;
			myPlayerStatsModel_.stats.ActionChanged -= HandleActionChanged;
			myPlayerStatsModel_.stats.AimingChanged -= HandleAimingChanged;
		}

		public void Update()
		{
			if (artikul_ == null)
			{
				myPlayerStatsModel_.stats.WeaponScatter = 0f;
				return;
			}
			if (Time.time > lastShotMoment_ + artikul_.scatter_dec_pause)
			{
				shotScatter_ = Mathf.MoveTowards(shotScatter_, 0f, Time.deltaTime * artikul_.scatter_dec_speed);
			}
			float num = CalcMoveScatter();
			float num2 = ((!(num > moveScatter_)) ? artikul_.scatter_dec_speed : MyPlayerInputContentMap.PlayerSettings.scatterRunningIncSpeed);
			moveScatter_ = Mathf.MoveTowards(moveScatter_, num, Time.deltaTime * num2);
			myPlayerStatsModel_.stats.WeaponScatter = ClampScatter(MinScatterAngle + moveScatter_ + shotScatter_);
			shotScatter_ = myPlayerStatsModel_.stats.WeaponScatter - MinScatterAngle - moveScatter_;
			if (Time.time > lastShotMoment_ + MyPlayerInputContentMap.PlayerSettings.recoilDecPause || cameraManager_.InputModel.recoilOffset > artikul_.weapon_recoil_max)
			{
				float num3 = ((!(cameraManager_.InputModel.recoilOffset > artikul_.weapon_recoil_max)) ? MyPlayerInputContentMap.PlayerSettings.recoilDecSpeed : (MyPlayerInputContentMap.PlayerSettings.recoilDecSpeed * 2f));
				cameraManager_.InputModel.recoilOffset = Mathf.MoveTowards(cameraManager_.InputModel.recoilOffset, 0f, Time.deltaTime * num3);
			}
		}

		private void HandleShot()
		{
			shotScatter_ += artikul_.scatter_inc_step;
			if (shotScatter_ > artikul_.scatter_max_angle)
			{
				shotScatter_ = artikul_.scatter_max_angle;
			}
			cameraManager_.InputModel.recoilOffset += artikul_.weapon_recoil_force;
			lastShotMoment_ = Time.time;
		}

		private float CalcMoveScatter()
		{
			float t = Mathf.Clamp01(myPlayerStatsModel_.input.speed / 5f);
			if (myPlayerStatsModel_.input.jumping)
			{
				t = 1f;
			}
			return Mathf.Lerp(0f, artikul_.scatter_running_angle, t);
		}

		private float ClampScatter(float value)
		{
			return Mathf.Clamp(value, MinScatterAngle, MaxScatterAngle);
		}

		private void HandleSelectedArtikulChanged(int artikulId)
		{
			artikul_ = InventoryModuleController.GetArticul(artikulId);
			myPlayerStatsModel_.stats.WeaponScatter = MinScatterAngle;
			shotScatter_ = 0f;
			moveScatter_ = 0f;
			lastShotMoment_ = 0f;
		}

		private void HandleActionChanged()
		{
			int action = myPlayerStatsModel_.stats.action;
			if (action == 1 || action == 2)
			{
				HandleShot();
			}
		}

		private void HandleAimingChanged(bool aiming)
		{
			myPlayerStatsModel_.stats.WeaponScatter = MinScatterAngle;
		}
	}
}

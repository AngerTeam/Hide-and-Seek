using System;
using Extensions;
using MyPlayerInput;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	[Serializable]
	public class MyPlayerStatsModel : Singleton
	{
		public bool Enable;

		public float hudItemCooldown;

		public MyPlayerMoneyModel money;

		public MyPlayerVisibilityModel myVisibility;

		public PlayerStatsModel stats;

		public float speedBoost;

		public MyPlayerInputModel input;

		[SerializeField]
		private int uiAction_;

		public int UiAction
		{
			get
			{
				return uiAction_;
			}
			set
			{
				if (uiAction_ != value)
				{
					uiAction_ = value;
					this.UiActionChanged.SafeInvoke(uiAction_);
				}
			}
		}

		public event Action MovedShiftDistance;

		public event Action<int> UiActionChanged;

		public MyPlayerStatsModel()
		{
			money = new MyPlayerMoneyModel();
			stats = new PlayerStatsModel();
			myVisibility = new MyPlayerVisibilityModel(stats.visibility);
			myVisibility.VisibleByCameraMode = true;
			stats.resultVisibility = myVisibility;
			Reset();
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerInputModel>(out input);
		}

		public void ReportMovedShiftDistance()
		{
			this.MovedShiftDistance.SafeInvoke();
		}

		private void Reset()
		{
			myVisibility.Reset();
			stats.visibility.Reset();
			stats.Reset();
			stats.BodyType = BodyType.DEFAULT;
			stats.SetSide(0, true);
			speedBoost = 0f;
			stats.allowSpawnReport = false;
			stats.allowArtikulChange = true;
			stats.AllowAttack = true;
		}

		public override void OnReset()
		{
			Reset();
		}
	}
}

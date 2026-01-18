using System;
using System.Globalization;
using CraftyEngine.Infrastructure;
using NguiTools;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerNicknameAndHealthView : IDisposable
	{
		private readonly string blueColor_ = "00CBFFFF";

		private readonly string redColor_ = "FF3636FF";

		private readonly string yellowColor_ = "FBFB00FF";

		private GameObject anchor_;

		private NicknameHierarchy hierarchy_;

		private PlayerStatsModel model_;

		private UnityEvent unityEvent_;

		private GameModel gameModel_;

		private bool visibleByRole_;

		private bool visibleByAction_;

		private bool visibleByPosition_;

		public PlayerNicknameAndHealthView(PlayerStatsModel model)
		{
			SingletonManager.Get<GameModel>(out gameModel_);
			if (!model.IsDummy && !model.IsMyPlayer)
			{
				model_ = model;
				model_.visibility.VisibleChanged += ResetVisible;
				model_.HealthChanged += HandleHealthChanged;
				model_.Died += HandleModelDied;
				model_.Ressurected += HandleModelDied;
				model_.SideChanged += HandleSideChanged;
				anchor_ = new GameObject("NickNameHolder");
				SingletonManager.Get<UnityEvent>(out unityEvent_);
				unityEvent_.Subscribe(UnityEventType.Update, Update);
				model_.combat.attackedMyPlayerMoment = float.MinValue;
				visibleByRole_ = model_.InMyPlayerTeam;
				visibleByAction_ = false;
				InitNickname();
				HandleSideChanged();
			}
		}

		private void HandleSideChanged()
		{
			visibleByRole_ = model_.InMyPlayerTeam;
			ColorizeNickname(model_.nickname, model_.experiance.level, model_.InMyPlayerTeam);
			ResetVisible();
		}

		private void HandleModelDied()
		{
			UpdateHealth();
		}

		public void Dispose()
		{
			if (model_ != null)
			{
				if (unityEvent_ != null)
				{
					unityEvent_.Unsubscribe(UnityEventType.Update, Update);
				}
				model_.visibility.VisibleChanged -= ResetVisible;
				UnityEngine.Object.Destroy(anchor_);
				hierarchy_.followTarget.onChange -= UpdateAnchorVisiblity;
				UnityEngine.Object.Destroy(hierarchy_.gameObject);
			}
		}

		public void SetAnchor(Transform anchor, float height)
		{
			if (model_ != null && !(anchor_ == null) && !(anchor_.transform == null))
			{
				anchor_.transform.SetParent(anchor, false);
				anchor_.transform.localPosition = Vector3.up * height;
			}
		}

		private void ColorizeNickname(string nickname, int level, bool isInMyPlayersTeam)
		{
			Log.Info("ColorizeNickname {0} {1}", nickname, !isInMyPlayersTeam);
			hierarchy_.healthSlider.alpha = ((!isInMyPlayersTeam) ? 1 : 0);
			string text = ((level <= 0 || model_.IsMob) ? string.Format("[{0}]{1}[-]", (!isInMyPlayersTeam) ? redColor_ : blueColor_, nickname) : string.Format("[{0}]{1}[-] [{2}]({3})[-]", (!isInMyPlayersTeam) ? redColor_ : blueColor_, nickname, yellowColor_, level));
			hierarchy_.nicknameLabel.text = text;
			hierarchy_.name = string.Format("{0} {1}", "UINickname", text);
		}

		private void HandleHealthChanged(int arg1, int arg2, string arg3)
		{
			UpdateHealth();
		}

		private void InitNickname()
		{
			CameraManager singlton;
			SingletonManager.Get<CameraManager>(out singlton);
			NguiManager singlton2;
			SingletonManager.Get<NguiManager>(out singlton2);
			PrefabsManagerNGUI singlton3;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton3);
			singlton3.Load("PlayerUiPrefabHolder");
			hierarchy_ = singlton3.InstantiateNGUIIn<NicknameHierarchy>("UINickname", singlton2.UiRoot.gameObject);
			hierarchy_.followTarget.uiCamera = singlton2.UiRoot.UICamera;
			hierarchy_.followTarget.gameCamera = singlton.PlayerCamera;
			hierarchy_.followTarget.target = anchor_.transform;
			hierarchy_.followTarget.onChange += UpdateAnchorVisiblity;
		}

		private void ResetVisible()
		{
			bool flag = model_.visibility.Visible && (visibleByRole_ || visibleByAction_) && visibleByPosition_;
			hierarchy_.widget.alpha = (flag ? 1 : 0);
			UpdateHealth();
		}

		private void Update()
		{
			float num = model_.combat.attackedMyPlayerMoment + (float)PlayerContentMap.PlayerEntity.pvpHpVisibleTime;
			bool flag = (gameModel_.showEnemyNickname || model_.IsMob) && Time.time < num;
			if (flag != visibleByAction_)
			{
				visibleByAction_ = flag;
				ResetVisible();
			}
		}

		private void UpdateHealth()
		{
			hierarchy_.healthLabel.text = model_.HealthCurrent.ToString(CultureInfo.InvariantCulture);
			hierarchy_.healthSlider.value = (float)model_.HealthCurrent / (float)model_.HealthMax;
		}

		private void UpdateAnchorVisiblity(bool isVisible)
		{
			visibleByPosition_ = isVisible;
			ResetVisible();
		}
	}
}

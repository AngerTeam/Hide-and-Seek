using System;
using CraftyEngine.Infrastructure;
using Extensions;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace ChestsViewModule
{
	public class ChestRewardInformer
	{
		private Transform chestTransform_;

		private GameObject anchor_;

		private ChestInformerHierarchy hierarchy_;

		public event Action InformerClicked;

		public event Action<string> AnimateChest;

		public void SetShape(Transform chestTransform)
		{
			chestTransform_ = chestTransform;
			anchor_ = new GameObject("InformerHolder");
			anchor_.transform.SetParent(chestTransform_, false);
			anchor_.transform.position += Vector3.up * 1.4f;
			InitHierarchy();
		}

		private void InitHierarchy()
		{
			CameraManager singlton;
			SingletonManager.Get<CameraManager>(out singlton);
			NguiManager singlton2;
			SingletonManager.Get<NguiManager>(out singlton2);
			PrefabsManagerNGUI singlton3;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton3);
			singlton3.Load("ChestsPrefabsHolder");
			hierarchy_ = singlton3.InstantiateNGUIIn<ChestInformerHierarchy>("UIChestInformer", singlton2.UiRoot.gameObject);
			hierarchy_.followTarget.uiCamera = singlton2.UiRoot.UICamera;
			hierarchy_.followTarget.gameCamera = singlton.PlayerCamera;
			hierarchy_.followTarget.target = anchor_.transform;
			ButtonSet.Up(hierarchy_.button, this.InformerClicked.SafeInvoke, ButtonSetGroup.Hud);
		}

		public void UpdateState(InformerStateType stateType, string timeLeft)
		{
			if (!(hierarchy_ == null))
			{
				hierarchy_.timeLeftLabel.gameObject.SetActive(false);
				string param = string.Empty;
				switch (stateType)
				{
				case InformerStateType.Idle:
					param = "chest_idle";
					hierarchy_.statusLabel.text = Localisations.Get("UI_Rewards");
					break;
				case InformerStateType.FreeGems:
					param = "chest_impatience";
					hierarchy_.statusLabel.text = Localisations.Get("UI_Free_Crystals");
					break;
				case InformerStateType.InProgress:
					param = "chest_idle";
					hierarchy_.statusLabel.text = Localisations.Get("UI_Reward_In");
					hierarchy_.timeLeftLabel.text = timeLeft;
					hierarchy_.timeLeftLabel.gameObject.SetActive(true);
					break;
				case InformerStateType.TakeRewards:
					param = "chest_impatience_hard";
					hierarchy_.statusLabel.text = Localisations.Get("UI_Get_Rewards");
					break;
				case InformerStateType.StartNow:
					param = "chest_impatience_hard";
					hierarchy_.statusLabel.text = Localisations.Get("UI_Unlock_Chest");
					break;
				}
				hierarchy_.table.Reposition();
				this.AnimateChest.SafeInvoke(param);
			}
		}

		public void Clear()
		{
			if (anchor_ != null)
			{
				UnityEngine.Object.Destroy(anchor_);
			}
			if (hierarchy_ != null)
			{
				UnityEngine.Object.Destroy(hierarchy_.gameObject);
			}
		}
	}
}

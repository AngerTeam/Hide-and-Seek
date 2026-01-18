using HudSystem;
using MoneyModule;
using NguiTools;
using PlayerModule.MyPlayer;
using UnityEngine;
using WindowsModule;

namespace BankModule
{
	public class CrystalsWidget : GuiModlule
	{
		private CrystalWidgetHierarchy crystalWidgetHierarchy_;

		private MyPlayerStatsModel model_;

		public CrystalsWidget()
		{
			NguiManager nguiManager = SingletonManager.Get<NguiManager>();
			Build(nguiManager.UiRoot.TopRightSecondContainer.gameObject, ButtonSetGroup.PlayerInfo);
		}

		public override void Dispose()
		{
			model_.money.MoneyAmountUpdated -= HandleMoneyAmountUpdated;
			Object.Destroy(crystalWidgetHierarchy_.gameObject);
		}

		private void Build(GameObject parent, ButtonSetGroup group)
		{
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			singlton.Load("BankPrefabsHolder");
			crystalWidgetHierarchy_ = singlton.InstantiateNGUIIn<CrystalWidgetHierarchy>("UICrystalWidget", parent);
			ButtonSet.Up(crystalWidgetHierarchy_.button, HandleBankClick, group);
			model_.money.MoneyAmountUpdated += HandleMoneyAmountUpdated;
			UpdateCrystalWidget();
			HudStateSwitcher hudStateSwitcher = SingletonManager.Get<HudStateSwitcher>();
			hudStateSwitcher.Register(32, crystalWidgetHierarchy_);
		}

		public void EnableBuyButton(bool value)
		{
			crystalWidgetHierarchy_.buttonWidget.gameObject.SetActive(value);
		}

		private void HandleBankClick()
		{
			if (crystalWidgetHierarchy_.buttonWidget.gameObject.activeSelf)
			{
				WindowsManagerShortcut.ToggleWindow<BankWindow>();
			}
		}

		private void HandleMoneyAmountUpdated(int moneyType)
		{
			if (moneyType == MoneyTypesEntries.crystalId)
			{
				UpdateCrystalWidget();
			}
		}

		private void UpdateCrystalWidget()
		{
			crystalWidgetHierarchy_.crystalLabel.text = model_.money.CrystalsAmount.ToString();
		}
	}
}

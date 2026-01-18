using System;
using Extensions;
using HudSystem;
using MyNicknameModule;
using PlayerModule.MyPlayer;
using SpecialOffersModule;
using UnityEngine;

namespace HomeLobby
{
	public class LobbyHud : HeadUpDisplay
	{
		private LobbyPanelHierarchy lobbyPanel_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private MyNicknameManager myNicknameManager_;

		private SpecialOfferWidgetController specialOfferWidgetController_;

		private UiRoller roller_;

		public event Action ToArsenalButtonClicked;

		public event Action ToPvpButtonClicked;

		public LobbyHud()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<MyNicknameManager>(out myNicknameManager_);
			prefabsManager.Load("HNSLobbyNGUIPrefabsHolder");
			lobbyPanel_ = prefabsManager.InstantiateIn<LobbyPanelHierarchy>("UILobbyPanel", nguiManager.UiRoot.transform);
			lobbyPanel_.lobbyPanel.depth = 100;
			lobbyPanel_.container.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			SetupStateButtons();
			SetupNickname();
			specialOfferWidgetController_ = new SpecialOfferWidgetController(lobbyPanel_.specialOfferWidget.gameObject);
			myNicknameManager_.OnNicknameChanged += UpdatePlayerNicknameWidget;
			roller_ = new UiRoller(lobbyPanel_.rollerContainer);
			roller_.Widget.gameObject.SetActive(false);
		}

		private void SetupNickname()
		{
			ButtonSet.Up(lobbyPanel_.changeNicknameButton, ChangeNicknameClicked, ButtonSetGroup.Hud);
			hudStateSwitcher.Register(16384, lobbyPanel_.changeNicknameButton);
			hudStateSwitcher.Register(16384, lobbyPanel_.nameLabel);
			UpdatePlayerNicknameWidget();
		}

		private void ChangeNicknameClicked()
		{
			NicknameWindow nicknameWindow = GuiModuleHolder.Get<NicknameWindow>();
			nicknameWindow.OpenWindow(true);
		}

		private void SetupStateButtons()
		{
			SetButtonText(lobbyPanel_.pvpButton, Localisations.Get("UI_lobby_PvpButton"));
			hudStateSwitcher.Register(2048, lobbyPanel_.pvpButton);
			SetButtonText(lobbyPanel_.arsenalButton, Localisations.Get("UI_Arsenal"));
			hudStateSwitcher.Register(1024, lobbyPanel_.arsenalButton);
			hudStateSwitcher.Register(4194304, lobbyPanel_.rollerContainer);
			ButtonSet.Up(lobbyPanel_.pvpButton, ReportPvpClicked, ButtonSetGroup.Hud);
			ButtonSet.Up(lobbyPanel_.arsenalButton, ReportArsenalClicked, ButtonSetGroup.Hud);
			ButtonSet.Up(lobbyPanel_.nameWidget, ButtonSetGroup.Hud);
		}

		private void SetButtonText(UIButton button, string text)
		{
			UILabel componentInChildren = button.gameObject.GetComponentInChildren<UILabel>();
			componentInChildren.text = text;
		}

		private void UpdatePlayerNicknameWidget(string nickname)
		{
			bool flag = !string.IsNullOrEmpty(nickname);
			lobbyPanel_.nameLabel.text = nickname;
			lobbyPanel_.changeNicknameButton.enabled = flag;
			lobbyPanel_.nameWidget.gameObject.SetActive(flag);
		}

		private void UpdatePlayerNicknameWidget()
		{
			UpdatePlayerNicknameWidget(myPlayerStatsModel_.stats.nickname);
		}

		private void ReportArsenalClicked()
		{
			this.ToArsenalButtonClicked.SafeInvoke();
		}

		private void ReportPvpClicked()
		{
			this.ToPvpButtonClicked.SafeInvoke();
		}

		public override void Dispose()
		{
			specialOfferWidgetController_.Dispose();
			this.ToArsenalButtonClicked = null;
			this.ToPvpButtonClicked = null;
			myNicknameManager_.OnNicknameChanged -= UpdatePlayerNicknameWidget;
			if (lobbyPanel_ != null)
			{
				UnityEngine.Object.Destroy(lobbyPanel_.gameObject);
			}
		}
	}
}

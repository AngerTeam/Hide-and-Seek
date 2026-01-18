using FriendsModule;
using FriendsModule.RemoteData;
using HudSystem;
using UnityEngine;
using WindowsModule;

public class SearchPlayerSubWindow : GameSubwindow
{
	private const int MIN_CHARACTERS = 3;

	private FriendsModel model_;

	private SearchPlayerSubWindowHierarchy windowHierarchy_;

	private FriendsController friendsController_;

	private SearchPlayerItemHierarchy[] items_;

	public SearchPlayerSubWindow()
	{
		windowHierarchy_ = prefabsManager_.InstantiateNGUIIn<SearchPlayerSubWindowHierarchy>("UISearchPlayerSubWindow", nguiManager_.UiRoot.gameObject);
		SingletonManager.Get<FriendsController>(out friendsController_);
		SingletonManager.Get<FriendsModel>(out model_);
		windowHierarchy_.Find.Label.text = Localisations.Get("UI_Button_Find");
		windowHierarchy_.SearchLabel.text = Localisations.Get("UI_Find_Friends") + " :";
		windowHierarchy_.InfoContainer.Label.text = Localisations.Get("UI_Message_Help_Find_Player");
		windowHierarchy_.NameInput.defaultText = Localisations.Get("UI_Enter_Nickname");
		windowHierarchy_.Find.Roller = new UiRoller(windowHierarchy_.Find.RollerWidget);
		ButtonSet.Up(windowHierarchy_.ButtonInfo, windowHierarchy_.InfoContainer.Switch, ButtonSetGroup.InWindow);
		ButtonSet.Up(windowHierarchy_.Find.Button, HandleSearchButton, ButtonSetGroup.InWindow);
		EventDelegate.Set(windowHierarchy_.NameInput.onChange, HandleChangeValueInput);
		container = windowHierarchy_.gameObject;
	}

	public override void Init()
	{
		base.Init();
		FillFields();
		friendsController_.ActionComplete += HandleActionComplete;
	}

	public override void Clear()
	{
		base.Clear();
		ClearFields();
		friendsController_.ActionComplete -= HandleActionComplete;
	}

	public override void Show()
	{
		base.Show();
		if (items_ != null)
		{
			for (int i = 0; i < items_.Length; i++)
			{
				items_[i].ShowActor();
			}
		}
	}

	public override void Hide()
	{
		base.Hide();
		if (items_ != null)
		{
			for (int i = 0; i < items_.Length; i++)
			{
				items_[i].HideActor();
			}
		}
	}

	public void Update()
	{
		if (items_ == null)
		{
			Init();
			return;
		}
		if (model_.players == null)
		{
			Init();
			return;
		}
		if (model_.players.Length != items_.Length)
		{
			Init();
			return;
		}
		for (int i = 0; i < model_.players.Length; i++)
		{
			string persId = model_.players[i].persId;
			if (friendsController_.Self(persId))
			{
				items_[i].AddFriend.gameObject.SetActive(false);
				items_[i].StatusLabel.gameObject.SetActive(false);
				continue;
			}
			bool flag = friendsController_.FriendExist(persId);
			bool flag2 = friendsController_.InputExist(persId);
			bool flag3 = friendsController_.OutputExist(persId);
			items_[i].AddFriend.Button.gameObject.SetActive(!flag && !flag2 && !flag3);
			items_[i].StatusLabel.gameObject.SetActive(flag3);
		}
	}

	public void HideInfoPopup()
	{
		windowHierarchy_.InfoContainer.Hide();
	}

	private void FillFields()
	{
		ClearFields();
		if (model_ == null || model_.players == null)
		{
			return;
		}
		if (model_.players.Length == 0)
		{
			windowHierarchy_.NotFoundContainer.gameObject.SetActive(true);
			windowHierarchy_.NotFoundLabel.text = Localisations.Get("PlayerSearch_NoFound");
		}
		items_ = new SearchPlayerItemHierarchy[model_.players.Length];
		for (int i = 0; i < model_.players.Length; i++)
		{
			FindPlayerMessage findPlayerMessage = model_.players[i];
			int userId = findPlayerMessage.userId;
			string persId = findPlayerMessage.persId;
			items_[i] = prefabsManager_.InstantiateNGUIIn<SearchPlayerItemHierarchy>("UISearchPlayerItem", windowHierarchy_.Grid.gameObject);
			items_[i].gameObject.AddComponent<UIDragScrollView>().scrollView = windowHierarchy_.ScrollView;
			items_[i].NameLabel.text = findPlayerMessage.name;
			items_[i].StatusLabel.text = Localisations.Get("UI_Message_Request_Sended");
			items_[i].AddFriend.Label.text = Localisations.Get("UI_Add_Friend");
			items_[i].AddFriend.Roller = new UiRoller(items_[i].AddFriend.RollerWidget);
			items_[i].AddFriend.Roller.Widget.gameObject.SetActive(false);
			items_[i].CreateActor();
			items_[i].SetSkin(findPlayerMessage.skinId);
			if (friendsController_.Self(persId))
			{
				items_[i].AddFriend.gameObject.SetActive(false);
				items_[i].StatusLabel.gameObject.SetActive(false);
			}
			else
			{
				bool flag = friendsController_.FriendExist(persId);
				bool flag2 = friendsController_.InputExist(persId);
				bool flag3 = friendsController_.OutputExist(persId);
				items_[i].AddFriend.Button.gameObject.SetActive(!flag && !flag2 && !flag3);
				items_[i].StatusLabel.gameObject.SetActive(flag3);
			}
			int itemIndex = i;
			ButtonSet.Up(items_[i].AddFriend.Button, delegate
			{
				HandleAddFriendButton(itemIndex, userId, persId);
			}, ButtonSetGroup.InWindow);
			ButtonSet.Up(items_[i].InfoButton, delegate
			{
				HandleShowInformationButton(persId);
			}, ButtonSetGroup.InWindow);
			windowHierarchy_.Grid.AddElement(items_[i].transform);
		}
		windowHierarchy_.Grid.Reposition();
		windowHierarchy_.Find.Button.gameObject.SetActive(windowHierarchy_.NameInput.value.Length >= 3);
	}

	private void ClearFields()
	{
		windowHierarchy_.InfoContainer.Hide(true);
		windowHierarchy_.InfoContainer.gameObject.SetActive(false);
		windowHierarchy_.Find.Button.gameObject.SetActive(false);
		windowHierarchy_.Find.RollerWidget.gameObject.SetActive(false);
		windowHierarchy_.NotFoundContainer.gameObject.SetActive(false);
		windowHierarchy_.NameInput.value = model_.lastFriendName;
		windowHierarchy_.NotFoundLabel.text = string.Empty;
		windowHierarchy_.MinCharactersLabel.text = string.Empty;
		if (items_ != null)
		{
			for (int i = 0; i < items_.Length; i++)
			{
				items_[i].DisposeActor();
				Object.Destroy(items_[i].gameObject);
			}
			items_ = null;
			windowHierarchy_.Grid.Clear();
		}
	}

	private void HandleActionComplete()
	{
		windowHierarchy_.Find.RollerWidget.gameObject.SetActive(false);
		if (items_ != null)
		{
			for (int i = 0; i < items_.Length; i++)
			{
				items_[i].AddFriend.Roller.Widget.gameObject.SetActive(false);
			}
		}
	}

	private void HandleChangeValueInput()
	{
		bool flag = windowHierarchy_.NameInput.value.Length >= 3;
		windowHierarchy_.Find.Button.gameObject.SetActive(flag);
		if (flag)
		{
			windowHierarchy_.MinCharactersLabel.text = string.Empty;
		}
		else
		{
			windowHierarchy_.MinCharactersLabel.text = Localisations.Get("UI_Message_Min_Characters");
		}
	}

	private void HandleSearchButton()
	{
		windowHierarchy_.Find.Button.gameObject.SetActive(false);
		windowHierarchy_.Find.RollerWidget.gameObject.SetActive(true);
		model_.lastFriendName = windowHierarchy_.NameInput.value;
		friendsController_.SearchPlayer(windowHierarchy_.NameInput.value);
	}

	private void HandleAddFriendButton(int itemIndex, int userId, string persId)
	{
		items_[itemIndex].AddFriend.Roller.Widget.gameObject.SetActive(true);
		items_[itemIndex].AddFriend.Button.gameObject.SetActive(false);
		friendsController_.AddFriend(userId, persId);
	}

	private void HandleShowInformationButton(string persId)
	{
		friendsController_.GetPlayerInfo(persId);
		WindowsManagerShortcut.ToggleWindow<PlayerInfoWindow>();
	}
}

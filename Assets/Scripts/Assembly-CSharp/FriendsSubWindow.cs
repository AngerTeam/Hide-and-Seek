using FriendsModule;
using FriendsModule.RemoteData;
using HudSystem;
using UnityEngine;
using WindowsModule;

public class FriendsSubWindow : GameSubwindow
{
	private FriendsModel model_;

	private FriendsController friendsController_;

	private FriendsSubWindowHierarchy windowHierarchy_;

	private FriendItemHierarchy[] items_;

	public FriendsSubWindow()
	{
		windowHierarchy_ = prefabsManager_.InstantiateNGUIIn<FriendsSubWindowHierarchy>("UIFriendsSubWindow", nguiManager_.UiRoot.gameObject);
		SingletonManager.Get<FriendsController>(out friendsController_);
		SingletonManager.Get<FriendsModel>(out model_);
		ButtonSet.Up(windowHierarchy_.ButtonInfo, windowHierarchy_.InfoContainer.Switch, ButtonSetGroup.InWindow);
		windowHierarchy_.InfoContainer.Label.text = Localisations.Get("UI_Message_Help_Friends");
		container = windowHierarchy_.gameObject;
	}

	public void HideInfoPopup()
	{
		windowHierarchy_.InfoContainer.Hide();
	}

	public override void Init()
	{
		base.Init();
		FillFields();
	}

	public override void Clear()
	{
		base.Clear();
		ClearFields();
	}

	private void FillFields()
	{
		ClearFields();
		if (model_ == null || model_.friends == null)
		{
			return;
		}
		if (model_.friends.Length == 0)
		{
			windowHierarchy_.ContainerEmpty.gameObject.SetActive(true);
			windowHierarchy_.LabelEmpty.text = Localisations.Get("UI_Message_No_Friends");
		}
		items_ = new FriendItemHierarchy[model_.friends.Length];
		for (int i = 0; i < model_.friends.Length; i++)
		{
			FriendMessage friendMessage = model_.friends[i];
			items_[i] = prefabsManager_.InstantiateNGUIIn<FriendItemHierarchy>("UIFriendItem", windowHierarchy_.Grid.gameObject);
			items_[i].gameObject.AddComponent<UIDragScrollView>().scrollView = windowHierarchy_.ScrollView;
			items_[i].NameLabel.text = friendMessage.name;
			items_[i].InstanceLabel.text = friendMessage.mapName;
			items_[i].EnterInstanceButton.gameObject.SetActive(!string.IsNullOrEmpty(friendMessage.instId));
			items_[i].CreateActor();
			items_[i].SetSkin(friendMessage.skinId);
			if (friendMessage.online == 1)
			{
				items_[i].StatusLabel.text = Localisations.Get("UI_Online");
				items_[i].StatusLabel.color = ColorUtils.HexToColor("24f404");
			}
			else
			{
				items_[i].StatusLabel.text = Localisations.Get("UI_Offline");
				items_[i].StatusLabel.color = ColorUtils.HexToColor("838383");
			}
			string persId = friendMessage.persId;
			ButtonSet.Up(items_[i].InfoButton, delegate
			{
				HandleShowInformation(persId);
			}, ButtonSetGroup.InWindow);
			windowHierarchy_.Grid.AddElement(items_[i].transform);
		}
		windowHierarchy_.Grid.Reposition();
	}

	private void ClearFields()
	{
		windowHierarchy_.InfoContainer.Hide(true);
		windowHierarchy_.InfoContainer.gameObject.SetActive(false);
		windowHierarchy_.ContainerEmpty.gameObject.SetActive(false);
		windowHierarchy_.LabelEmpty.text = string.Empty;
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

	private void HandleShowInformation(string persId)
	{
		friendsController_.GetPlayerInfo(persId);
		WindowsManagerShortcut.ToggleWindow<PlayerInfoWindow>();
	}
}

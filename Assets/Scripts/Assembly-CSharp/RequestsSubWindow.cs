using FriendsModule;
using FriendsModule.RemoteData;
using HudSystem;
using UnityEngine;
using WindowsModule;

public class RequestsSubWindow : GameSubwindow
{
	private FriendsModel model_;

	private FriendsController friendsController_;

	private RequestsSubWindowHierarchy windowHierarchy_;

	private RequestItemHierarchy[] items_;

	public RequestsSubWindow()
	{
		windowHierarchy_ = prefabsManager_.InstantiateNGUIIn<RequestsSubWindowHierarchy>("UIRequestsSubWindow", nguiManager_.UiRoot.gameObject);
		SingletonManager.Get<FriendsController>(out friendsController_);
		SingletonManager.Get<FriendsModel>(out model_);
		ButtonSet.Up(windowHierarchy_.ButtonInfo, windowHierarchy_.InfoContainer.Switch, ButtonSetGroup.InWindow);
		windowHierarchy_.InfoContainer.Label.text = Localisations.Get("UI_Message_Help_Requests");
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

	public void HideInfoPopup()
	{
		windowHierarchy_.InfoContainer.Hide();
	}

	private void FillFields()
	{
		ClearFields();
		if (model_ == null || model_.input == null)
		{
			return;
		}
		if (model_.input.Length == 0)
		{
			windowHierarchy_.ContainerEmpty.gameObject.SetActive(true);
			windowHierarchy_.LabelEmpty.text = Localisations.Get("UI_Message_No_Requests");
		}
		items_ = new RequestItemHierarchy[model_.input.Length];
		for (int i = 0; i < model_.input.Length; i++)
		{
			FriendRequestMessage friendRequestMessage = model_.input[i];
			items_[i] = prefabsManager_.InstantiateNGUIIn<RequestItemHierarchy>("UIRequestItem", windowHierarchy_.Grid.gameObject);
			items_[i].gameObject.AddComponent<UIDragScrollView>().scrollView = windowHierarchy_.ScrollView;
			items_[i].NameLabel.text = friendRequestMessage.name;
			items_[i].LevelLabel.text = friendRequestMessage.level.ToString();
			items_[i].Accept.Label.text = Localisations.Get("UI_Accept");
			items_[i].Deny.Label.text = Localisations.Get("UI_Deny");
			items_[i].CreateActor();
			items_[i].SetSkin(friendRequestMessage.skinId);
			string persId = friendRequestMessage.persId;
			int itemIndex = i;
			ButtonSet.Up(items_[i].Accept.Button, delegate
			{
				HandleAcceptButton(itemIndex, persId);
			}, ButtonSetGroup.InWindow);
			ButtonSet.Up(items_[i].Deny.Button, delegate
			{
				HandleDenyButton(itemIndex, persId);
			}, ButtonSetGroup.InWindow);
			ButtonSet.Up(items_[i].InfoButton, delegate
			{
				HandleShowInformationButton(itemIndex, persId);
			}, ButtonSetGroup.InWindow);
			items_[i].Accept.Roller = new UiRoller(items_[i].Accept.RollerWidget);
			items_[i].Accept.Roller.Widget.gameObject.SetActive(false);
			items_[i].Deny.Roller = new UiRoller(items_[i].Deny.RollerWidget);
			items_[i].Deny.Roller.Widget.gameObject.SetActive(false);
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
				items_[i].Accept.Roller.Dispose();
				items_[i].Deny.Roller.Dispose();
				Object.Destroy(items_[i].gameObject);
			}
			items_ = null;
			windowHierarchy_.Grid.Clear();
		}
	}

	private void HandleActionComplete()
	{
		if (items_ != null)
		{
			for (int i = 0; i < items_.Length; i++)
			{
				items_[i].Accept.Roller.Widget.gameObject.SetActive(false);
				items_[i].Deny.Roller.Widget.gameObject.SetActive(false);
			}
		}
	}

	private void HandleAcceptButton(int itemIndex, string persId)
	{
		items_[itemIndex].Deny.Button.gameObject.SetActive(false);
		items_[itemIndex].Accept.Button.gameObject.SetActive(false);
		items_[itemIndex].Accept.Roller.Widget.gameObject.SetActive(true);
		friendsController_.AcceptRequest(persId);
	}

	private void HandleDenyButton(int itemIndex, string persId)
	{
		items_[itemIndex].Accept.Button.gameObject.SetActive(false);
		items_[itemIndex].Deny.Button.gameObject.SetActive(false);
		items_[itemIndex].Deny.Roller.Widget.gameObject.SetActive(true);
		friendsController_.DenyRequest(persId);
	}

	private void HandleShowInformationButton(int itemIndex, string persId)
	{
		friendsController_.GetPlayerInfo(persId);
		WindowsManagerShortcut.ToggleWindow<PlayerInfoWindow>();
	}
}

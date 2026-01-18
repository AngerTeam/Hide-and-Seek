using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using FriendsModule;
using FriendsModule.RemoteData;
using HudSystem;
using UnityEngine;
using WindowsModule;

public class PlayerInfoWindow : GameWindow
{
	private FriendsModel model_;

	private PlayerInfoWindowHierarchy windowHierarchy_;

	private FriendsController friendsController_;

	private PlayerInfoWindowItemHierarchy icon_;

	private PlayerInfoWindowItemHierarchy[] items_;

	public PlayerInfoWindow()
	{
		prefabsManager.Load("FriendsModule");
		windowHierarchy_ = prefabsManager.InstantiateNGUIIn<PlayerInfoWindowHierarchy>("UIPlayerInformationWindow", nguiManager.UiRoot.gameObject);
		SingletonManager.Get<FriendsController>(out friendsController_);
		SingletonManager.Get<FriendsModel>(out model_);
		SetContent(windowHierarchy_.transform, true, true, false, false, true);
		windowHierarchy_.MapsLabel.text = Localisations.Get("UI_Battle_Table_Maps");
		windowHierarchy_.KillsLabel.text = Localisations.Get("UI_Battle_Table_Kills");
		windowHierarchy_.DateLabel.text = Localisations.Get("UI_Battle_Table_Join_Date");
		windowHierarchy_.AboutLabel.text = Localisations.Get("UI_About");
		windowHierarchy_.RequestLabel.text = Localisations.Get("UI_Message_Request_Sended");
		for (int i = 0; i < windowHierarchy_.FriendsLabels.Length; i++)
		{
			windowHierarchy_.FriendsLabels[i].text = Localisations.Get("UI_Friends");
		}
		ButtonSet.Up(windowHierarchy_.AddFriend.Button, HandleAddFriend, ButtonSetGroup.InWindow);
		windowHierarchy_.AddFriend.Roller = new UiRoller(windowHierarchy_.AddFriend.RollerWidget);
		windowHierarchy_.AddFriend.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.AddFriend.Label.text = Localisations.Get("UI_Add_Friend");
		ButtonSet.Up(windowHierarchy_.DeleteFriend.Button, HandleDeleteFriends, ButtonSetGroup.InWindow);
		windowHierarchy_.DeleteFriend.Roller = new UiRoller(windowHierarchy_.DeleteFriend.RollerWidget);
		windowHierarchy_.DeleteFriend.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.DeleteFriend.Label.text = Localisations.Get("UI_Delete_Friend");
		ButtonSet.Up(windowHierarchy_.Join.Button, HandleJoinFriend, ButtonSetGroup.InWindow);
		windowHierarchy_.Join.Roller = new UiRoller(windowHierarchy_.Join.RollerWidget);
		windowHierarchy_.Join.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.Join.Label.text = Localisations.Get("UI_Join_Instance");
		ButtonSet.Up(windowHierarchy_.Accept.Button, HandleAccept, ButtonSetGroup.InWindow);
		windowHierarchy_.Accept.Roller = new UiRoller(windowHierarchy_.Accept.RollerWidget);
		windowHierarchy_.Accept.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.Accept.Label.text = Localisations.Get("UI_Accept");
		ButtonSet.Up(windowHierarchy_.Decline.Button, HandleDecline, ButtonSetGroup.InWindow);
		windowHierarchy_.Decline.Roller = new UiRoller(windowHierarchy_.Decline.RollerWidget);
		windowHierarchy_.Decline.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.Decline.Label.text = Localisations.Get("UI_Deny");
	}

	public override void Resubscribe()
	{
		base.Resubscribe();
		base.ViewChanged += HandleViewChanged;
	}

	public override void Dispose()
	{
		base.Dispose();
		windowHierarchy_.AddFriend.Roller.Dispose();
		windowHierarchy_.DeleteFriend.Roller.Dispose();
		windowHierarchy_.Join.Roller.Dispose();
		windowHierarchy_.Accept.Roller.Dispose();
		windowHierarchy_.Decline.Roller.Dispose();
		base.ViewChanged -= HandleViewChanged;
	}

	private void FillFields()
	{
		ClearFields();
		if (model_ == null || model_.otherPlayer == null)
		{
			return;
		}
		windowHierarchy_.NameLabel.text = model_.otherPlayer.name;
		windowHierarchy_.LevelLabel.text = "[" + model_.otherPlayer.level + "]";
		if (model_.otherPlayer.online == 1)
		{
			windowHierarchy_.StatusLabel.text = Localisations.Get("UI_Online");
			windowHierarchy_.StatusLabel.color = ColorUtils.HexToColor("24f404");
		}
		else
		{
			windowHierarchy_.StatusLabel.text = Localisations.Get("UI_Offline");
			windowHierarchy_.StatusLabel.color = ColorUtils.HexToColor("838383");
		}
		windowHierarchy_.NameTable.Reposition();
		if (icon_ == null)
		{
			icon_ = prefabsManager.InstantiateNGUIIn<PlayerInfoWindowItemHierarchy>("UIPlayerInformationItem", windowHierarchy_.IcoContainer);
			icon_.CreateActor();
			icon_.SetSkin(model_.otherPlayer.skinId);
			icon_.LabelName.text = string.Empty;
		}
		windowHierarchy_.instanceContainer.SetActive(model_.otherPlayer.instanceId > 0);
		windowHierarchy_.MapsCountLabel.text = model_.otherPlayer.maps.ToString();
		windowHierarchy_.KillsCountLabel.text = model_.otherPlayer.pvpKills.ToString();
		windowHierarchy_.InstanceLabel.text = model_.otherPlayer.instanceId.ToString();
		windowHierarchy_.DescriptionLabel.text = string.Empty;
		if (windowHierarchy_.DescriptionLabel.text.Length == 0)
		{
			windowHierarchy_.InfoContainer.SetActive(false);
		}
		else
		{
			windowHierarchy_.InfoContainer.SetActive(true);
		}
		windowHierarchy_.Table.Reposition();
		DateTime dateTime = TimeUtils.UnixTimeStampToDateTime((int)model_.otherPlayer.ctime);
		windowHierarchy_.DateDataLabel.text = string.Format("{0}/{1}/{2}", dateTime.Day.ToString("00"), dateTime.Month.ToString("00"), dateTime.Year.ToString("00"));
		string text = "0";
		if (model_.otherPlayer.friends != null)
		{
			text = model_.otherPlayer.friends.Length.ToString();
		}
		for (int i = 0; i < windowHierarchy_.FriendsCountLabels.Length; i++)
		{
			windowHierarchy_.FriendsCountLabels[i].text = text;
		}
		if (model_.otherPlayer.friends != null)
		{
			items_ = new PlayerInfoWindowItemHierarchy[model_.otherPlayer.friends.Length];
			for (int j = 0; j < model_.otherPlayer.friends.Length; j++)
			{
				FriendMessage friendMessage = model_.otherPlayer.friends[j];
				items_[j] = (items_[j] = prefabsManager.InstantiateNGUIIn<PlayerInfoWindowItemHierarchy>("UIPlayerInformationItem", windowHierarchy_.Grid.gameObject));
				items_[j].gameObject.AddComponent<UIDragScrollView>().scrollView = windowHierarchy_.ScrollView;
				string text2 = friendMessage.name;
				if (text2.Length >= 8)
				{
					text2 = text2.Substring(0, 8) + "...";
				}
				items_[j].LabelName.text = text2;
				items_[j].CreateActor();
				items_[j].SetSkin(friendMessage.skinId);
				string persId = friendMessage.persId;
				ButtonSet.Up(items_[j].InfoButton, delegate
				{
					HandleShowInformation(persId);
				}, ButtonSetGroup.InWindow);
				windowHierarchy_.Grid.AddElement(items_[j].transform);
			}
			windowHierarchy_.Grid.Reposition();
		}
		if (!friendsController_.Self(model_.otherPlayer.persId))
		{
			bool flag = friendsController_.InputExist(model_.otherPlayer.persId);
			bool flag2 = friendsController_.OutputExist(model_.otherPlayer.persId);
			bool flag3 = friendsController_.FriendExist(model_.otherPlayer.persId);
			windowHierarchy_.AddFriend.Button.gameObject.SetActive(!flag3 && !flag2 && !flag);
			windowHierarchy_.DeleteFriend.Button.gameObject.SetActive(flag3);
			windowHierarchy_.Join.Button.gameObject.SetActive(model_.otherPlayer.instanceId > 0);
			windowHierarchy_.Accept.Button.gameObject.SetActive(flag);
			windowHierarchy_.Decline.Button.gameObject.SetActive(flag);
			windowHierarchy_.RequestLabel.gameObject.SetActive(flag2);
		}
	}

	private void ClearFields()
	{
		windowHierarchy_.NameLabel.text = string.Empty;
		windowHierarchy_.LevelLabel.text = string.Empty;
		windowHierarchy_.StatusLabel.text = string.Empty;
		windowHierarchy_.NameTable.Reposition();
		windowHierarchy_.MapsCountLabel.text = string.Empty;
		windowHierarchy_.KillsCountLabel.text = string.Empty;
		windowHierarchy_.InstanceLabel.text = string.Empty;
		windowHierarchy_.DescriptionLabel.text = string.Empty;
		windowHierarchy_.DateDataLabel.text = string.Empty;
		windowHierarchy_.Join.Button.gameObject.SetActive(false);
		windowHierarchy_.AddFriend.Button.gameObject.SetActive(false);
		windowHierarchy_.DeleteFriend.Button.gameObject.SetActive(false);
		windowHierarchy_.Accept.Button.gameObject.SetActive(false);
		windowHierarchy_.Decline.Button.gameObject.SetActive(false);
		windowHierarchy_.Table.Reposition();
		for (int i = 0; i < windowHierarchy_.FriendsCountLabels.Length; i++)
		{
			windowHierarchy_.FriendsCountLabels[i].text = string.Empty;
		}
		if (icon_ != null)
		{
			icon_.DisposeActor();
			UnityEngine.Object.Destroy(icon_.gameObject);
		}
		icon_ = null;
		if (items_ != null)
		{
			for (int j = 0; j < items_.Length; j++)
			{
				items_[j].DisposeActor();
				UnityEngine.Object.Destroy(items_[j].gameObject);
			}
			items_ = null;
			windowHierarchy_.Grid.Clear();
		}
	}

	private void HandleViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			friendsController_.PlayerInfoUpdated += HandlePlayerInfoUpdated;
			friendsController_.FriendsUpdated += HandleFriendsUpdated;
			friendsController_.ActionComplete += HandleActionComplete;
			FillFields();
		}
		else
		{
			friendsController_.PlayerInfoUpdated -= HandlePlayerInfoUpdated;
			friendsController_.FriendsUpdated -= HandleFriendsUpdated;
			friendsController_.ActionComplete -= HandleActionComplete;
			ClearFields();
			model_.otherPlayer = null;
		}
	}

	private void HandleActionComplete()
	{
		windowHierarchy_.AddFriend.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.DeleteFriend.Roller.Widget.gameObject.SetActive(false);
		windowHierarchy_.Join.Roller.Widget.gameObject.SetActive(false);
	}

	private void HandlePlayerInfoUpdated()
	{
		FillFields();
	}

	private void HandleFriendsUpdated()
	{
		FillFields();
	}

	private void HandleShowInformation(string persId)
	{
		friendsController_.GetPlayerInfo(persId);
	}

	private void HandleAddFriend()
	{
		windowHierarchy_.AddFriend.Roller.Widget.gameObject.SetActive(true);
		windowHierarchy_.AddFriend.Button.gameObject.SetActive(false);
		friendsController_.AddFriend(model_.otherPlayer.userId, model_.otherPlayer.persId);
	}

	private void HandleDeleteFriends()
	{
		windowHierarchy_.DeleteFriend.Roller.Widget.gameObject.SetActive(true);
		windowHierarchy_.DeleteFriend.Button.gameObject.SetActive(false);
		friendsController_.DeleteFriend(model_.otherPlayer.persId);
	}

	private void HandleJoinFriend()
	{
		windowHierarchy_.Join.Button.gameObject.SetActive(false);
		Log.Info("Try to Join Instance[In the future]");
	}

	private void HandleAccept()
	{
		windowHierarchy_.Accept.Roller.Widget.gameObject.SetActive(true);
		windowHierarchy_.Accept.Button.gameObject.SetActive(false);
		friendsController_.AcceptRequest(model_.otherPlayer.persId);
	}

	private void HandleDecline()
	{
		windowHierarchy_.Decline.Roller.Widget.gameObject.SetActive(true);
		windowHierarchy_.Decline.Button.gameObject.SetActive(false);
		friendsController_.DenyRequest(model_.otherPlayer.persId);
	}
}

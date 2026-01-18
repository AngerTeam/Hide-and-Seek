using System;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using Extensions;
using FriendsModule.RemoteData;
using HttpNetwork;
using HudSystem;
using PlayerModule.MyPlayer;
using WindowsModule;

namespace FriendsModule
{
	public class FriendsController : Singleton
	{
		private const int ERR_FRIENDS_LIMIT = 1300;

		private const int ERR_PLAYER_FRIENDS_LIMIT = 1301;

		private const int ERR_FRIEND_REQUESTS_LIMIT = 1302;

		private FriendsModel model_;

		private InputManager inputManager_;

		private HttpOnlineManager http_;

		private MyPlayerStatsModel playerManager_;

		private DialogWindowManager dialogManager_;

		public event Action ActionStart;

		public event Action ActionComplete;

		public event Action PlayerInfoUpdated;

		public event Action FriendsUpdated;

		public event Action PlayersUpdated;

		public event Action PointerClicked;

		public string PlayerName(string persId)
		{
			if (model_.friends != null)
			{
				for (int i = 0; i < model_.friends.Length; i++)
				{
					if (model_.friends[i].persId == persId)
					{
						return model_.friends[i].name;
					}
				}
			}
			if (model_.input != null)
			{
				for (int j = 0; j < model_.input.Length; j++)
				{
					if (model_.input[j].persId == persId)
					{
						return model_.input[j].name;
					}
				}
			}
			if (model_.output != null)
			{
				for (int k = 0; k < model_.output.Length; k++)
				{
					if (model_.output[k].persId == persId)
					{
						return model_.output[k].name;
					}
				}
			}
			Log.Error("Error: Player with persId '{0}' not found.", persId);
			return string.Empty;
		}

		public bool FriendExist(string persId)
		{
			if (model_.friends == null)
			{
				return false;
			}
			for (int i = 0; i < model_.friends.Length; i++)
			{
				if (model_.friends[i].persId == persId)
				{
					return true;
				}
			}
			return false;
		}

		public bool InputExist(string persId)
		{
			if (model_.input == null)
			{
				return false;
			}
			for (int i = 0; i < model_.input.Length; i++)
			{
				if (model_.input[i].persId == persId)
				{
					return true;
				}
			}
			return false;
		}

		public bool OutputExist(string persId)
		{
			if (model_.output == null)
			{
				return false;
			}
			for (int i = 0; i < model_.output.Length; i++)
			{
				if (model_.output[i].persId == persId)
				{
					return true;
				}
			}
			return false;
		}

		public bool Self(string persId)
		{
			return playerManager_.stats.persId == persId;
		}

		public void GetFriends()
		{
			FriendsLuaCommand command = new FriendsLuaCommand();
			http_.Send<FriendsResponse>(command, OnGetFriendsResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public void AddFriend(int userId, string persId)
		{
			FriendRequestSendLuaCommand command = new FriendRequestSendLuaCommand(userId, persId);
			http_.Send<FriendRequestSendResponse>(command, OnAddFriendResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public void DeleteFriend(string persId)
		{
			FriendDeleteLuaCommand command = new FriendDeleteLuaCommand(persId);
			http_.Send<FriendDeleteResponse>(command, OnDeleteFriendResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public void CancelRequest(int userId, string persId)
		{
			FriendRequestCancelLuaCommand command = new FriendRequestCancelLuaCommand(userId, persId);
			http_.Send<FriendRequestCancelResponse>(command, OnCancelRequestReceived);
			this.ActionStart.SafeInvoke();
		}

		public void AcceptRequest(string persId)
		{
			model_.lastFriendName = PlayerName(persId);
			FriendRequestSubmitLuaCommand command = new FriendRequestSubmitLuaCommand(persId);
			http_.Send<FriendRequestSubmitResponse>(command, OnAcceptRequestResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public void DenyRequest(string persId)
		{
			FriendRequestDeleteLuaCommand command = new FriendRequestDeleteLuaCommand(persId);
			http_.Send<FriendRequestDeleteResponse>(command, OnDenyRequestResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public void GetPlayerInfo(string persId)
		{
			OtherPlayerLuaCommand command = new OtherPlayerLuaCommand(persId);
			http_.Send<OtherPlayerResponse>(command, OnGetPlayerInfo);
			this.ActionStart.SafeInvoke();
		}

		public void SearchPlayer(string name)
		{
			PlayerSearchLuaCommand command = new PlayerSearchLuaCommand(name);
			http_.Send<PlayerSearchResponse>(command, OnPlayerSearchResponseReceived);
			this.ActionStart.SafeInvoke();
		}

		public override void OnSyncRecieved()
		{
			base.OnSyncRecieved();
			SingletonManager.Get<HttpOnlineManager>(out http_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerManager_);
			SingletonManager.Get<DialogWindowManager>(out dialogManager_);
			SingletonManager.Get<InputManager>(out inputManager_);
			if (!SingletonManager.TryGet<FriendsModel>(out model_))
			{
				model_ = SingletonManager.Add<FriendsModel>();
			}
			GuiModuleHolder.GetOrAdd<FriendsWindow>();
			GuiModuleHolder.GetOrAdd<PlayerInfoWindow>();
			inputManager_.PointerClickedOnNgui += HandlePointerClicked;
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<FriendsContentMap>();
		}

		public override void Dispose()
		{
			base.Dispose();
			inputManager_.PointerClickedOnNgui -= HandlePointerClicked;
		}

		private void HandlePointerClicked(object sender, InputEventArgs e)
		{
			this.PointerClicked.SafeInvoke();
		}

		private void HandleTimerComplete()
		{
			GetFriends();
		}

		private void OnGetFriendsResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			FriendsResponse friendsResponse = obj.remoteMessage as FriendsResponse;
			if (friendsResponse == null)
			{
				Log.Error("Error: message not received");
			}
			if (friendsResponse.friends == null)
			{
				Log.Error("Error: friends not received");
			}
			if (friendsResponse.requests == null)
			{
				Log.Error("Error: input requests not received");
			}
			if (friendsResponse.sendRequests == null)
			{
				Log.Error("Error: output requests not received");
			}
			model_.friends = friendsResponse.friends;
			model_.input = friendsResponse.requests;
			model_.output = friendsResponse.sendRequests;
			this.FriendsUpdated.SafeInvoke();
		}

		private void OnAddFriendResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			FriendRequestSendResponse friendRequestSendResponse = obj.remoteMessage as FriendRequestSendResponse;
			if (friendRequestSendResponse == null)
			{
				Log.Error("Error: message not received");
			}
			switch (friendRequestSendResponse.friendAdded)
			{
			case 1300:
				dialogManager_.ShowMessage(Localisations.Get("Error_Friends_Limit"));
				break;
			case 1301:
				dialogManager_.ShowMessage(Localisations.Get("Error_Player_Friends_Limit"));
				break;
			case 1302:
				dialogManager_.ShowMessage(Localisations.Get("Error_Friend_Requests_Limit"));
				break;
			default:
				MessageBroadcaster.ReportInfo(Localisations.Get("UI_Message_Request_Send"), 230f);
				GetFriends();
				break;
			}
		}

		private void OnCancelRequestReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			GetFriends();
		}

		private void OnDeleteFriendResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			GetFriends();
		}

		private void OnAcceptRequestResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			MessageBroadcaster.ReportInfo(string.Format(Localisations.Get("UI_Message_Friend_Added"), model_.lastFriendName), 230f);
			GetFriends();
		}

		private void OnDenyRequestResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			Log.Info("Deny Request Response Received");
			GetFriends();
		}

		private void OnPlayerSearchResponseReceived(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			PlayerSearchResponse playerSearchResponse = obj.remoteMessage as PlayerSearchResponse;
			if (playerSearchResponse == null)
			{
				Log.Error("Error: message not received");
			}
			if (playerSearchResponse.players == null)
			{
				Log.Error("Error: players not received");
			}
			model_.players = playerSearchResponse.players;
			this.PlayersUpdated.SafeInvoke();
		}

		private void OnGetPlayerInfo(RemoteMessageEventArgs obj)
		{
			this.ActionComplete.SafeInvoke();
			OtherPlayerResponse otherPlayerResponse = obj.remoteMessage as OtherPlayerResponse;
			if (otherPlayerResponse == null)
			{
				throw new Exception("Error: message not received");
			}
			model_.otherPlayer = otherPlayerResponse.otherPlayer;
			this.PlayerInfoUpdated.SafeInvoke();
		}
	}
}

using System;
using System.Collections.Generic;
using Authorization;
using Chat;
using CraftyEngine;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using ExceptionsModule;
using HttpNetwork;
using Interlace.Amf;
using RemoteData;
using RemoteData.Chat;
using TcpIpNetworkModule;
using UnityEngine;

namespace CraftyNetworkEngine.Chat
{
	public class ChatManager : Singleton
	{
		private const int PING_SECONDS_INTERVAL = 30;

		private bool isSessionExpired_;

		private bool isConnectionOpened_;

		private float lastPingTime_;

		private bool updateReconnect_;

		private bool needReconnect_;

		private float reconnectDelay_;

		private float nextReconnect_;

		private UnityEvent unityEvent_;

		private ChatView chatView_;

		private ChatRoom currentRoom_;

		private AuthorizationModel authModel_;

		private HttpOnlineModel onlineModel_;

		private WithHttpHeader network_;

		private ExceptionsManager exceptionsManager_;

		private string CurrentChannelId
		{
			get
			{
				return (currentRoom_ != null) ? currentRoom_.data.id : string.Empty;
			}
		}

		public override void Init()
		{
			SingletonManager.Get<AuthorizationModel>(out authModel_);
			SingletonManager.Get<HttpOnlineModel>(out onlineModel_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			exceptionsManager_.AddHandler(HandleException, 3101, 3102, 3103, 3104, 3105, 3106, 601, 1006, 3107, 3204);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<ChatContentMap>();
			chatView_ = new ChatView();
			chatView_.SendMessage += SendMessage;
			chatView_.OnSystemMessage += SystemMessage;
			chatView_.HideChat();
			reconnectDelay_ = ChatContentMap.ChatSettings.ChatReconnectDelay;
			needReconnect_ = false;
			isSessionExpired_ = false;
			isConnectionOpened_ = false;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private static void Report(string name, string message, params object[] args)
		{
			Log.Info("[ChatManager::{0}] {1}", name, string.Format(message, args));
		}

		private static void ReportWarning(string name, string message, params object[] args)
		{
			Log.Warning("[ChatManager::{0}] {1}", name, string.Format(message, args));
		}

		private static void ReportError(string name, string message, params object[] args)
		{
			Log.Error("[ChatManager::{0}] {1}", name, string.Format(message, args));
		}

		public void SetReconnect()
		{
			updateReconnect_ = true;
		}

		public void OpenChat()
		{
			chatView_.HideChat();
			isConnectionOpened_ = false;
			if (isSessionExpired_)
			{
				ReportError("Connection", "session expired");
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
			else
			{
				Connect();
			}
		}

		public void CloseChat()
		{
			chatView_.HideChat();
			isConnectionOpened_ = false;
			Disconnect();
		}

		private void Update()
		{
			if (needReconnect_ && nextReconnect_ < Time.time)
			{
				needReconnect_ = false;
				OpenChat();
			}
			if (updateReconnect_)
			{
				updateReconnect_ = false;
				needReconnect_ = true;
				nextReconnect_ = Time.time + reconnectDelay_;
			}
			if (isConnectionOpened_)
			{
				chatView_.Update();
				Ping();
			}
		}

		private void Ping()
		{
			float time = Time.time;
			if (lastPingTime_ < time)
			{
				lastPingTime_ = time + 30f;
				PingCommand command = new PingCommand();
				HttpService.SessionRequest(command);
			}
		}

		private void Connect()
		{
			Disconnect();
			if (string.IsNullOrEmpty(authModel_.chatIp))
			{
				ReportError("Connect", "Connection URL is missing.");
				return;
			}
			Updater updater = new Updater();
			network_ = new WithHttpHeader(updater, "chat", false);
			AssignEvents();
			network_.Connect(authModel_.chatIp, authModel_.chatPort);
		}

		private void Disconnect()
		{
			if (network_ != null)
			{
				RemoveEvents();
				network_.Dispose();
				network_ = null;
			}
			exceptionsManager_.RemoveHandler(HandleException);
		}

		private void AssignEvents()
		{
			if (network_ != null)
			{
				network_.Opened += OnConnectionOpenedHandler;
				network_.AmfMessageRecieved += OnMessageReceivedHandler;
				network_.Closed += OnSocketClosedHandler;
			}
		}

		private void RemoveEvents()
		{
			if (network_ != null)
			{
				network_.Opened -= OnConnectionOpenedHandler;
				network_.AmfMessageRecieved -= OnMessageReceivedHandler;
				network_.Closed -= OnSocketClosedHandler;
			}
		}

		public void SendGetHistoryCommand()
		{
			Send(new GetHistoryCommand(onlineModel_.persId, onlineModel_.userId, onlineModel_.sessionId));
		}

		public void SendInitCommand()
		{
			Send(new InitCommand(onlineModel_.persId, onlineModel_.userId, onlineModel_.sessionId, 0));
		}

		public void SendMessageCommand(string message)
		{
			Send(new NewMessageCommand(CurrentChannelId, "ru", 1, message, onlineModel_.sessionId, onlineModel_.userId, onlineModel_.persId));
		}

		public bool ProcessCommand(string command, AmfObject amfObj)
		{
			switch (command)
			{
			case "init":
				SendGetHistoryCommand();
				return true;
			case "update_channel":
				ProcessUpdateChannelCommand(amfObj);
				return true;
			case "get_history":
				EnterChatRoom(amfObj);
				return true;
			default:
				return false;
			}
		}

		private void OnConnectionOpenedHandler()
		{
			isConnectionOpened_ = true;
			chatView_.ShowInGameChat();
			SendInitCommand();
		}

		private void OnMessageReceivedHandler(AmfObject amfObj)
		{
			Log.Info("[ChatManager::Received] Chat message: " + AmfHelper.AmfToString(amfObj));
			object value;
			object value2;
			if (amfObj.Properties.TryGetValue("error", out value))
			{
				ReportError("ServerError", (string)value);
				if ("session expired" == (string)value)
				{
					isSessionExpired_ = true;
					SetReconnect();
				}
			}
			else if (!amfObj.Properties.TryGetValue("cmd", out value2) || !ProcessCommand((string)value2, amfObj))
			{
				object value3;
				object value4;
				if (!amfObj.Properties.TryGetValue("resp", out value3))
				{
					ReportWarning("Received", string.Format("Unknown response: '{0}'!", (string)value3));
				}
				else if (amfObj.Properties.TryGetValue("status", out value4) && (int)value4 > 0)
				{
					ReportWarning("Received", string.Format("Response status: '{0}'", value4));
					SetReconnect();
				}
				else
				{
					ProcessCommand((string)value3, amfObj);
				}
			}
		}

		private void OnSocketClosedHandler(string message)
		{
			Report("SocketClosed", message);
			isConnectionOpened_ = false;
			SetReconnect();
		}

		private void SendMessage(string message)
		{
			if (string.IsNullOrEmpty(message))
			{
				ReportError("SendMessage", "Try send null or empty message!");
			}
			else if (currentRoom_ == null)
			{
				SetReconnect();
			}
			else
			{
				SendMessageCommand(message);
			}
		}

		public void SystemMessage(string text)
		{
			ChatMessageMessage chatMessageMessage = new ChatMessageMessage();
			chatMessageMessage.name = "System";
			chatMessageMessage.userType = 2;
			chatMessageMessage.text = text;
			chatMessageMessage.ts = ContentStandart.GetUnixTimeStamp();
			ChatMessageMessage newMessage = chatMessageMessage;
			chatView_.AddMessage(newMessage);
		}

		private void Send(RemoteCommand command)
		{
			HttpService.SessionRequest(command);
			AmfObject amfObject = command.Serialize();
			Report("Send", "Message:\n{0}\n", AmfHelper.AmfToString(amfObject));
			try
			{
				byte[] bytes = AmfHelper.Write(amfObject);
				network_.Send(bytes);
			}
			catch (Exception ex)
			{
				ReportError("Send", "Sending command {0} failed: {1}", AmfHelper.AmfToString(amfObject), ex.Message);
			}
		}

		private void EnterChatRoom(AmfObject obj)
		{
			ChannelListMessage channelListMessage = DeserializeChatInfoResponse(obj);
			if (currentRoom_ != null)
			{
				currentRoom_.Dispose();
				currentRoom_ = null;
			}
			if (channelListMessage.channelList.Length <= 0)
			{
				ReportError("EnterChatRoom", "Server hasn't returned any channels.");
				return;
			}
			currentRoom_ = new ChatRoom(channelListMessage.channelList[0]);
			currentRoom_.SortMessagesList();
			chatView_.ShowInGameChat();
		}

		private void ProcessUpdateChannelCommand(AmfObject amfObj)
		{
			if (currentRoom_ == null)
			{
				SetReconnect();
				return;
			}
			ChannelListMessage channelListMessage = DeserializeChatInfoResponse(amfObj);
			currentRoom_.SortMessagesList();
			List<ChatMessageMessage> list = new List<ChatMessageMessage>();
			for (int i = 0; i < channelListMessage.channelList.Length; i++)
			{
				ChannelMessage channelMessage = channelListMessage.channelList[i];
				if (!(channelMessage.id != currentRoom_.data.id))
				{
					ChatMessageMessage[] messages = channelMessage.messages;
					foreach (ChatMessageMessage chatMessageMessage in messages)
					{
						chatMessageMessage.isCurrentPlayer = chatMessageMessage.persId == onlineModel_.persId;
						list.Add(chatMessageMessage);
					}
				}
			}
			list.Sort(delegate(ChatMessageMessage first, ChatMessageMessage second)
			{
				double value = first.ts - second.ts;
				return (!(Math.Abs(value) < 0.01)) ? Math.Sign(value) : 0;
			});
			chatView_.AddMessages(list);
		}

		private ChannelListMessage DeserializeChatInfoResponse(AmfObject amfObj)
		{
			ChannelListMessage message;
			RemoteMessage.TryRead<ChannelListMessage>(amfObj, out message);
			if (message != null)
			{
				return message;
			}
			ReportError("DeserializeChatInfoResponse", "Failed to deserialize a response.");
			return null;
		}

		private void DisposeChatView()
		{
			chatView_.SendMessage -= SendMessage;
			chatView_.OnSystemMessage -= SystemMessage;
			chatView_.Dispose();
			chatView_ = null;
			isConnectionOpened_ = false;
		}

		public override void Dispose()
		{
			if (isConnectionOpened_)
			{
				Disconnect();
				DisposeChatView();
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
				if (currentRoom_ != null)
				{
					currentRoom_.Dispose();
					currentRoom_ = null;
				}
				base.Dispose();
			}
		}

		private bool HandleException(ExceptionArgs args)
		{
			if (args.context != network_)
			{
				return false;
			}
			string message = args.data as string;
			ReportError("SocketError", message);
			isConnectionOpened_ = false;
			SetReconnect();
			return true;
		}
	}
}

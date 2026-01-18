using System;
using System.Collections.Generic;
using Chat;
using CraftyEngine.Infrastructure;
using Extensions;
using HudSystem;
using NguiTools;
using RemoteData.Chat;
using UnityEngine;

namespace CraftyNetworkEngine.Chat
{
	public class ChatView : IDisposable
	{
		private readonly float messageLifetime_ = 3f;

		private readonly int messageLimitCount_ = 3;

		private readonly float messageLimitTime_ = 5f;

		private readonly int messageSizeLimit_ = 50;

		private NguiManager nguiManager_;

		private KeyboardInputManager inputManager_;

		private PrefabsManager prefabsManager_;

		private UIChatFullHierarchy chatFullHierarchy_;

		private UIChatInGameHierarchy chatInGameHierarchy_;

		private Queue<MessageStruct> messages_ = new Queue<MessageStruct>();

		private TouchScreenKeyboard keyboard;

		private int visibleMessageLimit = 10;

		private int ChatFontSize;

		private bool isFullChat;

		private bool needUpdate;

		private ChatMessageColor color_;

		private Queue<DateTime> sentTimestamps_ = new Queue<DateTime>();

		public event Action<string> SendMessage;

		public event Action<string> OnSystemMessage;

		public ChatView()
		{
			color_ = new ChatMessageColor();
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			SingletonManager.Get<KeyboardInputManager>(out inputManager_);
			isFullChat = false;
			needUpdate = false;
			prefabsManager_.Load("ChatPrefabsHolder");
			chatFullHierarchy_ = prefabsManager_.InstantiateIn<UIChatFullHierarchy>("UIChatFullPanel", nguiManager_.UiRoot.transform);
			chatFullHierarchy_.root.SetAnchor(nguiManager_.UiRoot.gameObject, 0, 0, 0, 0);
			chatFullHierarchy_.panel.depth = 1000;
			chatFullHierarchy_.InputMessageField.characterLimit = messageSizeLimit_;
			chatInGameHierarchy_ = prefabsManager_.InstantiateIn<UIChatInGameHierarchy>("UIChatInGamePanel", nguiManager_.UiRoot.transform);
			chatInGameHierarchy_.root.SetAnchor(nguiManager_.UiRoot.gameObject, 0, 0, 0, 0);
			chatInGameHierarchy_.panel.depth = 3;
			inputManager_.ButtonReleased += ButtonReleasedHandler;
			chatFullHierarchy_.OnInputSubmitted += SendChatMessage;
			ButtonSet.Up(chatInGameHierarchy_.ShowFullChatButton, ChatButtonPressed, ButtonSetGroup.Hud);
			ButtonSet.Up(chatFullHierarchy_.ShowIngameChatButton, SwitchChatView, ButtonSetGroup.Undefined);
			ButtonSet.Up(chatFullHierarchy_.SendButton, SendChatMessage, ButtonSetGroup.Undefined);
			visibleMessageLimit = ChatContentMap.ChatSettings.ChatMaxLines;
			ChatFontSize = ChatContentMap.ChatSettings.ChatFontSize;
			chatInGameHierarchy_.IngameChatWindow.textLabel.fontSize = ChatFontSize;
			chatInGameHierarchy_.IngameChatWindow.paragraphHistory = ChatContentMap.ChatSettings.ChatMaxLines;
			messageLimitCount_ = ChatContentMap.ChatSettings.chatMessageLimitCount;
			messageLimitTime_ = ChatContentMap.ChatSettings.chatMessageLimitTime;
			messageLifetime_ = ChatContentMap.ChatSettings.chatMessageLifetime;
			chatFullHierarchy_.SendLabel.text = Localisations.Get("UI_Chat_Button_Send");
			chatFullHierarchy_.InputMessageText.text = Localisations.Get("UI_Chat_Input_Text");
			chatFullHierarchy_.ShowIngameChatLabel.text = Localisations.Get("UI_Chat_Button_Close");
			HideChat();
		}

		public void HideChat()
		{
			isFullChat = false;
			chatInGameHierarchy_.gameObject.SetActive(false);
			chatFullHierarchy_.gameObject.SetActive(false);
		}

		public void ShowInGameChat()
		{
			isFullChat = false;
			chatInGameHierarchy_.gameObject.SetActive(true);
			chatFullHierarchy_.gameObject.SetActive(false);
		}

		public void ShowFullChat()
		{
			isFullChat = true;
			chatInGameHierarchy_.gameObject.SetActive(false);
			chatFullHierarchy_.gameObject.SetActive(true);
			chatFullHierarchy_.InputMessageField.isSelected = true;
		}

		public void SwitchChatView()
		{
			isFullChat = !isFullChat;
			chatInGameHierarchy_.gameObject.SetActive(!isFullChat);
			chatFullHierarchy_.gameObject.SetActive(isFullChat);
		}

		private void ButtonReleasedHandler(object sender, InputEventArgs e)
		{
			switch (e.keyCode)
			{
			case KeyCode.T:
				SwitchChatView();
				break;
			case KeyCode.Return:
				SendChatMessage();
				break;
			case KeyCode.P:
				chatFullHierarchy_.InputMessageField.isSelected = true;
				break;
			}
		}

		private void ChatButtonPressed()
		{
			if (CompileConstants.EDITOR)
			{
				ShowFullChat();
			}
			else
			{
				keyboard = TouchScreenKeyboard.Open(string.Empty, TouchScreenKeyboardType.Default, false, false, false, false, Localisations.Get("UI_Chat_Input_Text"));
			}
		}

		public void AddMessage(MessageStruct mStruct)
		{
			if (messages_.Count > visibleMessageLimit)
			{
				messages_.Dequeue();
			}
			messages_.Enqueue(mStruct);
			needUpdate = true;
		}

		public void AddMessage(ChatMessageMessage newMessage)
		{
			string messageColor = color_.GetMessageColor(newMessage.persId, newMessage.userType, newMessage.type);
			DateTime now = DateTime.Now;
			AddMessage(new MessageStruct(newMessage.ToBbCode(messageColor), now.AddSeconds(messageLifetime_)));
		}

		public void AddMessages(List<ChatMessageMessage> newMessages)
		{
			for (int i = 0; i < newMessages.Count; i++)
			{
				AddMessage(newMessages[i]);
			}
		}

		public void Update()
		{
			MessagesToView();
			DropMessagesByTime();
			ProcessDeviceKeyboard();
			ProcessMessagesTiming();
		}

		private void DropMessagesByTime()
		{
			DateTime now = DateTime.Now;
			for (int i = 0; i < messages_.Count; i++)
			{
				MessageStruct messageStruct = messages_.Peek();
				if (messageStruct.timestamp < now)
				{
					messages_.Dequeue();
					needUpdate = true;
					continue;
				}
				break;
			}
		}

		private void MessagesToView()
		{
			if (!needUpdate)
			{
				return;
			}
			needUpdate = false;
			chatInGameHierarchy_.IngameChatWindow.Clear();
			foreach (MessageStruct item in messages_)
			{
				chatInGameHierarchy_.IngameChatWindow.Add(item.message);
			}
			chatFullHierarchy_.FullChatWindow.Clear();
			foreach (MessageStruct item2 in messages_)
			{
				chatFullHierarchy_.FullChatWindow.Add(item2.message);
			}
			chatInGameHierarchy_.MessagesBackground.gameObject.SetActive(messages_.Count > 0);
			chatInGameHierarchy_.MessagesBackground.bottomAnchor.absolute = -(ChatFontSize + 5) * messages_.Count;
			chatInGameHierarchy_.MessagesBackground.topAnchor.absolute = 5;
		}

		private void ProcessDeviceKeyboard()
		{
			if (keyboard == null)
			{
				return;
			}
			if (keyboard.done)
			{
				string param = keyboard.text;
				if (keyboard.text.Length > messageSizeLimit_)
				{
					param = keyboard.text.Substring(0, messageSizeLimit_);
				}
				if (TryAddMessageTiming())
				{
					this.SendMessage.SafeInvoke(param);
				}
				keyboard = null;
			}
			else if (keyboard.text.Length > messageSizeLimit_)
			{
				keyboard.text = keyboard.text.Substring(0, messageSizeLimit_);
			}
		}

		private void SendChatMessage()
		{
			string value = chatFullHierarchy_.InputMessageField.value;
			if (TryAddMessageTiming())
			{
				this.SendMessage.SafeInvoke(value);
			}
			chatFullHierarchy_.InputMessageField.value = string.Empty;
		}

		private bool TryAddMessageTiming()
		{
			DateTime now = DateTime.Now;
			if (sentTimestamps_.Count >= messageLimitCount_)
			{
				this.OnSystemMessage.SafeInvoke(Localisations.Get("UI_Chat_Max_Messages"));
				return false;
			}
			sentTimestamps_.Enqueue(now.AddSeconds(messageLimitTime_));
			return true;
		}

		private void ProcessMessagesTiming()
		{
			DateTime now = DateTime.Now;
			for (int i = 0; i < sentTimestamps_.Count; i++)
			{
				if (!(now < sentTimestamps_.Peek()))
				{
					break;
				}
				sentTimestamps_.Dequeue();
			}
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(chatFullHierarchy_.gameObject);
			UnityEngine.Object.Destroy(chatInGameHierarchy_.gameObject);
			prefabsManager_ = null;
			inputManager_.ButtonReleased -= ButtonReleasedHandler;
			inputManager_ = null;
			sentTimestamps_.Clear();
			sentTimestamps_ = null;
			chatFullHierarchy_.OnInputSubmitted -= SendChatMessage;
			messages_.Clear();
			messages_ = null;
		}

		public void DisposeUnityThread()
		{
			UnityEngine.Object.Destroy(chatFullHierarchy_.gameObject);
			UnityEngine.Object.Destroy(chatInGameHierarchy_.gameObject);
			chatFullHierarchy_ = null;
			chatInGameHierarchy_ = null;
		}
	}
}

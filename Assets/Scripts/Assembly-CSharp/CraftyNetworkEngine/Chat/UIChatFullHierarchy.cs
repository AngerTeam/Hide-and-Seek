using System;
using UnityEngine;

namespace CraftyNetworkEngine.Chat
{
	public class UIChatFullHierarchy : MonoBehaviour
	{
		public UIPanel panel;

		public UIWidget root;

		public UIButton ShowIngameChatButton;

		public UILabel ShowIngameChatLabel;

		public UIInput InputMessageField;

		public UILabel InputMessageText;

		public UIButton SendButton;

		public UILabel SendLabel;

		public UITextList FullChatWindow;

		public event Action OnInputSubmitted;
	}
}

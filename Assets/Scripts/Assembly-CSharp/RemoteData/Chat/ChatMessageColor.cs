using System.Collections.Generic;
using Chat;
using PlayerModule.MyPlayer;

namespace RemoteData.Chat
{
	public class ChatMessageColor
	{
		private const int CHAT_MSG_TYPE_COMMON = 1;

		private const int CHAT_USER_TYPE_MODERATOR = 2;

		private const int CHAT_USER_TYPE_PLAYER = 1;

		private string adminColor_;

		private string systemColor_;

		private string myPlayerColor_;

		private Dictionary<string, string> colorsByPers_;

		private string myPlayerPersId_;

		private int nextColor_;

		private string[] userColors_;

		public ChatMessageColor()
		{
			colorsByPers_ = new Dictionary<string, string>();
			nextColor_ = 0;
			MyPlayerStatsModel singlton;
			SingletonManager.Get<MyPlayerStatsModel>(out singlton);
			myPlayerPersId_ = singlton.stats.persId;
			string chatLinePlayersColors = ChatContentMap.ChatSettings.ChatLinePlayersColors;
			userColors_ = chatLinePlayersColors.Split(';');
			myPlayerColor_ = userColors_[0];
			chatLinePlayersColors = ChatContentMap.ChatSettings.ChatLineSystemColors;
			string[] array = chatLinePlayersColors.Split(';');
			myPlayerColor_ = array[0];
			adminColor_ = array[1];
			systemColor_ = array[2];
		}

		public string GetMessageColor(string persId, int usrType, int messageType)
		{
			if (messageType != 1)
			{
				return systemColor_;
			}
			switch (usrType)
			{
			case 1:
			{
				if (persId == myPlayerPersId_)
				{
					return myPlayerColor_;
				}
				string value;
				if (colorsByPers_.TryGetValue(persId, out value))
				{
					return value;
				}
				if (nextColor_ >= userColors_.Length)
				{
					nextColor_ = 0;
				}
				value = userColors_[nextColor_];
				colorsByPers_[persId] = value;
				nextColor_++;
				return value;
			}
			case 2:
				return adminColor_;
			default:
				return systemColor_;
			}
		}
	}
}

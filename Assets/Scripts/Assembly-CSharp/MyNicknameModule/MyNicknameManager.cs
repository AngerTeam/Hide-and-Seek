using System;
using Authorization;
using Extensions;
using MyNicknameModule.Content;
using PlayerModule.MyPlayer;
using RemoteData.Lua;
using SyncOnlineModule;
using UnityEngine;
using WindowsModule;

namespace MyNicknameModule
{
	public class MyNicknameManager : Singleton
	{
		public const int NICK_MAX = 20;

		public const int NICK_MIN = 3;

		public static int nickLengthMax = 20;

		public static int nickLengthMin = 3;

		private MyPlayerStatsModel myPlayerStatsModel_;

		public event Action<string> OnNicknameChanged;

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.main != null)
			{
				OnNicknameUpdated(message.main[0].name);
			}
		}

		public string GetRandomNickname()
		{
			int key = UnityEngine.Random.Range(1, MyNicknameModuleContentMap.Nicknames.Count + 1);
			NicknamesEntries value;
			if (MyNicknameModuleContentMap.Nicknames.TryGetValue(key, out value))
			{
				return value.nickname;
			}
			return "Default Nickname";
		}

		public void TrySetNickname(string nickname)
		{
			nickLengthMax = MyNicknameModuleContentMap.NicknameSettings.NickLengthMax;
			nickLengthMin = MyNicknameModuleContentMap.NicknameSettings.NickLengthMin;
			DialogWindowManager singlton;
			SingletonManager.Get<DialogWindowManager>(out singlton);
			if (string.IsNullOrEmpty(nickname))
			{
				singlton.ShowMessage(Localisations.Get("UI_Auth_TypeYourNickname"));
				return;
			}
			int val = nickLengthMin;
			val = Math.Max(val, 3);
			int num = nickLengthMax;
			num = ((num != 0) ? Math.Min(num, 20) : 20);
			if (nickname.Length < val || nickname.Length > num)
			{
				singlton.ShowMessage(Localisations.Get("UI_WrongNickName"));
				return;
			}
			AuthorizationEntity singlton2;
			SingletonManager.Get<AuthorizationEntity>(out singlton2);
			myPlayerStatsModel_.stats.nickname = nickname;
			singlton2.SendNickname(nickname);
			this.OnNicknameChanged.SafeInvoke(nickname);
		}

		public void OnNicknameUpdated(string nickName)
		{
			myPlayerStatsModel_.stats.nickname = nickName;
			this.OnNicknameChanged.SafeInvoke(nickName);
		}
	}
}

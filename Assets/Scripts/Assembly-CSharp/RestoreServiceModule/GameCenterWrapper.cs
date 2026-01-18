using System;
using Extensions;
using SA.Common.Models;

namespace RestoreServiceModule
{
	public class GameCenterWrapper : IRestoreServiceWrapper
	{
		public event Action<bool> AuthFinished;

		public GameCenterWrapper()
		{
			GameCenterManager.OnAuthFinished += OnAuthFinished;
		}

		public void Init()
		{
			GameCenterManager.Init();
		}

		public bool IsAuthenticated()
		{
			return GameCenterManager.IsPlayerAuthenticated;
		}

		public string GetPlayerId()
		{
			return GameCenterManager.Player.Id;
		}

		private void OnAuthFinished(Result res)
		{
			if (res.IsSucceeded)
			{
				Log.Info("Game Center: Player ID: {0} \nAlias: {1} GameCenterManager.IsPlayerAuthenticated = {2}", GameCenterManager.Player.Id, GameCenterManager.Player.Alias, GameCenterManager.IsPlayerAuthenticated);
			}
			else
			{
				Log.Error("Game Center: Player authentication failed");
			}
			this.AuthFinished.SafeInvoke(res.IsSucceeded);
		}
	}
}

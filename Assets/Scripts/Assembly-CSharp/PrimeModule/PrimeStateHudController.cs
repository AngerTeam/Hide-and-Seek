using System;
using BattleStats;
using HideAndSeek;
using HudSystem;
using InventoryModule;
using InventoryViewModule;
using MiniGameCraft.GameStates;
using SpawnHudModule;
using WindowsModule;

namespace PrimeModule
{
	public class PrimeStateHudController : IDisposable
	{
		public ForceRespawnTimer forceRespawnTimer;

		public RespawnHud hud;

		private bool hudVisible_;

		private WindowsManager windowsManager_;

		private PrimeModel model_;

		public PrimeStateHudController(float forceRespawnTime)
		{
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			SingletonManager.Get<PrimeModel>(out model_);
			windowsManager_.AnyWindowToggled += HandleAnyWindowToggled;
			hud = GuiModuleHolder.Add<RespawnHud>();
			if (model_.hideAndSeek)
			{
				GuiModuleHolder.Add<GameHideAndSeekBeltHud>();
			}
			else
			{
				GuiModuleHolder.Add<GameBeltHud>();
			}
			forceRespawnTimer = new ForceRespawnTimer(forceRespawnTime);
			SingletonManager.Get<GameInventoryWindowController>().SetLayout(1);
		}

		public void Dispose()
		{
			GuiModuleHolder.Remove<RespawnHud>();
			if (model_.hideAndSeek)
			{
				GuiModuleHolder.Remove<GameHideAndSeekBeltHud>();
			}
			else
			{
				GuiModuleHolder.Remove<GameBeltHud>();
			}
			windowsManager_.AnyWindowToggled -= HandleAnyWindowToggled;
		}

		public void SetHudVisible(bool value)
		{
			Log.Temp("SetHudVisible", value);
			hudVisible_ = value;
			bool flag = windowsManager_.FrontWindow is BattleStatsTableWindow || !windowsManager_.AnyWindowIsOpen;
			hud.SetVisible(hudVisible_ && flag);
		}

		public void StartTimer()
		{
			forceRespawnTimer.Start();
		}

		public void StopTimer()
		{
			forceRespawnTimer.Stop();
		}

		private void HandleAnyWindowToggled()
		{
			SetHudVisible(hudVisible_);
		}
	}
}

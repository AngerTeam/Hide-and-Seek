using System.Collections.Generic;
using CraftyEngine.Sounds;
using MyPlayerInput;
using PrimeModule;
using RemoteData.Lua;
using SyncOnlineModule;

namespace SelectModeModule
{
	public class SelectModeController : Singleton
	{
		private PrimeModel model_;

		private GameModel gameModel_;

		public List<PvpLastIslandsMessage> ComebackIslands { get; private set; }

		public override void OnDataLoaded()
		{
			SingletonManager.Get<PrimeModel>(out model_);
			SingletonManager.Get<GameModel>(out gameModel_);
			ComebackIslands = new List<PvpLastIslandsMessage>();
		}

		public override void OnSyncRecieved()
		{
			ComebackIslands = new List<PvpLastIslandsMessage>();
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.pvpLastIslands != null && message.pvpLastIslands.Length > 0)
			{
				PvpLastIslandsMessage[] pvpLastIslands = message.pvpLastIslands;
				foreach (PvpLastIslandsMessage item in pvpLastIslands)
				{
					ComebackIslands.Add(item);
				}
			}
		}

		public void PlayMap(int modeId, int mapId, bool comeback)
		{
			model_.modeId = modeId;
			model_.mapId = mapId;
			SetSettings(mapId);
			gameModel_.lobby = false;
			gameModel_.prime = true;
		}

		public void SetSettings(int mapId)
		{
			CommonIslandsEntries value;
			if (mapId == 0 || !SelectGameModeMap.CommonIslands.TryGetValue(mapId, out value))
			{
				return;
			}
			model_.rules = new ServerMapSettings(value.mode_id);
			model_.rules.critical_height = ((value.critical_height <= 0) ? MyPlayerInputContentMap.PlayerSettings.criticalFallHeight : value.critical_height);
			model_.rules.flags = value.flags;
			model_.rules.hide_timeout = value.hide_timeout;
			model_.rules.ttl = value.ttl;
			model_.rules.idle_timeout = value.idle_timeout;
			model_.rules.seek_timeout = value.seek_timeout;
			model_.rules.hide_fight_timeout = value.hide_fight_timeout;
			model_.skyboxId = 1;
			model_.useClouds = 1;
			model_.mapId = mapId;
			model_.modeId = value.mode_id;
			model_.mapFile = value.GetFullMapPath();
			model_.cameraPosition = Vector3Utils.SafeParse(value.killcam_position);
			model_.cameraRotation = Vector3Utils.SafeParse(value.killcam_rotation);
			if (value.sound_group_id > 0)
			{
				SoundProvider.SoundAmbientGroup(value.sound_group_id);
			}
			else
			{
				SoundProvider.StopAmbient();
			}
			if (SelectGameModeMap.CommonIslandSkins == null)
			{
				return;
			}
			List<ServerSkinSettings> list = new List<ServerSkinSettings>();
			foreach (CommonIslandSkinsEntries value2 in SelectGameModeMap.CommonIslandSkins.Values)
			{
				if (value2.island_id == mapId)
				{
					ServerSkinSettings serverSkinSettings = new ServerSkinSettings();
					serverSkinSettings.side = value2.side;
					serverSkinSettings.skin_id = value2.skin_id;
					list.Add(serverSkinSettings);
				}
				model_.rules.skins = list.ToArray();
			}
		}
	}
}

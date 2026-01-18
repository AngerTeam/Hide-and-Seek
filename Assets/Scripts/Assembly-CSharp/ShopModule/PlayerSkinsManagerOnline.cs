using System.Collections.Generic;
using BankModule;
using CraftyNetworkEngine;
using PlayerModule.MyPlayer;
using RemoteData;
using RemoteData.Socket;
using SyncOnlineModule;

namespace ShopModule
{
	public class PlayerSkinsManagerOnline : PermanentSingleton
	{
		private SkinEntryView currentSkin_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private PlayerSkinsManager playerSkinsManager_;

		private BroadPurchaseOnline online_;

		private IShopOnline shop_;

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PlayerSkinsManager>(out playerSkinsManager_);
			SingletonManager.Get<BroadPurchaseOnline>(out online_);
			playerSkinsManager_.BuySkinClicked += BuySkin;
			playerSkinsManager_.SetSkinClicked += SetSkin;
			online_.SkinsUpdated += SetAvailableSkins;
		}

		public void BuySkin(SkinEntryView skin)
		{
			currentSkin_ = skin;
			SingletonManager.Get<IShopOnline>(out shop_);
			shop_.BuySkinReceived += OnSkinBoughtHandler;
			shop_.SendBuySkin(skin.skinData.id);
			myPlayerStatsModel_.stats.SkinChanged += SetSkinAfterBuying;
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.main != null)
			{
				MainMessage mainMessage = message.main[0];
				myPlayerStatsModel_.stats.SkinId = mainMessage.skinId;
			}
		}

		private void SetSkinAfterBuying(int skinId)
		{
			myPlayerStatsModel_.stats.SkinChanged -= SetSkinAfterBuying;
			SetSkin(skinId);
		}

		private void SetSkin(int skinId)
		{
			SingletonManager.Get<IShopOnline>(out shop_);
			shop_.SendSetSkin(skinId);
		}

		public void OnSkinBoughtHandler(RemoteMessageEventArgs args)
		{
			shop_.BuySkinReceived -= OnSkinBoughtHandler;
			myPlayerStatsModel_.stats.SkinId = currentSkin_.skinData.id;
			playerSkinsManager_.OnSkinBoughtHandler(currentSkin_);
		}

		private void SetAvailableSkins(SkinsMessage[] skins)
		{
			PlayerSkinsManager singleton;
			if (skins != null && SingletonManager.TryGet<PlayerSkinsManager>(out singleton))
			{
				int[] array = new int[skins.Length];
				for (int i = 0; i < skins.Length; i++)
				{
					array[i] = skins[i].skinId;
				}
				singleton.SetAvailableSkins(skins.ExtractArray((SkinsMessage skin) => skin.skinId));
			}
		}
	}
}

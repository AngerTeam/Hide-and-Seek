using System;
using System.Collections.Generic;
using BankModule;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using ExpirienceModule;
using Extensions;
using HideAndSeek;
using InventoryModule;
using NotificationsModule;
using PlayerModule.MyPlayer;
using RemoteData.Lua;
using SyncOnlineModule;

namespace SpecialOffersModule
{
	public class SpecialOffersManager : PermanentSingleton
	{
		public const string BATTLES_COUNTER = "battles";

		public const string HNS_COUNTER = "hns_matches";

		private List<SpecialOffer> offers_;

		private int registrationTime_;

		private int pvpBattlesPlayed_;

		private int hnsPlayed_;

		private TimeManager timeManager_;

		private PurchasesManager purchasesManager_;

		private ExpirienceManager expirienceManager_;

		private MyPlayerStatsModel playerStatsManager_;

		private NotificationsManager notificationsManager_;

		public SpecialOffer CurrentOffer { get; private set; }

		public bool CanShowCurrentSpecialOffer
		{
			get
			{
				return CurrentOffer != null && IsOfferActive(CurrentOffer);
			}
		}

		public event Action<bool> ShowSpecialOffer;

		public event Action HideSpecialOffer;

		public override void Init()
		{
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<PurchasesManager>(out purchasesManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerStatsManager_);
			SingletonManager.Get<NotificationsManager>(out notificationsManager_);
			SingletonManager.Get<ExpirienceManager>(out expirienceManager_);
			purchasesManager_.PurchaseCompleted += OnPurchaseCompleted;
			expirienceManager_.LvlUpDone += OnLevelUpDone;
		}

		public override void OnDataLoaded()
		{
			TimeUtils.SetLetters(Localisations.Get("UI_Time_D"), Localisations.Get("UI_Time_H"), Localisations.Get("UI_Time_M"), Localisations.Get("UI_Time_S"));
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (!SyncManager.TryRead<PlayerSyncMessage>(out message) || message.offers == null)
			{
				return;
			}
			if (message.main != null && message.main.Length > 0)
			{
				registrationTime_ = Convert.ToInt32(message.main[0].ctime);
			}
			if (message.counters != null)
			{
				CounterMessage[] counters = message.counters;
				foreach (CounterMessage counterMessage in counters)
				{
					if (counterMessage.id == "battles")
					{
						pvpBattlesPlayed_ = counterMessage.value;
					}
					if (counterMessage.id == "hns_matches")
					{
						hnsPlayed_ = counterMessage.value;
					}
				}
			}
			InitOffers();
			if (message.offers != null)
			{
				OfferMessage[] offers = message.offers;
				foreach (OfferMessage offerMessage in offers)
				{
					UpdateOffer(offerMessage.offerId, offerMessage.started, offerMessage.closed);
				}
			}
			CheckForActiveOffers();
			TryStartNewOffer();
		}

		private void OnLevelUpDone(bool succeed)
		{
			UpdateOffersBonusItems();
			if (!succeed)
			{
				TryStartNewOffer();
			}
		}

		public override void Dispose()
		{
			purchasesManager_.PurchaseCompleted -= OnPurchaseCompleted;
			expirienceManager_.LvlUpDone -= OnLevelUpDone;
		}

		private void OnPurchaseCompleted(string inappId)
		{
			if (CurrentOffer != null && CurrentOffer.inappId == inappId)
			{
				DisableSpecialOffer();
			}
		}

		private void InitOffers()
		{
			if (offers_ != null)
			{
				return;
			}
			offers_ = new List<SpecialOffer>();
			if (SpecialOffersContentMap.Offers == null)
			{
				return;
			}
			foreach (OffersEntries value in SpecialOffersContentMap.Offers.Values)
			{
				if (!(value.pf != CompileConstants.PLATFORM))
				{
					SpecialOffer specialOffer = new SpecialOffer(value);
					if (!purchasesManager_.TryGetUMInApp(specialOffer.inappId, out specialOffer.umInApp))
					{
						Log.Info(string.Format("No UMInapp {0} found for offer id {1}:", specialOffer.inappId, specialOffer.entry.id));
					}
					UpdateBonusItems(specialOffer);
					offers_.Add(specialOffer);
				}
			}
			offers_.Sort((SpecialOffer a, SpecialOffer b) => a.entry.sort_val.CompareTo(b.entry.sort_val));
		}

		private void UpdateOffersBonusItems()
		{
			if (offers_ == null)
			{
				return;
			}
			foreach (SpecialOffer item in offers_)
			{
				UpdateBonusItems(item);
			}
		}

		private void UpdateBonusItems(SpecialOffer specialOffer)
		{
			specialOffer.updated = true;
			specialOffer.offerItems = new List<SpecialOfferItem>();
			foreach (BonusItemsEntries value3 in InventoryContentMap.BonusItems.Values)
			{
				if (value3.bonus_id != specialOffer.entry.bonus_id || playerStatsManager_.stats.experiance.level < value3.req_level_min || (playerStatsManager_.stats.experiance.level > value3.req_level_max && value3.req_level_max != 0))
				{
					continue;
				}
				SpecialOfferItem specialOfferItem = new SpecialOfferItem();
				ushort key = (ushort)InventoryContentMap.CraftSettings.CRYSTAL_ARTIKUL_ID;
				if (value3.type_id == "ARTIKUL")
				{
					key = (ushort)Convert.ToInt32(value3.field);
				}
				else if (value3.type_id == "HIDE_VOXEL")
				{
					ushort key2 = (ushort)Convert.ToInt32(value3.field);
					HideVoxelsEntries value;
					if (HideAndSeekContentMap.HideVoxels.TryGetValue(key2, out value))
					{
						key = (ushort)value.artikul.id;
					}
				}
				ArtikulsEntries value2;
				if (InventoryContentMap.Artikuls.TryGetValue(key, out value2))
				{
					specialOfferItem.artikul = value2;
				}
				specialOfferItem.count = value3.value;
				specialOffer.offerItems.Add(specialOfferItem);
			}
		}

		public void PurchaseCurrentOffer()
		{
			purchasesManager_.TryPurchaseItem(CurrentOffer.inappId);
		}

		private void CheckForActiveOffers()
		{
			foreach (SpecialOffer item in offers_)
			{
				if (IsOfferActive(item))
				{
					CurrentOffer = item;
					this.ShowSpecialOffer.SafeInvoke(false);
					return;
				}
			}
			CurrentOffer = null;
			this.HideSpecialOffer.SafeInvoke();
		}

		public void TryStartNewOffer()
		{
			if (CurrentOffer != null || offers_ == null)
			{
				return;
			}
			foreach (SpecialOffer item in offers_)
			{
				if (CahStartOffer(item))
				{
					item.started = timeManager_.CurrentTimestamp;
					CurrentOffer = item;
					this.ShowSpecialOffer.SafeInvoke(true);
					SpecialOffersOnlineController specialOffersOnlineController = SingletonManager.Get<SpecialOffersOnlineController>();
					specialOffersOnlineController.SendOfferStart(item.entry.id, item.inappId);
					notificationsManager_.SetSpecialOfferNotification(GetCurrentOfferTimeInt());
					break;
				}
			}
		}

		private bool IsOfferActive(SpecialOffer offer)
		{
			return offer.closed == 0 && offer.started != 0 && GetOfferTime(offer) > 0;
		}

		private bool CahStartOffer(SpecialOffer offer)
		{
			return offer.closed == 0 && offer.started == 0 && (offer.entry.need_battles == 0 || offer.entry.need_battles <= pvpBattlesPlayed_) && (offer.entry.need_hns_matches == 0 || offer.entry.need_hns_matches <= hnsPlayed_) && (offer.entry.t1 == 0 || offer.entry.t1 <= timeManager_.CurrentTimestamp) && (offer.entry.t2 == 0 || offer.entry.t2 > timeManager_.CurrentTimestamp) && (offer.entry.time_from_reg == 0 || registrationTime_ + offer.entry.time_from_reg >= timeManager_.CurrentTimestamp);
		}

		private void UpdateOffer(int offerId, double started, double closed)
		{
			foreach (SpecialOffer item in offers_)
			{
				if (item.entry.id == offerId)
				{
					if (closed > 0.0 && item.entry.reusable == 1)
					{
						item.started = 0;
						item.closed = 0;
					}
					else
					{
						item.started = Convert.ToInt32(started);
						item.closed = Convert.ToInt32(closed);
					}
					return;
				}
			}
			Log.Error("Not found offer with id:" + offerId);
		}

		private int GetCurrentOfferTimeInt()
		{
			return GetOfferTime(CurrentOffer);
		}

		private int GetOfferTime(SpecialOffer offer)
		{
			return offer.started + offer.entry.ttl - timeManager_.CurrentTimestamp;
		}

		public string GetCurrentOfferTime()
		{
			if (CurrentOffer != null && CurrentOffer.entry != null && CurrentOffer.closed == 0)
			{
				int currentOfferTimeInt = GetCurrentOfferTimeInt();
				if (currentOfferTimeInt < 0)
				{
					DisableSpecialOffer();
				}
				return TimeUtils.ToTimerCounter(currentOfferTimeInt);
			}
			return string.Empty;
		}

		private void DisableSpecialOffer()
		{
			if (CurrentOffer != null)
			{
				notificationsManager_.CancelSpecialOfferNotification();
				CurrentOffer.closed = timeManager_.CurrentTimestamp;
				this.HideSpecialOffer.SafeInvoke();
			}
		}
	}
}

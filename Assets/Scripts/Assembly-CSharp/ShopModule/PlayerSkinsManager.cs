using System;
using System.Collections.Generic;
using ArticulView;
using Extensions;
using PlayerModule.MyPlayer;

namespace ShopModule
{
	public class PlayerSkinsManager : Singleton
	{
		private MyPlayerStatsModel myPlayerManager_;

		public List<SkinEntryView> Skins { get; private set; }

		public event Action<SkinEntryView> BuySkinClicked;

		public event Action<int> SetSkinClicked;

		public event Action<bool> SkinsEnabled;

		public event Action OnSkinBought;

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
		}

		public override void OnDataLoaded()
		{
			Skins = new List<SkinEntryView>();
			foreach (SkinsEntries value in ArticulViewContentMap.Skins.Values)
			{
				if (value.selectable == 1 || value.sale_on == 1)
				{
					Skins.Add(new SkinEntryView(value.sale_on == 0, value));
				}
			}
			Skins.Sort((SkinEntryView a, SkinEntryView b) => a.skinData.sort_val.CompareTo(b.skinData.sort_val));
			base.OnDataLoaded();
		}

		public void EnableSkins(bool enable)
		{
			this.SkinsEnabled.SafeInvoke(enable);
		}

		public void SetAvailableSkins(int[] skinsIds)
		{
			if (skinsIds == null)
			{
				Debug("SetAvailableSkins", "Skins array to set is null.");
				return;
			}
			foreach (SkinEntryView skin in Skins)
			{
				foreach (int num in skinsIds)
				{
					if (skin.skinData.id == num)
					{
						skin.isBought = true;
					}
				}
			}
		}

		private void AddNewAvailableSkin(int skinId)
		{
			foreach (SkinEntryView skin in Skins)
			{
				if (skin.skinData.id != skinId)
				{
					continue;
				}
				skin.isBought = true;
				break;
			}
		}

		public void SetSkin(int skinId)
		{
			myPlayerManager_.stats.SkinId = skinId;
			this.SetSkinClicked.SafeInvoke(skinId);
		}

		public void TryBuySkin(SkinEntryView skin)
		{
			if (skin.skinData.money_cnt > myPlayerManager_.money.GetMoneyAmount(skin.skinData.money_type))
			{
				myPlayerManager_.money.ReportInsufficientMoney(skin.skinData.money_type);
			}
			else
			{
				this.BuySkinClicked.SafeInvoke(skin);
			}
		}

		public void OnSkinBoughtHandler(SkinEntryView skinEntry)
		{
			AddNewAvailableSkin(skinEntry.skinData.id);
			this.OnSkinBought.SafeInvoke();
		}

		public override void Dispose()
		{
			if (Skins != null)
			{
				Skins.Clear();
				Skins = null;
			}
			base.Dispose();
		}

		public void Debug(string methodName, string message)
		{
			Log.Info(string.Format("[PlaShowDialogue] {0} {1}", methodName, message));
		}
	}
}

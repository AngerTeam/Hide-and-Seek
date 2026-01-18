using System;
using Extensions;
using System.Collections.Generic;
using Authorization;
using CraftyEngine.Utils.Unity;
using HudSystem;
using WindowsModule;

namespace BankModule
{
	public class BankWindow : GameWindow
	{
		private BankWindowHierarchy windowHierarchy_;

		private bool generousMode_;

		public event Action ConnectClicked;

		public event Action<string> PurchaseClicked;

		public BankWindow()
			: base(false)
		{
			base.HudState = 41088;
			generousMode_ = !CompileConstants.CONTENT_IS_RELEASE;
			prefabsManager.Load("BankPrefabsHolder");
			windowHierarchy_ = prefabsManager.InstantiateNGUIIn<BankWindowHierarchy>("UIBankWindow", nguiManager.UiRoot.gameObject);
			windowHierarchy_.title.text = Localisations.Get("UI_Buy_Crystals");
			windowHierarchy_.offlineLabel.text = Localisations.Get("UI_Reconnect_Please");
			windowHierarchy_.retryButtonLabel.text = Localisations.Get("UI_Retry");
			windowHierarchy_.bestPriceLabel.text = Localisations.Get("UI_Best_Price");
			windowHierarchy_.playersChoiceLabel.text = Localisations.Get("UI_Players_Choice");
			windowHierarchy_.specialOfferLabel.text = Localisations.Get("UI_Special_Offer");
			ButtonSet.Up(windowHierarchy_.retryButton, this.ConnectClicked.SafeInvoke, ButtonSetGroup.Undefined);
			SetContent(windowHierarchy_.transform, true, true, false, false, true);
			UpdateTestProducts();
		}

		public void SwitchConnected(bool connected)
		{
			GameObjectUtils.SwitchActive(windowHierarchy_.online, connected);
			GameObjectUtils.SwitchActive(windowHierarchy_.offline, !connected);
		}

		public void UpdateProducts(List<StoreInApp> storeInApps)
		{
			if (generousMode_)
			{
				return;
			}
			int num = 0;
			foreach (StoreInApp storeInApp in storeInApps)
			{
				string inappId = storeInApp.inappId;
				if (windowHierarchy_.storeItems.Length > num)
				{
					StoreItemHierarchy storeItemHierarchy = windowHierarchy_.storeItems[num];
					storeItemHierarchy.price.text = storeInApp.price;
					storeItemHierarchy.quantity.text = storeInApp.crystals.ToString();
					ButtonSet.Up(storeItemHierarchy.button, delegate
					{
						this.PurchaseClicked(inappId);
					}, ButtonSetGroup.InWindow);
				}
				num++;
			}
		}

		private void UpdateTestProducts()
		{
			if (!generousMode_)
			{
				return;
			}
			int num = 0;
			string text = ((!CompileConstants.IOS) ? "ANDROID" : "IOS");
			foreach (InappsEntries value in BankContentMap.Inapps.Values)
			{
				if (value.pf != text)
				{
					continue;
				}
				if (windowHierarchy_.storeItems.Length > num)
				{
					StoreItemHierarchy storeItemHierarchy = windowHierarchy_.storeItems[num];
					storeItemHierarchy.price.text = value.price.ToString();
					storeItemHierarchy.quantity.text = value.money.ToString();
					int lambdaId = value.id;
					ButtonSet.Up(storeItemHierarchy.button, delegate
					{
						TestPurchase(lambdaId);
					}, ButtonSetGroup.InWindow);
				}
				num++;
			}
		}

		private void TestPurchase(int lambdaId)
		{
			if (generousMode_)
			{
				InappsEntries inappsEntries = BankContentMap.Inapps[lambdaId];
				HttpBankOnline singlton;
				SingletonManager.Get<HttpBankOnline>(out singlton);
				AuthorizationModel singlton2;
				SingletonManager.Get<AuthorizationModel>(out singlton2);
				singlton.SendPurchaseRequest(inappsEntries.pf, singlton2.deviceId, ContentStandart.GetTimeStamp(), inappsEntries.inapp, inappsEntries.currency, inappsEntries.price, inappsEntries.money, "empty", "empty", 1);
			}
		}
	}
}

using System;
using System.Collections.Generic;
using Extensions;
using RemoteData.Lua;
using RemoteData.Socket;

namespace BankModule
{
	public class PurchasesManager : PermanentSingleton
	{
		private HttpBankOnline httpBankOnline_;

		private PurchasesDataManager purchasesDataManager_;

		private UM_InAppProduct currentInapp_;

		public bool Connected
		{
			get
			{
				return UM_InAppPurchaseManager.Client.IsConnected;
			}
		}

		public List<StoreInApp> StoreInApps { get; private set; }

		public event Action OnConnected;

		public event Action<bool> ShowWaitScreen;

		public event Action<string> PurchaseCompleted;

		public override void Init()
		{
			UM_InAppPurchaseManager.Client.OnServiceConnected += OnServiceConnected;
			UM_InAppPurchaseManager.Client.OnPurchaseFinished += OnPurchaseFinished;
			StoreInApps = new List<StoreInApp>();
		}

		public override void OnDataLoaded()
		{
			TryConnectToMarket();
		}

		public void TryPurchaseItem(string inappId)
		{
			UM_InAppProduct umInApp;
			if (Connected && TryGetUMInApp(inappId, out umInApp))
			{
				if (this.ShowWaitScreen != null)
				{
					this.ShowWaitScreen(true);
				}
				currentInapp_ = umInApp;
				SingletonManager.Get<HttpBankOnline>(out httpBankOnline_);
				httpBankOnline_.MaintenanceCheckReceived += OnMaintenanceCheckReceived;
				httpBankOnline_.SendMaintenanceCheck();
			}
			else
			{
				Log.Error(string.Format("OnPurchase: Product {0} not found!", inappId));
			}
		}

		private void OnMaintenanceCheckReceived(RemoteMessageEventArgs args)
		{
			httpBankOnline_.MaintenanceCheckReceived -= OnMaintenanceCheckReceived;
			RemoteData.Lua.MaintenanceCheckResponse maintenanceCheckResponse = args.remoteMessage as RemoteData.Lua.MaintenanceCheckResponse;
			RemoteData.Socket.MaintenanceCheckResponse maintenanceCheckResponse2 = args.remoteMessage as RemoteData.Socket.MaintenanceCheckResponse;
			if ((maintenanceCheckResponse != null && maintenanceCheckResponse.maintenance == 0) || (maintenanceCheckResponse2 != null && maintenanceCheckResponse2.maintenance == 0))
			{
				UM_InAppPurchaseManager.Client.Purchase(currentInapp_);
			}
			else if (this.ShowWaitScreen != null)
			{
				this.ShowWaitScreen(false);
			}
		}

		public void TryConnectToMarket()
		{
			if (!Connected)
			{
				UM_InAppPurchaseManager.Client.Connect();
			}
			if (StoreInApps.Count == 0)
			{
				TryFillStoreInApps();
			}
		}

		private void OnServiceConnected(UM_BillingConnectionResult obj)
		{
			if (obj.isSuccess && Connected && this.OnConnected != null)
			{
				TryFillStoreInApps();
				this.OnConnected();
			}
		}

		public void TryFillStoreInApps()
		{
			if (!Connected)
			{
				return;
			}
			StoreInApps.Clear();
			if (BankContentMap.Inapps != null)
			{
				foreach (InappsEntries value in BankContentMap.Inapps.Values)
				{
					AddInApp(value.id, value.inapp, value.pf, value.sort_val, value.money_type, value.money, value.flags, value.enabled);
				}
			}
			else
			{
				Log.Error("No Inapps in content map!");
			}
			StoreInApps.Sort((StoreInApp p, StoreInApp q) => p.sorting.CompareTo(q.sorting));
		}

		private void AddInApp(int id, string inappId, string pf, int sort, int moneyType, int money, int flags, int enabled = 1)
		{
			if (pf != CompileConstants.PLATFORM || BitMath.GetBit((byte)flags, 0) || enabled == 0)
			{
				return;
			}
			StoreInApp storeInApp = new StoreInApp();
			storeInApp.id = id;
			storeInApp.inappId = inappId;
			storeInApp.sorting = sort;
			storeInApp.crystals = money;
			UM_InAppProduct umInApp;
			if (TryGetUMInApp(storeInApp.inappId, out umInApp))
			{
				if (CompileConstants.IOS)
				{
					storeInApp.price = umInApp.IOSTemplate.LocalizedPrice;
				}
				else if (CompileConstants.ANDROID)
				{
					storeInApp.price = string.Format("{0} {1}", umInApp.AndroidTemplate.Price, umInApp.AndroidTemplate.PriceCurrencyCode);
				}
				StoreInApps.Add(storeInApp);
			}
			else
			{
				Log.Error("UMInApp not found:" + storeInApp.inappId);
			}
		}

		private bool TryGetStoreInApp(string id, out StoreInApp storeInApp)
		{
			storeInApp = new StoreInApp();
			foreach (StoreInApp storeInApp2 in StoreInApps)
			{
				if (storeInApp2.inappId == id)
				{
					storeInApp = storeInApp2;
					return true;
				}
			}
			return false;
		}

		public bool TryGetUMInApp(string id, out UM_InAppProduct umInApp)
		{
			umInApp = null;
			if (UM_InAppPurchaseManager.InAppProducts == null)
			{
				return false;
			}
			foreach (UM_InAppProduct inAppProduct in UM_InAppPurchaseManager.InAppProducts)
			{
				if ((CompileConstants.ANDROID && inAppProduct.AndroidId == id) || (CompileConstants.IOS && inAppProduct.IOSId == id))
				{
					umInApp = inAppProduct;
					return true;
				}
			}
			return false;
		}

		private void OnPurchaseFinished(UM_PurchaseResult obj)
		{
			this.ShowWaitScreen.SafeInvoke(false);
			Log.Temp("OnPurchaseFinished obj.isSuccess:" + obj.isSuccess + " obj.product.inappId:" + obj.product.id);
			if (!obj.isSuccess)
			{
				Log.Info("Purchase failed");
				return;
			}
			string id = ((!CompileConstants.ANDROID) ? obj.product.IOSId : obj.product.AndroidId);
			StoreInApp storeInApp;
			if (TryGetStoreInApp(id, out storeInApp))
			{
				SendPurchaseRequest(obj, storeInApp.crystals);
			}
			else
			{
				SendPurchaseRequest(obj, 0);
			}
			this.PurchaseCompleted.SafeInvoke(obj.product.id);
		}

		private void SendPurchaseRequest(UM_PurchaseResult obj, int crystals)
		{
			SingletonManager.Get<PurchasesDataManager>(out purchasesDataManager_);
			if (CompileConstants.ANDROID)
			{
				purchasesDataManager_.TrySendPurchase("ANDROID", obj.Google_PurchaseInfo.OrderId, obj.product.AndroidId, obj.product.CurrencyCode, obj.product.ActualPriceValue, crystals, obj.Google_PurchaseInfo.Signature, obj.Google_PurchaseInfo.OriginalJson);
			}
			else if (CompileConstants.IOS)
			{
				purchasesDataManager_.TrySendPurchase("IOS", obj.IOS_PurchaseInfo.TransactionIdentifier, obj.product.IOSId, obj.product.CurrencyCode, obj.product.IOSTemplate.Price, crystals, string.Empty, obj.IOS_PurchaseInfo.Receipt);
			}
		}
	}
}

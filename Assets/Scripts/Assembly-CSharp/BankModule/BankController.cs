using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using HudSystem;
using MoneyModule;
using PlayerModule.MyPlayer;
using WindowsModule;

namespace BankModule
{
	public class BankController : Singleton
	{
		private PurchasesManager purchasesManager_;

		private MyPlayerStatsModel playerModel_;

		private BankWindow bankWindow_;

		public static void InitModule(int layer)
		{
			SingletonManager.Add<PurchaseDataSaver>(layer);
			SingletonManager.Add<PurchasesManager>(layer);
			SingletonManager.Add<PurchasesDataManager>(layer);
			SingletonManager.Add<BankController>(layer);
		}

		public override void OnDataLoaded()
		{
			SingletonManager.Get<PurchasesManager>(out purchasesManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			ContentDeserializer.Deserialize<BankContentMap>();
			bankWindow_ = GuiModuleHolder.Add<BankWindow>();
			GuiModuleHolder.Add<WaitScreenWindow>();
			GuiModuleHolder.Add<CrystalsWidget>();
			bankWindow_.ConnectClicked += TryConnect;
			bankWindow_.PurchaseClicked += TryPurchase;
			bankWindow_.ViewChanged += HandleViewChanged;
			playerModel_.money.InsufficientMoney += HandleInsufficientMoney;
			purchasesManager_.OnConnected += UpdateProductsView;
			purchasesManager_.ShowWaitScreen += ShowWaitScreen;
			purchasesManager_.PurchaseCompleted += OnPurchaseCompleted;
		}

		private void OnPurchaseCompleted(string inappId)
		{
			if (bankWindow_.Visible)
			{
				ToggleBankWindow();
			}
		}

		private void ShowWaitScreen(bool show)
		{
			WaitScreenWindow waitScreenWindow = GuiModuleHolder.Get<WaitScreenWindow>();
			waitScreenWindow.Show(show);
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (bankWindow_.Visible)
			{
				TryConnect();
				UpdateProductsView();
			}
		}

		private void TryConnect()
		{
			purchasesManager_.TryConnectToMarket();
		}

		private void HandleInsufficientMoney(int moneyType)
		{
			if (moneyType == MoneyTypesEntries.crystalId)
			{
				ToggleBankWindow();
			}
		}

		private void ToggleBankWindow()
		{
			WindowsManagerShortcut.ToggleWindow<BankWindow>();
		}

		private void UpdateProductsView()
		{
			bankWindow_.SwitchConnected(purchasesManager_.Connected);
			bankWindow_.UpdateProducts(purchasesManager_.StoreInApps);
		}

		private void TryPurchase(string inAppId)
		{
			purchasesManager_.TryPurchaseItem(inAppId);
		}

		public override void Dispose()
		{
			if (bankWindow_ != null)
			{
				purchasesManager_.ShowWaitScreen -= ShowWaitScreen;
				purchasesManager_.OnConnected -= UpdateProductsView;
				purchasesManager_.PurchaseCompleted -= OnPurchaseCompleted;
				bankWindow_.ConnectClicked -= TryConnect;
				bankWindow_.PurchaseClicked -= TryPurchase;
				bankWindow_.ViewChanged -= HandleViewChanged;
			}
			if (playerModel_ != null)
			{
				playerModel_.money.InsufficientMoney -= HandleInsufficientMoney;
			}
		}
	}
}

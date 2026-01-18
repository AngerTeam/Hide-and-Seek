using System;
using BankModule;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using RemoteData;
using UnityEngine;
using WindowsModule;

namespace RateMeModule
{
	public class RateMeController : Singleton
	{
		private RateBehaveour rateBehaveour_;

		private RateMeWindow window_;

		private WindowsManager windowsManager_;

		private RateMeOnline rateMeOnline_;

		public event Action RateDone;

		public override void Init()
		{
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			rateMeOnline_ = new RateMeOnline();
			rateMeOnline_.RateResponseReceived += HandleRateResponseReceived;
		}

		public override void Dispose()
		{
			if (window_ != null)
			{
				window_.ClosedForNow -= HandleClosedForNow;
				window_.ClosedForever -= HandleClosedForever;
				window_.Rated -= HandleRated;
			}
		}

		private void HandleRateResponseReceived(RemoteMessageEventArgs obj)
		{
			BroadPurchaseOnline broadPurchaseOnline = SingletonManager.Get<BroadPurchaseOnline>();
			broadPurchaseOnline.Report(obj.remoteMessage as PurchaseMessage);
		}

		public void Rate()
		{
			if (window_ == null)
			{
				window_ = new RateMeWindow();
				window_.ClosedForNow += HandleClosedForNow;
				window_.ClosedForever += HandleClosedForever;
				window_.Rated += HandleRated;
				window_.Localize(0);
			}
			if (!window_.Visible)
			{
				windowsManager_.ToggleWindow(window_);
			}
		}

		private void CloseInSecond()
		{
			window_.ClosedForNow -= HandleClosedForNow;
			window_.ClosedForever -= HandleClosedForever;
			window_.Rated -= HandleRated;
			UnityTimerManager singlton;
			SingletonManager.Get<UnityTimerManager>(out singlton);
			UnityTimer unityTimer = singlton.SetTimer();
			unityTimer.Completeted += Close;
		}

		private void Close()
		{
			if (window_.Visible)
			{
				windowsManager_.ToggleWindow(window_);
			}
			window_.Dispose();
			window_ = null;
			switch (rateBehaveour_)
			{
			case RateBehaveour.RateMax:
				SendToMarket();
				break;
			}
			MessageBroadcaster.ReportInfo(Localisations.Get("UI_RateWindow_Thanks"), 0f);
			this.RateDone.SafeInvoke();
		}

		private void HandleClosedForever()
		{
			rateBehaveour_ = RateBehaveour.CloseForever;
			rateMeOnline_.SendRate(true);
			CloseInSecond();
		}

		private void HandleClosedForNow()
		{
			rateBehaveour_ = RateBehaveour.CloseForNow;
			rateMeOnline_.SendRate(false);
			CloseInSecond();
		}

		private void HandleRated(int value)
		{
			rateBehaveour_ = ((value != 5) ? RateBehaveour.RateFew : RateBehaveour.RateMax);
			rateMeOnline_.SendRate(false, value);
			CloseInSecond();
		}

		private void SendToMarket()
		{
			ContentLoaderModel contentLoaderModel = SingletonManager.Get<ContentLoaderModel>();
			Log.Info("OpenURL {0}", contentLoaderModel.rateUrlPath);
			Application.OpenURL(contentLoaderModel.rateUrlPath);
		}
	}
}

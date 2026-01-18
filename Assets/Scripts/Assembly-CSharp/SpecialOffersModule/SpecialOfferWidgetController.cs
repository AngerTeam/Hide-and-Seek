using System;
using CraftyEngine.Utils;
using HudSystem;
using NguiTools;
using UnityEngine;
using WindowsModule;

namespace SpecialOffersModule
{
	public class SpecialOfferWidgetController : IDisposable
	{
		private SpecialOfferWidgetHierarchy hierarchy_;

		private SpecialOffersManager specialOffersManager_;

		private PrefabsManagerNGUI prefabsManager_;

		private HudStateSwitcher hudStateSwitcher_;

		private UnityTimerManager unityTimerManager_;

		private UnityTimer specialOfferTimer_;

		public SpecialOfferWidgetController(GameObject parent)
		{
			SingletonManager.Get<SpecialOffersManager>(out specialOffersManager_);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			specialOffersManager_.ShowSpecialOffer += OnShowSpecialOffer;
			specialOffersManager_.HideSpecialOffer += OnHideSpecialOffer;
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<SpecialOfferWidgetHierarchy>("UISpecialOfferWidget", parent);
			hudStateSwitcher_.Register(16, parent);
			ButtonSet.Up(hierarchy_.button, SpecialOfferClicked, ButtonSetGroup.Hud);
			SetSpecialOffer();
		}

		private void SpecialOfferClicked()
		{
			WindowsManagerShortcut.ToggleWindow<SpecialOfferWindow>();
		}

		private void OnShowSpecialOffer(bool showFirstTime)
		{
			SetSpecialOffer();
		}

		private void SetSpecialOffer()
		{
			bool canShowCurrentSpecialOffer = specialOffersManager_.CanShowCurrentSpecialOffer;
			hierarchy_.widget.gameObject.SetActive(canShowCurrentSpecialOffer);
			if (canShowCurrentSpecialOffer)
			{
				hierarchy_.titleLabel.text = specialOffersManager_.CurrentOffer.entry.title;
				NguiFileManager singlton;
				SingletonManager.Get<NguiFileManager>(out singlton);
				singlton.SetUiTexture(hierarchy_.texture, specialOffersManager_.CurrentOffer.entry.GetFullIconPath());
				specialOfferTimer_ = unityTimerManager_.SetTimer();
				specialOfferTimer_.repeat = true;
				specialOfferTimer_.Completeted += OnSpecialOfferTimerTick;
				OnSpecialOfferTimerTick();
			}
		}

		private void OnSpecialOfferTimerTick()
		{
			hierarchy_.timerLabel.text = specialOffersManager_.GetCurrentOfferTime();
		}

		private void OnHideSpecialOffer()
		{
			if (hierarchy_ != null && hierarchy_.widget != null)
			{
				hierarchy_.widget.gameObject.SetActive(false);
			}
		}

		public void Dispose()
		{
			if (hierarchy_ != null)
			{
				UnityEngine.Object.Destroy(hierarchy_);
			}
			specialOffersManager_.ShowSpecialOffer -= OnShowSpecialOffer;
			specialOffersManager_.HideSpecialOffer -= OnHideSpecialOffer;
		}
	}
}

using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using NguiTools;
using UnityEngine;

namespace SplashesModule
{
	public class SplashScreenManager : PermanentSingleton
	{
		private GameObject anchor_;

		private GameObject connectionScreen_;

		private SplashScreen currentScreen_;

		private int dotsCounter_;

		private UnityTimer dotsTimer_;

		private NguiFileManager nguiFileManager_;

		private int lastScreen_;

		private NguiManager nguiManager_;

		private GameObject parent_;

		private PrefabsManagerNGUI prefabsManager_;

		private QueueManager queueManager_;

		private Dictionary<int, SplashScreen> screens_;

		public static string defaultSplashScreen = "UISplashScreen";

		public UIProgressBar Slider { get; set; }

		public SplashScreenManager()
		{
			screens_ = new Dictionary<int, SplashScreen>();
		}

		public SplashScreen CreateSplashScreen(int splashId, string prefab, string picture = null)
		{
			SplashScreen splashScreen = new SplashScreen();
			splashScreen.id = splashId;
			splashScreen.prefab = prefab;
			splashScreen.heirarchy = prefabsManager_.InstantiateNGUIIn<SplashScreenHierarchy>(prefab, parent_);
			splashScreen.gameObject = splashScreen.heirarchy.gameObject;
			screens_.Add(splashId, splashScreen);
			splashScreen.heirarchy.mainWidget.SetAnchor(anchor_, 0, 0, 0, 0);
			if (splashScreen.heirarchy.loadingLabel != null)
			{
				splashScreen.heirarchy.loadingLabel.gameObject.SetActive(true);
				splashScreen.heirarchy.loadingLabel.text = string.Empty;
			}
			if (splashScreen.heirarchy.sliderWidget != null)
			{
				splashScreen.slider = prefabsManager_.InstantiateNGUIIn<UIProgressBar>("UIProgressBar", splashScreen.heirarchy.sliderWidget.gameObject);
				splashScreen.slider.GetComponent<UIWidget>().SetAnchor(splashScreen.heirarchy.sliderWidget.gameObject, 0, 0, 0, 0);
				splashScreen.slider.gameObject.SetActive(true);
				splashScreen.slider.value = 0f;
			}
			if (!string.IsNullOrEmpty(picture) && splashScreen.heirarchy.splash != null && splashScreen.heirarchy.splash.mainTexture == null)
			{
				SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
				nguiFileManager_.SetUiTexture(splashScreen.heirarchy.splash, picture, queueManager_.DefaultQueue);
			}
			splashScreen.roller = new UiRoller(splashScreen.heirarchy.roller);
			splashScreen.gameObject.SetActive(false);
			UpdateSplashData(splashScreen);
			return splashScreen;
		}

		public override void Dispose()
		{
			StopDots();
			SetActiveCurrentScreen(false);
			currentScreen_ = null;
		}

		public void HideConnecting()
		{
			if (connectionScreen_ != null)
			{
				connectionScreen_.SetActive(false);
			}
		}

		public void HideScreen()
		{
			StopDots();
			SetActiveCurrentScreen(false);
			currentScreen_ = null;
			DataStorage.splashScreenVisible = false;
		}

		public override void Init()
		{
			currentScreen_ = null;
			SingletonManager.Get<QueueManager>(out queueManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			prefabsManager_.Load("SplashScreenPrefabHolder");
			Build();
		}

		public override void OnDataLoaded()
		{
			ShowDefaultScreen();
			UnityEvent.OnNextUpdate(SetDefaultTitle);
		}

		public void SetDefaultTitle()
		{
			SetTitle(Localisations.Get("UI_Loading"));
		}

		public void SetTitle(string value)
		{
			foreach (KeyValuePair<int, SplashScreen> item in screens_)
			{
				SplashScreen value2 = item.Value;
				value2.heirarchy.loadingLabel.text = value;
			}
		}

		public void ShowConnecting()
		{
			if (connectionScreen_ == null)
			{
				connectionScreen_ = prefabsManager_.InstantiateNGUIIn<Transform>("UIConnectingScreen", parent_).gameObject;
			}
			connectionScreen_.SetActive(true);
		}

		public void ShowDefaultScreen()
		{
			ShowScreen(lastScreen_);
		}

		public void ShowScreen(int splashId)
		{
			StopDots();
			if (currentScreen_ != null && currentScreen_.id != splashId)
			{
				SetActiveCurrentScreen(false);
				currentScreen_ = null;
			}
			if (currentScreen_ == null && !screens_.TryGetValue(splashId, out currentScreen_))
			{
				lastScreen_ = 0;
				currentScreen_ = screens_[lastScreen_];
			}
			SetActiveCurrentScreen(true);
			StartDots();
			DataStorage.splashScreenVisible = true;
		}

		private void Build()
		{
			if (!(parent_ != null))
			{
				parent_ = new GameObject("SplashScreenPanel");
				UIPanel uIPanel = parent_.AddComponent<UIPanel>();
				uIPanel.depth = 1001;
				parent_.layer = 5;
				parent_.transform.SetParent(nguiManager_.UiRoot.transform);
				parent_.transform.localScale = Vector3.one;
				anchor_ = nguiManager_.UiRoot.gameObject;
				CreateSplashScreen(0, defaultSplashScreen);
			}
		}

		private void SetActiveCurrentScreen(bool active)
		{
			if (currentScreen_ != null)
			{
				if (currentScreen_.gameObject != null)
				{
					currentScreen_.gameObject.SetActive(active);
				}
				if (active)
				{
					Slider = currentScreen_.slider;
					Slider.value = 0f;
				}
				else
				{
					Slider = null;
				}
			}
		}

		private void StartDots()
		{
			if (dotsTimer_ == null)
			{
				UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
				dotsTimer_ = unityTimerManager.SetTimer(0.5f);
				dotsTimer_.Completeted += UpdateLoadingIndicator;
				dotsTimer_.repeat = true;
			}
		}

		private void StopDots()
		{
			if (dotsTimer_ != null)
			{
				dotsTimer_.Stop();
				dotsTimer_ = null;
			}
		}

		private void UpdateLoadingIndicator()
		{
			if (currentScreen_ != null && currentScreen_.gameObject.activeSelf)
			{
				dotsCounter_++;
				int count = dotsCounter_ % 4;
				if (currentScreen_.heirarchy.loadingLabelDots != null)
				{
					currentScreen_.heirarchy.loadingLabelDots.text = new string('.', count);
				}
			}
		}

		private void UpdateSplashData(SplashScreen screen)
		{
			if (!(screen.heirarchy.labelsContainer != null))
			{
				return;
			}
			UILabel[] componentsInChildren = screen.heirarchy.labelsContainer.GetComponentsInChildren<UILabel>();
			if (componentsInChildren != null)
			{
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					componentsInChildren[i].text = Localisations.Get(componentsInChildren[i].text);
				}
			}
		}

		public void SetProgress(float progress)
		{
			if (Slider != null)
			{
				Slider.value = progress;
			}
		}
	}
}

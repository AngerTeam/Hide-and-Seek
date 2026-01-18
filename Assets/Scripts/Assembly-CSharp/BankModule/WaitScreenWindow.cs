using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using NguiTools;
using WindowsModule;

namespace BankModule
{
	public class WaitScreenWindow : GameWindow
	{
		private PrefabsManagerNGUI prefabsManager_;

		private UnityTimerManager unityTimerManager_;

		private WaitScreenHierarchy windowHierarchy_;

		private UnityTimer timer_;

		private float closingTime_ = 10f;

		private float currentTime_;

		public WaitScreenWindow()
			: base(false, false)
		{
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			prefabsManager_.Load("BankPrefabsHolder");
			windowHierarchy_ = prefabsManager_.InstantiateNGUIIn<WaitScreenHierarchy>("UIWaitScreen", nguiManager.UiRoot.gameObject);
			windowHierarchy_.widget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			windowHierarchy_.title.text = Localisations.Get("UI_Wait_Please");
			new UiRoller(windowHierarchy_.roller);
			SetContent(windowHierarchy_.transform, true, true, false, false, true);
			base.ViewChanged += OnViewChanged;
		}

		public void Show(bool show)
		{
			if (Visible != show)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void HandleTimer()
		{
			if (Visible)
			{
				currentTime_ += 1f;
				if (currentTime_ >= closingTime_)
				{
					Show(false);
				}
			}
		}

		private void OnViewChanged(object sender, BoolEventArguments e)
		{
			if (Visible)
			{
				currentTime_ = 0f;
				if (timer_ != null)
				{
					timer_.Completeted -= HandleTimer;
					timer_ = null;
				}
				timer_ = unityTimerManager_.SetTimer();
				timer_.repeat = true;
				timer_.Completeted += HandleTimer;
			}
			else
			{
				timer_.Stop();
				timer_.Completeted -= HandleTimer;
				timer_ = null;
			}
		}
	}
}

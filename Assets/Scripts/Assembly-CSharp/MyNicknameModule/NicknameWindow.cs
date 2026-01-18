using System;
using CraftyEngine.Infrastructure;
using HudSystem;
using NguiTools;
using PlayerModule.MyPlayer;
using WindowsModule;

namespace MyNicknameModule
{
	public class NicknameWindow : GameWindow
	{
		private MyNicknameManager myNicknameManager_;

		private NicknameWindowHierarchy windowHierarchy_;

		private MyPlayerStatsModel playerModel_;

		public NicknameWindow()
			: base(false)
		{
			base.ExclusiveGroup = 3;
			base.HudState = 41088;
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			SingletonManager.Get<MyNicknameManager>(out myNicknameManager_);
			myNicknameManager_.OnNicknameChanged += delegate
			{
				CloseWindow();
			};
			singlton.Load("NicknameModulePrefabHolder");
			windowHierarchy_ = singlton.InstantiateNGUIIn<NicknameWindowHierarchy>("UINicknameWindow", nguiManager.UiRoot.gameObject);
			windowHierarchy_.titleLabel.text = Localisations.Get("UI_Select_Nickname_Title");
			windowHierarchy_.okButtonLabel.text = Localisations.Get("UI_Set");
			windowHierarchy_.chooseMineButtonLabel.text = Localisations.Get("UI_Type_Yours");
			ButtonSet.Up(windowHierarchy_.okButton, SetNickname, ButtonSetGroup.InWindow);
			ButtonSet.Up(windowHierarchy_.chooseMineButton, InputNickname, ButtonSetGroup.InWindow);
			ButtonSet.Up(windowHierarchy_.rerollButton, RandomizeNickname, ButtonSetGroup.InWindow);
			windowHierarchy_.input.onChange.Clear();
			EventDelegate.Add(windowHierarchy_.input.onChange, NicknameChanged);
			SetContent(windowHierarchy_.gameObject.transform, true, true, false, false, true);
			base.ViewChanged += ViewUpdate;
		}

		private void ViewUpdate(object sender, BoolEventArguments e)
		{
			if (e.Value)
			{
				int nickLengthMax = MyNicknameManager.nickLengthMax;
				nickLengthMax = ((nickLengthMax != 0) ? Math.Min(nickLengthMax, 20) : 20);
				windowHierarchy_.input.characterLimit = nickLengthMax;
			}
		}

		private void NicknameChanged()
		{
			bool flag = windowHierarchy_.input.value.Length == 0;
			windowHierarchy_.chooseMineButton.isEnabled = flag;
			windowHierarchy_.chooseMineButton.gameObject.SetActive(flag);
		}

		private void SetNickname()
		{
			myNicknameManager_.TrySetNickname(windowHierarchy_.input.value);
		}

		private void RandomizeNickname()
		{
			windowHierarchy_.input.value = myNicknameManager_.GetRandomNickname();
			windowHierarchy_.chooseMineButton.isEnabled = true;
			windowHierarchy_.chooseMineButton.gameObject.SetActive(true);
		}

		private void InputNickname()
		{
			windowHierarchy_.input.value = string.Empty;
			windowHierarchy_.input.isSelected = true;
		}

		public void OpenWindow(bool useCloseButton)
		{
			if (string.IsNullOrEmpty(playerModel_.stats.nickname))
			{
				RandomizeNickname();
			}
			else
			{
				windowHierarchy_.input.value = playerModel_.stats.nickname;
			}
			base.Hierarchy.closeButton.gameObject.SetActive(useCloseButton);
			OpenWindow();
		}

		private void CloseWindow()
		{
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void OpenWindow()
		{
			if (!Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}
	}
}

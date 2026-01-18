using System;
using CraftyEngine.Infrastructure;
using Extensions;
using HudSystem;
using MyPlayerInput;
using NguiTools;
using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorHud : GuiModlule
	{
		public UiRoller roller;

		private ActionButtonsManager actionButtonsManager_;

		private VoxelEditorButtonHierarchy buildButton_;

		private VoxelEditorButtonContainerHierarchy buttonsContainer_;

		private ActionButtonHierarchy digButton_;

		private VoxelEditorHudHierarchy hierarchy_;

		private HudStateSwitcher hudStateSwitcher_;

		private NguiManager nguiManager_;

		private VoxelEditorButtonHierarchy pipetButton_;

		private PrefabsManagerNGUI prefabsManager_;

		private int steps_;

		private UnityEvent unityEvent_;

		private UIWidget[] widgets_;

		public event Action BuildButtonClicked;

		public event Action ClipButtonClicked;

		public event Action DigButtonPressed;

		public event Action DigButtonReleased;

		public event Action FlyButtonClicked;

		public event Action PipetButtonClicked;

		public event Action SaveButtonClicked;

		public VoxelEditorHud()
		{
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
			prefabsManager_.Load("CraftyVoxelEngineEditorPrefabsHolder");
			prefabsManager_.Load("CraftyVoxelEngineEditorUiPrefabsHolder");
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<VoxelEditorHudHierarchy>("EditorHud", nguiManager_.UiRoot.gameObject);
			hierarchy_.gameObject.SetActive(false);
			hierarchy_.widget.leftAnchor.target = nguiManager_.UiRoot.transform;
			hierarchy_.widget.rightAnchor.target = nguiManager_.UiRoot.transform;
			hierarchy_.widget.topAnchor.target = nguiManager_.UiRoot.transform;
			hierarchy_.widget.bottomAnchor.target = nguiManager_.UiRoot.transform;
			InstantiateButtons();
			roller = new UiRoller(hierarchy_.rollerAncor);
			hierarchy_.saveInformer.gameObject.SetActive(false);
		}

		public override void Dispose()
		{
			roller.Dispose();
			UnityEngine.Object.Destroy(hierarchy_.gameObject);
			this.FlyButtonClicked = null;
			this.ClipButtonClicked = null;
			this.SaveButtonClicked = null;
			this.DigButtonPressed = null;
			this.DigButtonReleased = null;
			this.BuildButtonClicked = null;
			this.PipetButtonClicked = null;
			UnityEngine.Object.Destroy(buttonsContainer_.gameObject);
		}

		public void HideSaveInformer()
		{
			hierarchy_.saveInformer.gameObject.SetActive(false);
		}

		public void MarkClipButton(bool value)
		{
			hierarchy_.NoClipButton.icon.gameObject.SetActive(!value);
		}

		public void MarkFlyButton(bool value)
		{
			hierarchy_.FlyButton.icon.gameObject.SetActive(value);
		}

		public void SetActive(bool value)
		{
			hierarchy_.gameObject.SetActive(value);
		}

		public void ShowSaveInformer()
		{
			hierarchy_.saveInformer.gameObject.SetActive(true);
		}

		private void InstantiateButtons()
		{
			ButtonSet.Up(hierarchy_.FlyButton.button, delegate
			{
				this.FlyButtonClicked.SafeInvoke();
			}, ButtonSetGroup.Hud);
			ButtonSet.Up(hierarchy_.NoClipButton.button, delegate
			{
				this.ClipButtonClicked.SafeInvoke();
			}, ButtonSetGroup.Hud);
			ButtonSet.Up(hierarchy_.SaveButton.button, delegate
			{
				this.SaveButtonClicked.SafeInvoke();
			}, ButtonSetGroup.Hud);
			hierarchy_.SaveButton.label.text = Localisations.Get("Save_Button");
			hierarchy_.FlyButton.label.text = Localisations.Get("FlyMode");
			hierarchy_.NoClipButton.label.text = Localisations.Get("ClipMode");
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			widgets_ = new UIWidget[3];
			widgets_[0] = hierarchy_.SaveButton.label;
			widgets_[1] = hierarchy_.FlyButton.label;
			widgets_[2] = hierarchy_.NoClipButton.label;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			buttonsContainer_ = prefabsManager_.InstantiateNGUIIn<VoxelEditorButtonContainerHierarchy>("VoxelEditorButtonsContainer", nguiManager_.UiRoot.gameObject);
			buttonsContainer_.container.SetAnchor(nguiManager_.UiRoot.gameObject, 1f, 0, 0f, 0, 1f, 0, 0f, 0);
			buildButton_ = prefabsManager_.InstantiateNGUIIn<VoxelEditorButtonHierarchy>("BuildButton", buttonsContainer_.containers[0].gameObject);
			digButton_ = prefabsManager_.InstantiateNGUIIn<ActionButtonHierarchy>("DigButton", buttonsContainer_.containers[1].gameObject);
			pipetButton_ = prefabsManager_.InstantiateNGUIIn<VoxelEditorButtonHierarchy>("PipetButton", buttonsContainer_.containers[2].gameObject);
			buildButton_.gameObject.tag = "NGUIIgnoreLock";
			pipetButton_.gameObject.tag = "NGUIIgnoreLock";
			actionButtonsManager_ = new ActionButtonsManager();
			actionButtonsManager_.AddButton(digButton_, delegate
			{
				this.DigButtonPressed.SafeInvoke();
			}, delegate
			{
				this.DigButtonReleased.SafeInvoke();
			});
			ButtonSet.Up(buildButton_.button, delegate
			{
				this.BuildButtonClicked.SafeInvoke();
			}, ButtonSetGroup.Hud);
			ButtonSet.Up(pipetButton_.button, delegate
			{
				this.PipetButtonClicked.SafeInvoke();
			}, ButtonSetGroup.Hud);
			hudStateSwitcher_.Register(67108864, hierarchy_);
			hudStateSwitcher_.Register(67108864, digButton_);
			hudStateSwitcher_.Register(67108864, buildButton_);
			hudStateSwitcher_.Register(67108864, pipetButton_);
		}

		private void Update()
		{
			if (steps_ < 20)
			{
				steps_++;
			}
			if (steps_ == 3)
			{
				DistributeWidgets.Distribute(30f, widgets_);
			}
			if (steps_ == 19)
			{
				UIWidget[] array = widgets_;
				foreach (UIWidget uIWidget in array)
				{
					UILabel uILabel = uIWidget as UILabel;
					uILabel.overflowMethod = UILabel.Overflow.ShrinkContent;
				}
			}
			if (steps_ == 20)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
		}
	}
}

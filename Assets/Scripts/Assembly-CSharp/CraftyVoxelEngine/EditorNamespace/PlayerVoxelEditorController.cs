using HudSystem;
using PopUpModule;
using WeaponSightsModule;

namespace CraftyVoxelEngine.Editor
{
	public class PlayerVoxelEditorController : Singleton
	{
		private VoxelEditorHud voxelEditorHud_;

		private PopUpManager popUpManager_;

		private VoxelInteraction voxelInteraction_;

		private VoxelEditorController editorController_;

		private CrosshairHud crosshairHud_;

		public VoxelEditorController EditorController
		{
			get
			{
				return editorController_;
			}
			set
			{
				editorController_ = value;
				InitHud();
			}
		}

		public override void Init()
		{
			if (voxelEditorHud_ == null)
			{
				voxelEditorHud_ = new VoxelEditorHud();
			}
			SingletonManager.Get<PopUpManager>(out popUpManager_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
			GuiModuleHolder.TryGet<CrosshairHud>(out crosshairHud_);
			voxelInteraction_.model.inputEnabled = false;
		}

		public override void OnDataLoaded()
		{
			crosshairHud_.SetCrosshairLegacyIcon(false);
		}

		public void Start()
		{
			voxelInteraction_.model.inputEnabled = false;
			voxelEditorHud_.DigButtonPressed += StartDoDig;
			voxelEditorHud_.DigButtonReleased += StopDoDig;
			voxelEditorHud_.BuildButtonClicked += DoBuild;
		}

		public override void Dispose()
		{
			if (voxelEditorHud_ != null)
			{
				voxelEditorHud_.DigButtonPressed -= StartDoDig;
				voxelEditorHud_.DigButtonReleased -= StopDoDig;
				voxelEditorHud_.BuildButtonClicked -= DoBuild;
				voxelInteraction_.model.inputEnabled = true;
				voxelEditorHud_.Dispose();
				voxelEditorHud_ = null;
			}
		}

		private void StartDoDig()
		{
			voxelInteraction_.model.Digging = true;
		}

		private void StopDoDig()
		{
			voxelInteraction_.model.Digging = false;
		}

		private void DoBuild()
		{
			voxelInteraction_.input.HandleClick(true);
		}

		private void InitHud()
		{
			voxelEditorHud_.FlyButtonClicked += ToggleFly;
			voxelEditorHud_.ClipButtonClicked += ToggleClip;
			voxelEditorHud_.SaveButtonClicked += editorController_.Save;
			voxelEditorHud_.PipetButtonClicked += editorController_.Pippet;
			voxelEditorHud_.SetActive(true);
			editorController_.voxelFilesManager.BeginSaving += BeginSaving;
			editorController_.voxelFilesManager.MapSaved += EndSaving;
			editorController_.voxelFilesManager.BoxSaved += EndSaving;
			voxelEditorHud_.MarkFlyButton(true);
			voxelEditorHud_.MarkClipButton(true);
		}

		private void ToggleFly()
		{
			bool value = editorController_.ToggleFlyMode();
			voxelEditorHud_.MarkFlyButton(value);
		}

		private void ToggleClip()
		{
			bool value = editorController_.ToggleClipMode();
			voxelEditorHud_.MarkClipButton(value);
		}

		private void BeginSaving()
		{
			voxelEditorHud_.ShowSaveInformer();
		}

		private void EndSaving(string path)
		{
			voxelEditorHud_.HideSaveInformer();
			popUpManager_.AddMessage(Localisations.Get("EditorMessage_MapSaved"));
		}
	}
}

using System;
using GameInfrastructure;
using HudSystem;
using WeaponSightsModule;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditor : IDisposable
	{
		public VoxelEditorModel model;

		public VoxelEditorController editorController;

		public DeveloperVoxelEditorController developerController;

		public PlayerVoxelEditorController playerController;

		public VoxelEditorSpawnsValidator spawnsValidator;

		public VoxelFilesManager voxelFilesManager;

		public LevelController levelController;

		public VoxelEngine voxelEngine;

		private VoxelInteractionModel voxelInteractionModel_;

		private VoxelInventoryModel voxelInventoryModel_;

		public void Init()
		{
			SingletonManager.Get<VoxelEditorModel>(out model);
			SingletonManager.Get<VoxelEngine>(out voxelEngine);
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			SingletonManager.Get<VoxelInventoryModel>(out voxelInventoryModel_);
			voxelFilesManager = new VoxelFilesManager();
			editorController = new VoxelEditorController();
			developerController = new DeveloperVoxelEditorController();
			spawnsValidator = new VoxelEditorSpawnsValidator();
			editorController.voxelFilesManager = voxelFilesManager;
			editorController.Init();
			editorController.validator = spawnsValidator;
			developerController.editorController = editorController;
			if (model.developer)
			{
				CrosshairHud crosshairHud = GuiModuleHolder.Get<CrosshairHud>();
				crosshairHud.SetCrosshairLegacyIcon(false);
				developerController.Init();
			}
			else
			{
				SingletonManager.Get<PlayerVoxelEditorController>(out playerController);
				playerController.EditorController = editorController;
				playerController.Init();
				playerController.Start();
			}
			GuiModuleHolder.Add<EditorBeltHud>();
			GuiModuleHolder.Add<EditorInventoryWindow>();
			editorController.PippetEvent += HandlePippetEvent;
			voxelEngine.Settings.SetRenderLogicVoxel(true);
			voxelInteractionModel_.allowDig = true;
			voxelInteractionModel_.allowBuild = true;
			voxelInteractionModel_.selectedItemDistance = 30f;
		}

		private void HandlePippetEvent(int artikilId)
		{
			voxelInventoryModel_.SetCurrentArticul(artikilId);
		}

		public void Dispose()
		{
			developerController.Dispose();
			if (playerController != null)
			{
				playerController.Dispose();
			}
			editorController.Dispose();
			GuiModuleHolder.Remove<EditorBeltHud>();
			GuiModuleHolder.Remove<EditorInventoryWindow>();
			voxelEngine.Settings.SetRenderLogicVoxel(false);
		}
	}
}

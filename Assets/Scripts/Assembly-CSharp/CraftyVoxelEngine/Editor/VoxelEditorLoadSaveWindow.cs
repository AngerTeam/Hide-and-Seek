using System;
using System.IO;
using CraftyEngine.Infrastructure;
using Extensions;
using HudSystem;
using MyPlayerInput;
using NguiTools;
using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorLoadSaveWindow
	{
		private InputModel inputManager_;

		private MyPlayerInputModel inputModel_;

		private MouseCursorManager mouseCursorManager_;

		private VoxelLoadSaveHierarchy hierarchy_;

		private VoxelInteractionModel voxelInteractionModel_;

		private HudStateSwitcher hudStateSwitcher;

		public event Action<string> load;

		public event Action<string> save;

		public VoxelEditorLoadSaveWindow()
		{
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			SingletonManager.Get<InputModel>(out inputManager_);
			NguiManager singlton;
			SingletonManager.Get<NguiManager>(out singlton);
			PrefabsManagerNGUI singlton2;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton2);
			SingletonManager.Get<MouseCursorManager>(out mouseCursorManager_);
			SingletonManager.Get<MyPlayerInputModel>(out inputModel_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher);
			singlton2.Load("CraftyVoxelEngineEditorUiPrefabsHolder");
			hierarchy_ = singlton2.InstantiateNGUIIn<VoxelLoadSaveHierarchy>("UILoadSaveVoxelBoxes", singlton.UiRoot.gameObject);
			EventDelegate.Set(hierarchy_.SaveButton.onClick, Save);
			hudStateSwitcher.SwitchHighest(0);
		}

		private void CreateItem(string file)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(hierarchy_.LoadItemPrefab);
			gameObject.transform.SetParent(hierarchy_.LoadTable.transform);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = Vector3.one;
			UILabel componentInChildren = gameObject.GetComponentInChildren<UILabel>();
			componentInChildren.text = Path.GetFileNameWithoutExtension(file);
			UIButton componentInChildren2 = gameObject.GetComponentInChildren<UIButton>();
			EventDelegate.Set(componentInChildren2.onClick, delegate
			{
				Load(file);
			});
		}

		public void ShowInfo(string info = "No information message!")
		{
			LockInput(true);
			hierarchy_.InfoLabel.text = info;
			hierarchy_.gameObject.SetActive(true);
			hierarchy_.InfoLabel.gameObject.SetActive(true);
			hierarchy_.LoadWidget.gameObject.SetActive(false);
			hierarchy_.SaveWidget.gameObject.SetActive(false);
		}

		private void LockInput(bool value)
		{
			hudStateSwitcher.SwitchHighest((!value) ? 67117057 : 0);
			voxelInteractionModel_.interactionEnabled = !value;
			inputManager_.allowHotkeyProcess = !value;
			inputModel_.EnabledByUi = !value;
			mouseCursorManager_.visibleByGameState = value;
		}

		public void ShowLoad()
		{
			LockInput(true);
			hierarchy_.gameObject.SetActive(true);
			hierarchy_.InfoLabel.gameObject.SetActive(false);
			hierarchy_.LoadWidget.gameObject.SetActive(true);
			hierarchy_.SaveWidget.gameObject.SetActive(false);
		}

		public void ShowSave(string name = "NewFile")
		{
			LockInput(true);
			hierarchy_.SaveName.value = name;
			hierarchy_.gameObject.SetActive(true);
			hierarchy_.InfoLabel.gameObject.SetActive(false);
			hierarchy_.LoadWidget.gameObject.SetActive(false);
			hierarchy_.SaveWidget.gameObject.SetActive(true);
		}

		public void Hide()
		{
			LockInput(false);
			hierarchy_.gameObject.SetActive(false);
		}

		public void SetItems(string[] files)
		{
			try
			{
				foreach (Transform item in hierarchy_.LoadTable.transform)
				{
					UnityEngine.Object.Destroy(item.gameObject);
				}
			}
			catch (Exception ex)
			{
				Log.Error("SetItems Exception:\n" + ex.ToString());
			}
			for (int i = 0; i < files.Length; i++)
			{
				CreateItem(files[i]);
			}
			hierarchy_.LoadTable.Reposition();
			hierarchy_.LoadScrollView.ResetPosition();
		}

		private void Load(string file)
		{
			Hide();
			this.load.SafeInvoke(file);
		}

		private void Save()
		{
			Hide();
			this.save.SafeInvoke(hierarchy_.SaveName.value);
		}
	}
}

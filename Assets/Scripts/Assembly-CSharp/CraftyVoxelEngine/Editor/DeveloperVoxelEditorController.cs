using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine.FX;
using UnityEngine;
using WindowsModule;

namespace CraftyVoxelEngine.Editor
{
	public class DeveloperVoxelEditorController : IDisposable
	{
		private UnityEvent unityEvent_;

		private CameraManager cameraManager_;

		private VoxelInteraction voxelInteraction_;

		private InputManager inputManager_;

		private VoxelEngine voxelEngine_;

		private VoxelEditorSizeBorder border_;

		public VoxelEditorController editorController;

		public VoxelKey currentKey;

		public VoxelCursor cursor;

		public VoxelBoxHolder currentHolder;

		public VoxelSelector selector;

		public GameObject SphereCursor;

		public GameObject BoxCursor;

		public float cursorDistance = 5f;

		private bool enableOnSave_;

		public bool controlEnabled = true;

		private int replaceVoxel;

		private GameObject frameNormal_;

		private GameObject frameBig_;

		private VoxelEditorModel model_;

		public bool SelectionMode { get; private set; }

		public int FillMode { get; private set; }

		public bool FigureMode { get; private set; }

		public event Action<int> SelectVoxel;

		public event Action<VoxelKey> TeleportToVoxel;

		public DeveloperVoxelEditorController()
		{
			SingletonManager.Get<VoxelEditorModel>(out model_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
			SingletonManager.Get<InputManager>(out inputManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			cursor = new VoxelCursor();
			selector = new VoxelSelector();
			currentHolder = new VoxelBoxHolder(voxelEngine_);
			voxelEngine_.ViewManager.rendRange = 510f;
			voxelEngine_.ViewManager.viewRange = 500f;
			voxelEngine_.voxelActions.SetViewDistance(510f, 500f, null);
			PrefabsManager singlton;
			SingletonManager.Get<PrefabsManager>(out singlton);
			singlton.Load("CraftyVoxelEngineEditorPrefabsHolder");
			SphereCursor = singlton.Instantiate("EditorSphere");
			SphereCursor.SetActive(false);
			UnityEngine.Object.DontDestroyOnLoad(SphereCursor);
			BoxCursor = singlton.Instantiate("FullCursor");
			BoxCursor.SetActive(false);
			UnityEngine.Object.DontDestroyOnLoad(BoxCursor);
			frameNormal_ = singlton.Instantiate("FrameNormal");
			frameBig_ = singlton.Instantiate("FrameBig");
			frameNormal_.gameObject.SetActive(false);
			frameBig_.gameObject.SetActive(false);
			model_.FrameModeToggled += ToggleFrame;
		}

		private void ToggleFrame()
		{
			if (frameBig_.gameObject.activeSelf)
			{
				frameBig_.SetActive(false);
			}
			else if (frameNormal_.gameObject.activeSelf)
			{
				frameNormal_.SetActive(false);
				frameBig_.SetActive(true);
			}
			else
			{
				frameNormal_.SetActive(true);
			}
		}

		public void Init()
		{
			inputManager_.PointerClicked += Click;
			inputManager_.Scroll += Scroll;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			editorController.voxelFilesManager.BoxSaved += EnableOnSave;
			editorController.voxelFilesManager.MapSaved += EnableOnSave;
		}

		private void EnableOnSave(string path)
		{
			if (enableOnSave_)
			{
				enableOnSave_ = false;
				controlEnabled = true;
			}
		}

		private void DisableUntilSaved()
		{
			enableOnSave_ = true;
			controlEnabled = false;
		}

		public void Dispose()
		{
			inputManager_.PointerClicked -= Click;
			inputManager_.Scroll -= Scroll;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			UnityEngine.Object.Destroy(frameNormal_);
			UnityEngine.Object.Destroy(frameBig_);
			UnityEngine.Object.Destroy(SphereCursor);
			UnityEngine.Object.Destroy(BoxCursor);
		}

		private void Scroll(object s, InputEventArgs args)
		{
			cursorDistance += args.scrollDelta;
			cursorDistance = Mathf.Clamp(cursorDistance, 1f, 50f);
		}

		public void Update()
		{
			if (!controlEnabled)
			{
				return;
			}
			if (voxelInteraction_.model.rayHitSuccess)
			{
				currentKey = voxelInteraction_.model.globalKey;
				cursor.HideCursor();
			}
			else
			{
				UpdateCursor();
			}
			if (SphereCursor != null)
			{
				SphereCursor.transform.position = currentKey.ToVector() + Vector3.one * 0.5f;
				SphereCursor.transform.localScale = Mathf.Max(1f, cursorDistance * 2f) * Vector3.one;
			}
			if (BoxCursor != null)
			{
				BoxCursor.transform.position = currentKey.ToVector() + Vector3.one * 0.5f;
				BoxCursor.transform.localScale = Mathf.Max(1f, cursorDistance * 2f) * Vector3.one;
			}
			if (Input.GetKeyDown(KeyCode.RightBracket))
			{
				voxelEngine_.UpdateOAPower(0.05f);
			}
			if (Input.GetKeyDown(KeyCode.LeftBracket))
			{
				voxelEngine_.UpdateOAPower(-0.05f);
			}
			ToggleBorder();
			if (Input.GetKeyDown(KeyCode.Z))
			{
				FillMode = (FillMode + 1) % 3;
				SphereCursor.SetActive(FillMode == 1);
				BoxCursor.SetActive(FillMode == 2);
			}
			if (Input.GetKeyDown(KeyCode.F))
			{
				editorController.ToggleFlyMode();
			}
			if (Input.GetKeyDown(KeyCode.N))
			{
				editorController.ToggleClipMode();
			}
			if (Input.GetKeyDown(KeyCode.M))
			{
				editorController.voxelFilesManager.SaveMapDialog();
				DisableUntilSaved();
			}
			if (Input.GetKeyDown(KeyCode.O))
			{
				DialogWindowManager singlton;
				SingletonManager.Get<DialogWindowManager>(out singlton);
				singlton.ShowDialogue("Сохранить текущую карту?", delegate
				{
					editorController.SaveEndExit();
				}, delegate
				{
					editorController.InvokeCompleted();
				}, "Да", "Нет");
			}
			SelectionMode = Input.GetKey(KeyCode.Tab) || Input.GetKey(KeyCode.Backspace);
			voxelInteraction_.model.allowBuild = !SelectionMode;
			RaycastHit? raycastHit = Raycast();
			if (selector != null && raycastHit.HasValue)
			{
				bool holder = selector.Holder;
				bool access = selector.Access;
				if (!holder)
				{
					if (Input.GetKeyDown(KeyCode.Keypad1))
					{
						selector.Expand(raycastHit.Value);
					}
					if (Input.GetKeyDown(KeyCode.Keypad4))
					{
						selector.Constrict(raycastHit.Value);
					}
				}
				if (Input.GetKeyDown(KeyCode.Keypad2))
				{
					selector.Pull(raycastHit.Value);
				}
				if (Input.GetKeyDown(KeyCode.Keypad5))
				{
					selector.Push(raycastHit.Value);
				}
				if (holder && !access)
				{
					int sideByNormal = BoxSide.GetSideByNormal(raycastHit.Value.normal);
					if (Input.GetKeyDown(KeyCode.Keypad3))
					{
						RotateHolder(sideByNormal);
					}
					if (Input.GetKeyDown(KeyCode.Keypad6))
					{
						RotateHolder(BoxSide.mirror[sideByNormal]);
					}
					if (Input.GetKeyDown(KeyCode.Keypad0))
					{
						switch (sideByNormal)
						{
						case 0:
						case 1:
							currentHolder.MirrorX();
							break;
						case 2:
						case 3:
							currentHolder.MirrorY();
							break;
						case 4:
						case 5:
							currentHolder.MirrorZ();
							break;
						}
					}
				}
			}
			if (Input.GetKeyDown(KeyCode.KeypadMultiply))
			{
				selector.SetPosition(new VoxelKey(0, 0, 0));
				selector.SetPosition(new VoxelKey(255, 255, 255));
			}
			if (Input.GetKeyDown(KeyCode.PageUp))
			{
				selector.Holder = true;
				VoxelKey voxelKey = VoxelKey.Min(selector.region.min, selector.region.max);
				VoxelKey voxelKey2 = VoxelKey.Max(selector.region.min, selector.region.max);
				selector.region.Set(voxelKey, voxelKey2);
				currentHolder.GetFrom(voxelKey, voxelKey2 - voxelKey + 1);
			}
			if (currentHolder.Filled)
			{
				selector.SetScale(currentHolder.scale - 1);
				if (Input.GetKeyDown(KeyCode.PageDown))
				{
					if (Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
					{
						currentHolder.SetTo(selector.region.min);
					}
					else
					{
						currentHolder.SetTo(selector.region.min, true);
					}
				}
				if (Input.GetKeyDown(KeyCode.KeypadPlus))
				{
					editorController.voxelFilesManager.SaveBoxDialog(currentHolder);
					DisableUntilSaved();
				}
			}
			if (Input.GetKeyDown(KeyCode.KeypadMinus))
			{
				editorController.voxelFilesManager.LoadBoxDialog(currentHolder);
			}
			if (Input.GetKeyDown(KeyCode.Insert) || Input.GetKeyDown(KeyCode.I))
			{
				voxelEngine_.FillRegion(selector.region, voxelInteraction_.model.buildVoxelId);
			}
			if (Input.GetKeyDown(KeyCode.Delete))
			{
				voxelEngine_.FillRegion(selector.region, 0);
			}
			if (Input.GetKeyDown(KeyCode.Home))
			{
				replaceVoxel = voxelInteraction_.model.buildVoxelId;
				model_.SelectSwitchSlot();
			}
			if (Input.GetKeyDown(KeyCode.End))
			{
				int buildVoxelId = voxelInteraction_.model.buildVoxelId;
				voxelEngine_.ReplaceRegion(selector.region, replaceVoxel, buildVoxelId);
				replaceVoxel = buildVoxelId;
			}
			if (Input.GetMouseButtonDown(2))
			{
				if (Input.GetKey(KeyCode.RightShift) || Input.GetKey(KeyCode.LeftShift))
				{
					editorController.Teleport();
				}
				else
				{
					editorController.Pippet();
				}
			}
		}

		private void ToggleBorder()
		{
			if (Input.GetKeyUp(KeyCode.B))
			{
				if (border_ == null)
				{
					border_ = new VoxelEditorSizeBorder(256);
					return;
				}
				border_.Dispose();
				border_ = null;
			}
		}

		private void RotateHolder(int side)
		{
			switch (side)
			{
			case 0:
				currentHolder.RotateXplus90();
				break;
			case 1:
				currentHolder.RotateXminus90();
				break;
			case 2:
				currentHolder.RotateYplus90();
				break;
			case 3:
				currentHolder.RotateYminus90();
				break;
			case 4:
				currentHolder.RotateZplus90();
				break;
			case 5:
				currentHolder.RotateZminus90();
				break;
			}
		}

		private void UpdateCursor()
		{
			Vector3 zero = Vector3.zero;
			zero += cameraManager_.PlayerCamera.transform.position;
			zero += cameraManager_.PlayerCamera.transform.forward * cursorDistance * 2f;
			currentKey.Set(zero);
			if (SelectionMode)
			{
				cursor.Set(currentKey);
			}
			else
			{
				cursor.HideCursor();
			}
		}

		private void Click(object o, InputEventArgs args)
		{
			if (SelectionMode)
			{
				selector.SetPosition(currentKey);
				selector.Holder = false;
				if (currentHolder.Filled)
				{
					currentHolder.Clear();
					selector.SetPosition(currentKey);
				}
				args.used = true;
			}
			if (FillMode == 1)
			{
				voxelEngine_.FillSphere(currentKey, cursorDistance, voxelInteraction_.model.buildVoxelId);
				args.used = true;
			}
			if (FillMode == 2)
			{
				voxelEngine_.FillRegion(currentKey - (int)cursorDistance, currentKey + (int)cursorDistance, voxelInteraction_.model.buildVoxelId);
				args.used = true;
			}
		}

		public RaycastHit? Raycast()
		{
			RaycastHit hitInfo;
			if (Physics.Raycast(cameraManager_.PlayerCamera.transform.position, cameraManager_.PlayerCamera.transform.forward, out hitInfo))
			{
				return hitInfo;
			}
			return null;
		}
	}
}

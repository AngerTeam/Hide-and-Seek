using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using NguiTools;
using UnityEngine;

namespace ChestsViewModule
{
	public class UI3DView : IDisposable
	{
		public static int UniqueLayer;

		public static GameObject UI3DHolder;

		private PrefabsManagerNGUI prefabsManager_;

		private UnityTouchScreenKeyboardTracker keyboardTracker_;

		private UnityEvent unityEvent_;

		public GameObject modelHolder;

		protected UI3DHierarchy hierarchy_;

		private bool autoUpdate_;

		public bool CurrentState { get; private set; }

		public bool LastState { get; private set; }

		public int Layer { get; private set; }

		public UI3DView(GameObject prefabInstance, float scale = 1f, bool autoUpdate = true)
		{
			Layer = 16;
			autoUpdate_ = autoUpdate;
			if (UI3DHolder == null)
			{
				UI3DHolder = new GameObject("UI3DHolder");
			}
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<UnityTouchScreenKeyboardTracker>(out keyboardTracker_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			prefabsManager_.Load("UI3DPrefabHolder");
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<UI3DHierarchy>("UI3DView", UI3DHolder);
			UniqueLayer++;
			hierarchy_.transform.position = new Vector3(0f, 100 + 50 * UniqueLayer, 0f);
			hierarchy_.ui3dCamera.cullingMask = 65536;
			hierarchy_.ui3dCamera.depth = 7f;
			hierarchy_.ui3dCamera.backgroundColor = UnityEngine.Random.ColorHSV(0f, 1f, 0.3f, 0.9f, 0.7f, 1f);
			hierarchy_.ui3dCamera.orthographic = !UI3DHierarchy.Perspective;
			modelHolder = hierarchy_.root.gameObject;
			prefabInstance.transform.SetParent(modelHolder.transform, false);
			prefabInstance.transform.localScale *= scale;
			GameObjectUtils.SetLayer(prefabInstance, Layer);
			keyboardTracker_.ChangeVisibility += HandleKeyboardVisibility;
			if (autoUpdate_)
			{
				unityEvent_.Subscribe(UnityEventType.Update, Update);
			}
		}

		public void Dispose()
		{
			if (autoUpdate_)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
			keyboardTracker_.ChangeVisibility -= HandleKeyboardVisibility;
			if (modelHolder != null)
			{
				UnityEngine.Object.Destroy(modelHolder.gameObject);
				modelHolder = null;
			}
			UnityEngine.Object.Destroy(hierarchy_.Ancor.gameObject);
			UnityEngine.Object.Destroy(hierarchy_.gameObject);
		}

		public void SwitchActive(bool active)
		{
			if (!(modelHolder != null) || !(hierarchy_ != null))
			{
				return;
			}
			modelHolder.gameObject.SetActive(active);
			hierarchy_.ui3dCamera.gameObject.SetActive(active);
			CurrentState = active;
			if (active)
			{
				Update();
				if (!autoUpdate_)
				{
					modelHolder.gameObject.SetActive(false);
					hierarchy_.ui3dCamera.gameObject.SetActive(false);
				}
			}
		}

		public virtual void SetParent(Transform parent, bool zeroPosition = false, bool ancor = true)
		{
			hierarchy_.Ancor.transform.SetParent(parent);
			hierarchy_.Ancor.gameObject.layer = parent.gameObject.layer;
			hierarchy_.AncorLB.gameObject.layer = parent.gameObject.layer;
			hierarchy_.AncorRT.gameObject.layer = parent.gameObject.layer;
			if (zeroPosition)
			{
				hierarchy_.Ancor.transform.localPosition = Vector3.zero;
			}
			hierarchy_.Ancor.transform.localScale = Vector3.one;
			if (ancor)
			{
				UIWidget component = hierarchy_.Ancor.GetComponent<UIWidget>();
				component.SetAnchor(parent);
			}
		}

		protected virtual void Update()
		{
			if (!(UICamera.currentCamera == null) && !(hierarchy_ == null) && !(hierarchy_.Ancor == null) && !(hierarchy_.Ancor.gameObject == null) && !(modelHolder == null) && !(modelHolder.gameObject == null) && modelHolder.gameObject.activeInHierarchy)
			{
				NGUITools.UpdateWidgetCollider(hierarchy_.Ancor.gameObject);
				hierarchy_.UpdateAncors();
				Vector3 vector = UICamera.currentCamera.WorldToScreenPoint(hierarchy_.AncorLB.position);
				Vector3 vector2 = UICamera.currentCamera.WorldToScreenPoint(hierarchy_.AncorRT.position);
				SetRect(vector.x, vector.y, vector2.x, vector2.y);
			}
		}

		private void SetRect(float xMin, float yMin, float xMax, float yMax)
		{
			Rect pixelRect = new Rect(xMin, yMin, xMax - xMin, yMax - yMin);
			hierarchy_.ui3dCamera.pixelRect = pixelRect;
		}

		public void SetCameraDistance(float distance = 2.2f, float height = -0.3f)
		{
			Transform root = hierarchy_.root;
			Vector3 localPosition = root.localPosition;
			localPosition.z = distance;
			localPosition.y = height;
			root.localPosition = localPosition;
		}

		private void HandleKeyboardVisibility(bool visible)
		{
			if (visible)
			{
				LastState = CurrentState;
				SwitchActive(false);
			}
			else
			{
				SwitchActive(LastState);
			}
		}
	}
}

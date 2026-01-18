using System;
using System.Runtime.InteropServices;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine.FX
{
	public class VoxelCursor
	{
		private GameObject borderCursor_;

		private GameObject hiderCursor_;

		private GameObject fullCursor_;

		private VoxelEngine voxelEngine_;

		private InputModel inputManager_;

		private PrefabsManager prefabsManager_;

		private float minBrightness = 1f / 128f;

		private float maxBrightness = 0.25f;

		private Material material;

		private bool rainbowLock;

		public bool isVoxelInHand;

		public VoxelCursor()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			prefabsManager_.Load("CraftyVoxelEngineRuntimePrefabsHolder");
			borderCursor_ = prefabsManager_.Instantiate("BorderCursor");
			borderCursor_.SetActive(false);
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(borderCursor_);
			}
			fullCursor_ = prefabsManager_.Instantiate("FullCursor");
			fullCursor_.SetActive(false);
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(fullCursor_);
			}
			hiderCursor_ = prefabsManager_.Instantiate("HideCursor");
			hiderCursor_.SetActive(false);
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(hiderCursor_);
			}
			Renderer component = fullCursor_.GetComponent<Renderer>();
			material = new Material(component.sharedMaterial);
			component.material = material;
			isVoxelInHand = false;
		}

		public void Init()
		{
			SingletonManager.Get<InputModel>(out inputManager_);
		}

		public void SetRainbowCursor(VoxelKey key)
		{
			Vector3 position = key.ToVector() + Vector3.one * 0.5f;
			hiderCursor_.transform.position = position;
			hiderCursor_.SetActive(true);
			rainbowLock = true;
			HideCursor();
		}

		public void HideRainbowCursor()
		{
			hiderCursor_.SetActive(false);
			rainbowLock = false;
		}

		public void HideCursor()
		{
			if (borderCursor_ != null)
			{
				borderCursor_.SetActive(false);
			}
			if (fullCursor_ != null)
			{
				fullCursor_.SetActive(false);
			}
		}

		private int Max(int a, int b)
		{
			return (a <= b) ? b : a;
		}

		private TYPE Translate<TYPE>(IntPtr structure)
		{
			if (structure == IntPtr.Zero)
			{
				return default(TYPE);
			}
			return (TYPE)Marshal.PtrToStructure(structure, typeof(TYPE));
		}

		internal void Set(VoxelKey key)
		{
			borderCursor_.transform.position = key.ToVector() + Vector3.one * 0.5f;
			borderCursor_.SetActive(true);
		}

		internal void Set(VoxelRaycastHit hit)
		{
			if (rainbowLock)
			{
				return;
			}
			Vector3 position = hit.Full.ToVector() + Vector3.one * 0.5f;
			if (!isVoxelInHand && !IsRotatePressed())
			{
				HideCursor();
				return;
			}
			VoxelData data;
			GameObject gameObject;
			GameObject gameObject2;
			if (voxelEngine_.GetVoxelData(hit.value, out data) && (data.IsBox || data.SplitBySides))
			{
				gameObject = fullCursor_;
				gameObject2 = borderCursor_;
				if (hit.FreeVoxel != IntPtr.Zero)
				{
					Color32 light = Translate<Voxel>(hit.FreeVoxel).Light;
					float num = (float)Max(Max(light.r, light.g), Max(light.b, light.a)) / 256f;
					float a = minBrightness + maxBrightness * num;
					material.SetColor("_Color", new Color(1f, 1f, 1f, a));
				}
			}
			else
			{
				gameObject = borderCursor_;
				gameObject2 = fullCursor_;
			}
			gameObject.transform.position = position;
			gameObject.SetActive(true);
			gameObject2.SetActive(false);
		}

		public bool IsRotatePressed()
		{
			if (inputManager_ == null || inputManager_.InputIntances == null)
			{
				return true;
			}
			bool result = false;
			foreach (InputInstance inputIntance in inputManager_.InputIntances)
			{
				if (inputIntance.type == MobileInputType.Rotate)
				{
					result = inputIntance.Pressed;
					break;
				}
			}
			return result;
		}
	}
}

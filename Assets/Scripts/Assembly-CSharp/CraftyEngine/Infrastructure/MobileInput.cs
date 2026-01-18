using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class MobileInput
	{
		public const float DEFAULT_WIDTH_INCHES = 3.5f;

		public float touchSensitivity = 0.1f;

		public float touchAcceleration;

		private float touchSensitivityCorrection = 1f;

		private bool hasMove;

		private bool hasRotate;

		private UnityScreenSizeTracker screenSizeTracker_;

		private List<InputInstance> inputHolders_;

		private List<MobileInputZone> inputZones_;

		public Vector2 move { get; private set; }

		public Vector2 rotate { get; private set; }

		private float dragDistancePx
		{
			get
			{
				return (float)screenSizeTracker_.Width * touchSensitivity;
			}
		}

		private float dragMoveDistancePx
		{
			get
			{
				return (float)screenSizeTracker_.Width * 0.05f;
			}
		}

		public MobileInput(List<InputInstance> inputHolders)
		{
			inputHolders_ = inputHolders;
			inputZones_ = new List<MobileInputZone>();
			inputZones_.Add(new MobileInputZone(new Rect(0f, 0f, 0.25f, 0.5f), MobileInputType.Move));
			inputZones_.Add(new MobileInputZone(new Rect(0.4f, 0f, 0.6f, 1f), MobileInputType.Rotate)
			{
				useDeltaCorrection = true
			});
			inputZones_.Add(new MobileInputZone(new Rect(0.7f, 0f, 0.3f, 0.3f), MobileInputType.Jump));
			inputZones_.Add(new MobileInputZone(new Rect(0f, 0f, 0.3f, 0.3f), MobileInputType.Jump));
			SingletonManager.Get<UnityScreenSizeTracker>(out screenSizeTracker_);
			screenSizeTracker_.ScreenSizeChanged += HandleScreenResize;
			HandleScreenResize();
			for (int i = 0; i < inputHolders.Count; i++)
			{
				InputInstance inputInstance = inputHolders[i];
				inputInstance.ClickUtility.Pressed += HandlePress;
			}
		}

		private void HandlePress(InputInstance instance)
		{
			for (int i = 0; i < inputZones_.Count; i++)
			{
				MobileInputZone mobileInputZone = inputZones_[i];
				if (mobileInputZone.rectPixels.Contains(instance.CurrentPosition))
				{
					instance.type = mobileInputZone.Type;
					instance.useDeltaCorrection = mobileInputZone.useDeltaCorrection;
					break;
				}
			}
		}

		public bool Update()
		{
			hasMove = false;
			hasRotate = false;
			for (int i = 0; i < inputHolders_.Count; i++)
			{
				InputInstance inputInstance = inputHolders_[i];
				if (inputInstance.type != 0)
				{
					TryMove(inputInstance);
				}
			}
			if (!hasMove)
			{
				move = Vector2.zero;
			}
			if (!hasRotate)
			{
				rotate = Vector2.zero;
			}
			return hasMove;
		}

		private void HandleScreenResize()
		{
			for (int i = 0; i < inputZones_.Count; i++)
			{
				inputZones_[i].Resize();
			}
			if (CompileConstants.MOBILE && !CompileConstants.EDITOR)
			{
				touchSensitivityCorrection = CalculateSensitivityCorrection();
			}
		}

		private float CalculateSensitivityCorrection()
		{
			float num = 3.5f;
			if (Screen.dpi != 0f)
			{
				num = (float)Screen.width / Screen.dpi;
			}
			float num2 = num / 3.5f;
			if (num2 < 1f)
			{
				num2 = 1f;
			}
			return num2;
		}

		private void TryMove(InputInstance instance)
		{
			if (!instance.IsUI)
			{
				if (instance.type == MobileInputType.Move)
				{
					Vector2 vector = instance.StartPressPosition - instance.CurrentPosition;
					vector /= dragMoveDistancePx;
					vector = new Vector2(Mathf.Clamp(0f - vector.x, -1f, 1f), Mathf.Clamp(0f - vector.y, -1f, 1f));
					move = vector;
					hasMove = true;
				}
				else if (instance.type == MobileInputType.Rotate)
				{
					rotate = instance.DeltaPosition / dragDistancePx;
					rotate *= touchSensitivityCorrection;
					hasRotate = true;
				}
			}
		}

		public bool IsInJumoZone(Vector2 position)
		{
			for (int i = 0; i < inputZones_.Count; i++)
			{
				MobileInputZone mobileInputZone = inputZones_[i];
				if (mobileInputZone.Type == MobileInputType.Jump && mobileInputZone.rectPixels.Contains(position))
				{
					return true;
				}
			}
			return false;
		}
	}
}

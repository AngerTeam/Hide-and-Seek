using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace NguiTools
{
	public class InputManagerNgui : InputManager
	{
		private InputInstance lastNguiUsedInstance_;

		private UICamera nguiCamera_;

		private List<UICamera.Touch> nguiTouches_;

		private List<InputInstance> usedInputInstances_;

		public UICamera.Touch MoveTouch { get; private set; }

		public Vector2 MoveTouchStartPosition { get; private set; }

		public event Action MoveTouchUpdated;

		public override void Dispose()
		{
			base.Dispose();
			this.MoveTouchUpdated = null;
			UICamera.GetInputTouchCount = null;
			UICamera.GetInputTouch = null;
		}

		public override void Init()
		{
			base.Init();
			nguiTouches_ = new List<UICamera.Touch>();
			usedInputInstances_ = new List<InputInstance>(model.InputIntances);
			UICamera.GetInputTouchCount = GetInputTouchCount;
			UICamera.GetInputTouch = GetInputTouch;
		}

		public override void OnDataLoaded()
		{
			base.OnDataLoaded();
			nguiCamera_ = UnityEngine.Object.FindObjectOfType<UICamera>();
			nguiCamera_.processEventsIn = UICamera.ProcessEventsIn.None;
			nguiCamera_.useMouse = false;
		}

		protected override bool ProcessCustomEvents()
		{
			if (nguiCamera_ != null)
			{
				lastNguiUsedInstance_ = null;
				nguiCamera_.ProcessEvents();
				CheckNguiClick();
				UICamera.MouseOrTouch mouse = UICamera.GetMouse(0);
				GameObject gameObject = ((mouse != null) ? mouse.current : null);
				if (CheckNull(gameObject))
				{
					if (CompileConstants.MOBILE)
					{
						if (model.InputIntances == null)
						{
							return false;
						}
						for (int i = 0; i < model.InputIntances.Count; i++)
						{
							InputInstance inputInstance = model.InputIntances[i];
							if (!inputInstance.IsMouse && inputInstance.Index < Input.touchCount)
							{
								UICamera.MouseOrTouch touch = UICamera.GetTouch(inputInstance.Index, false);
								gameObject = ((touch != null) ? touch.current : null);
								if (!CheckNull(gameObject))
								{
									UIInput component = gameObject.GetComponent<UIInput>();
									model.allowHotkeyProcess = component == null && UIInput.selection == null;
									return false;
								}
							}
						}
					}
					model.allowHotkeyProcess = UIInput.selection == null;
				}
				else
				{
					UIInput component2 = gameObject.GetComponent<UIInput>();
					model.allowHotkeyProcess = component2 == null && UIInput.selection == null;
				}
			}
			else
			{
				model.allowHotkeyProcess = UIInput.selection == null;
			}
			return false;
		}

		private void CheckNguiClick()
		{
			if (!(nguiCamera_ != null) || lastNguiUsedInstance_ == null)
			{
				return;
			}
			if (nguiCamera_.justClicked)
			{
				lastNguiUsedInstance_.IsNguiClick = true;
				nguiCamera_.justClicked = false;
			}
			GameObject gameObject = UICamera.hoveredObject ?? UICamera.selectedObject;
			if (gameObject != null)
			{
				bool flag = gameObject.tag == "NGUIIgnoreLock";
				if (gameObject.GetComponent<UIRoot>() == null && !flag && lastNguiUsedInstance_.Phase == InpuPhase.Start)
				{
					lastNguiUsedInstance_.IsUI = true;
				}
				else
				{
					lastNguiUsedInstance_.IsIgnoredUI = flag;
				}
			}
		}

		private bool CheckNull(GameObject currentNguiObject)
		{
			if (currentNguiObject == null)
			{
				return true;
			}
			if (currentNguiObject.GetComponent<UIRoot>() != null)
			{
				return true;
			}
			return false;
		}

		private UICamera.Touch GetInputTouch(int index)
		{
			CheckNguiClick();
			lastNguiUsedInstance_ = usedInputInstances_[index];
			model.CurrentInstance = lastNguiUsedInstance_;
			return nguiTouches_[index];
		}

		private int GetInputTouchCount()
		{
			int num = 0;
			UICamera.Touch touch = null;
			for (int i = 0; i < model.InputIntances.Count; i++)
			{
				InputInstance inputInstance = model.InputIntances[i];
				if (inputInstance.Phase != 0)
				{
					usedInputInstances_[num] = inputInstance;
					UICamera.Touch touch2;
					if (nguiTouches_.Count <= num)
					{
						touch2 = new UICamera.Touch();
						nguiTouches_.Add(touch2);
					}
					else
					{
						touch2 = nguiTouches_[num];
					}
					touch2.position = inputInstance.CurrentPosition;
					touch2.tapCount = 1;
					touch2.fingerId = inputInstance.Index;
					touch2.position = inputInstance.CurrentPosition;
					touch2.phase = inputInstance.UnityPhace;
					num++;
					if (inputInstance.type == MobileInputType.Move)
					{
						touch = touch2;
					}
				}
			}
			if (MoveTouch == null && touch != null)
			{
				MoveTouchStartPosition = touch.position;
			}
			MoveTouch = touch;
			if (this.MoveTouchUpdated != null)
			{
				this.MoveTouchUpdated();
			}
			return num;
		}
	}
}

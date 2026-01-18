using System;
using Extensions;
using MyPlayerInput;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class InputManager : InputEventBroadcaster
	{
		protected bool isMoveTouch;

		private MouseCursorManager mouseCursorManager_;

		private bool doRaycast_;

		private Camera raycastCamera_;

		private UnityEvent unityEvent_;

		private UnityScreenSizeTracker screenSizeTracker_;

		private bool disposed_;

		public Vector2 Center { get; private set; }

		public bool Enabled { get; set; }

		public bool EnabledKey { get; set; }

		public MobileInput MobileInput { get; private set; }

		public Vector3 Target
		{
			get
			{
				return Center;
			}
		}

		public event EventHandler<InputEventArgs> ObjectClicked;

		public event EventHandler<InputEventArgs> PointerDown;

		public event EventHandler<InputEventArgs> PointerUp;

		public event EventHandler<InputEventArgs> PointerClicked;

		public event EventHandler<InputEventArgs> PointerClickedOnNgui;

		public event EventHandler<InputEventArgs> PointerHoldEnd;

		public event EventHandler<InputEventArgs> PointerHoldStart;

		public event EventHandler<InputEventArgs> Scroll;

		public event EventHandler<InputEventArgs> MouseRightClick;

		public event Action Updated;

		public override void Init()
		{
			base.Init();
			Enabled = true;
			SingletonManager.Get<MouseCursorManager>(out mouseCursorManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<UnityScreenSizeTracker>(out screenSizeTracker_);
			SingletonManager.Get<InputModel>(out model);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			unityEvent_.Subscribe(UnityEventType.ApplicationFocus, HandleFocus);
			screenSizeTracker_.ScreenSizeChanged += HandleResize;
			Center = screenSizeTracker_.Center;
			if (!CompileConstants.MOBILE)
			{
				model.InputIntances.Add(new InputInstance(true, 0));
				model.InputIntances.Add(new InputInstance(true, 1));
			}
			if (CompileConstants.MOBILE)
			{
				model.InputIntances.Add(new InputInstance(false, 0));
				model.InputIntances.Add(new InputInstance(false, 1));
			}
			if (CompileConstants.MOBILE)
			{
				MobileInput = new MobileInput(model.InputIntances);
			}
			for (int i = 0; i < model.InputIntances.Count; i++)
			{
				InputInstance inputInstance = model.InputIntances[i];
				inputInstance.ClickUtility.Pressed += HandlePress;
				inputInstance.ClickUtility.Released += HandleReleased;
				inputInstance.ClickUtility.Clicked += HandleClicked;
				inputInstance.ClickUtility.HoldStarted += HandleHoldStarted;
				inputInstance.ClickUtility.HoldEnded += HandleHoldEnded;
			}
		}

		private void HandleHoldEnded(InputInstance instance)
		{
			Try(this.PointerHoldEnd, instance);
		}

		private void HandleHoldStarted(InputInstance instance)
		{
			Try(this.PointerHoldStart, instance);
		}

		private void HandleClicked(InputInstance instance)
		{
			if (instance.IsUI || instance.IsNguiClick)
			{
				Try(this.PointerClickedOnNgui, instance);
			}
			else
			{
				instance.justClicked = true;
			}
		}

		private void HandleReleased(InputInstance instance)
		{
			Try(this.PointerUp, instance);
			instance.IsNguiClick = false;
		}

		private void HandlePress(InputInstance instance)
		{
			Try(this.PointerDown, instance);
		}

		public override void Dispose()
		{
			disposed_ = true;
			mouseCursorManager_ = null;
			raycastCamera_ = null;
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			unityEvent_.Unsubscribe(UnityEventType.ApplicationFocus, HandleFocus);
			unityEvent_ = null;
			screenSizeTracker_.ScreenSizeChanged -= HandleResize;
			screenSizeTracker_ = null;
		}

		public void SetRaycastCamera(Camera camera)
		{
			raycastCamera_ = camera;
			doRaycast_ = raycastCamera_ != null;
		}

		internal Vector2 GetMove()
		{
			if (CompileConstants.MOBILE)
			{
				Vector2 move = MobileInput.move;
				if (CompileConstants.EDITOR)
				{
					move += GetMoveAxis();
				}
				return move;
			}
			return GetMoveAxis();
		}

		internal Vector2 GetRotate()
		{
			if (CompileConstants.MOBILE)
			{
				return MobileInput.rotate;
			}
			return GetRotateAxis();
		}

		protected virtual bool ProcessCustomEvents()
		{
			return false;
		}

		private void TryGetClick(InputInstance instance)
		{
			if (!instance.justClicked)
			{
				return;
			}
			InputEventArgs inputEventArgs = new InputEventArgs();
			inputEventArgs.pointerPosition = instance.CurrentPosition;
			if (!instance.IsMoustRight && doRaycast_ && raycastCamera_.pixelRect.Contains(instance.CurrentPosition))
			{
				Vector3 position = new Vector3(inputEventArgs.pointerPosition.x, inputEventArgs.pointerPosition.y, raycastCamera_.farClipPlane);
				Vector3 direction = raycastCamera_.ScreenToWorldPoint(position);
				if (Physics.Raycast(raycastCamera_.transform.position, direction, out inputEventArgs.hit, raycastCamera_.farClipPlane))
				{
					Try(this.ObjectClicked, inputEventArgs);
				}
			}
			if (instance.IsMoustRight)
			{
				Try(this.MouseRightClick, inputEventArgs);
			}
			else
			{
				Try(this.PointerClicked, inputEventArgs);
			}
			instance.justClicked = false;
		}

		private static Vector2 GetRotateAxis()
		{
			return new Vector2(Input.GetAxisRaw("Mouse X"), Input.GetAxisRaw("Mouse Y"));
		}

		private Vector2 GetMoveAxis()
		{
			if (model.allowHotkeyProcess)
			{
				return new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical"));
			}
			return Vector2.zero;
		}

		private void HandleFocus()
		{
			for (int i = 0; i < model.InputIntances.Count; i++)
			{
				model.InputIntances[i].Reset();
			}
		}

		private void HandleResize()
		{
			Center = screenSizeTracker_.Center;
		}

		private void HandleScroll()
		{
			if (this.Scroll != null)
			{
				float axis = Input.GetAxis("Mouse ScrollWheel");
				if (axis != 0f)
				{
					InputEventArgs inputEventArgs = new InputEventArgs();
					inputEventArgs.pointerPosition = Input.mousePosition;
					inputEventArgs.scrollDelta = axis;
					this.Scroll(this, inputEventArgs);
				}
			}
		}

		protected virtual void UnityUpdate()
		{
			if (disposed_)
			{
				return;
			}
			ProcessCustomEvents();
			for (int i = 0; i < model.InputIntances.Count; i++)
			{
				InputInstance instance = model.GetInstance(i);
				instance.Update();
			}
			if (mouseCursorManager_ == null || !Enabled)
			{
				return;
			}
			for (int j = 0; j < model.InputIntances.Count; j++)
			{
				InputInstance instance2 = model.GetInstance(j);
				if (!instance2.IsUI && !instance2.IsNguiClick && !instance2.Used)
				{
					TryGetClick(instance2);
				}
			}
			bool flag = false;
			if (CompileConstants.MOBILE)
			{
				flag = MobileInput.Update();
			}
			if (!flag)
			{
				HandleScroll();
			}
			this.Updated.SafeInvoke();
		}
	}
}

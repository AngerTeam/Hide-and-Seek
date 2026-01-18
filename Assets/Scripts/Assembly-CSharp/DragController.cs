using System;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;
using WindowsModule;

public class DragController : IDisposable
{
	private InputInstance dragTouch_;

	private InputManager inputManager_;

	private UnityEvent unityEvent_;

	private WindowsManager windowsManager_;

	public event Action<Vector2> Clicked;

	public event Action<Vector2> DragEnded;

	public event Action<Vector2> DragStarted;

	public event Action<Vector2> DragUpdate;

	public DragController()
	{
		SingletonManager.Get<UnityEvent>(out unityEvent_);
		SingletonManager.Get<WindowsManager>(out windowsManager_);
		SingletonManager.Get<InputManager>(out inputManager_);
		inputManager_.PointerDown += HandlePointerDown;
		windowsManager_.AllWindowsClosed += HadleRelease;
		unityEvent_.Subscribe(UnityEventType.Update, Update);
	}

	public void Dispose()
	{
		if (dragTouch_ != null)
		{
			dragTouch_.ClickUtility.HoldStarted -= HandleHoldStarted;
		}
		unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		windowsManager_.AllWindowsClosed -= HadleRelease;
		inputManager_.PointerDown -= HandlePointerDown;
	}

	private void HadleRelease()
	{
		HadleRelease(dragTouch_);
	}

	private void HadleRelease(InputInstance obj)
	{
		if (dragTouch_ != null)
		{
			this.DragEnded.SafeInvoke(dragTouch_.CurrentPosition);
			Unsubscribe(dragTouch_);
			dragTouch_ = null;
		}
		Unsubscribe(obj);
	}

	private void HandleClicked(InputInstance obj)
	{
		this.Clicked.SafeInvoke(obj.CurrentPosition);
	}

	private void HandleHoldStarted(InputInstance obj)
	{
		if (dragTouch_ == null)
		{
			dragTouch_ = obj;
			this.DragStarted.SafeInvoke(obj.StartPressPosition);
		}
	}

	private void HandlePointerDown(object sender, InputEventArgs e)
	{
		InputInstance touch = e.touch;
		touch.ClickUtility.HoldStarted += HandleHoldStarted;
		touch.ClickUtility.Released += HadleRelease;
		touch.ClickUtility.Clicked += HandleClicked;
	}

	private void Unsubscribe(InputInstance obj)
	{
		if (obj != null)
		{
			obj.ClickUtility.HoldStarted -= HandleHoldStarted;
			obj.ClickUtility.Released -= HadleRelease;
			obj.ClickUtility.Clicked -= HandleClicked;
		}
	}

	private void Update()
	{
		if (dragTouch_ != null)
		{
			this.DragUpdate.SafeInvoke(dragTouch_.CurrentPosition);
		}
	}
}

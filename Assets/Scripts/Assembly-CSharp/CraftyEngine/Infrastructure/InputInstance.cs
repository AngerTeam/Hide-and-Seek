using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class InputInstance
	{
		public bool justClicked;

		public bool enabled;

		public bool IsIgnoredUI;

		public bool IsUI;

		internal MobileInputType type;

		internal bool useDeltaCorrection;

		private TraceList<Vector2> path_;

		public string Title;

		public bool Used;

		public float Speed { get; private set; }

		public InputClickUtility ClickUtility { get; private set; }

		public bool IsMouse { get; private set; }

		public bool IsMoustLeft { get; private set; }

		public bool IsMoustRight { get; private set; }

		public bool Pressed { get; private set; }

		public Vector2 LastPosition { get; private set; }

		public Vector2 CurrentPosition { get; private set; }

		public int Index { get; private set; }

		public float MaxDistanceSincePress { get; private set; }

		public float StartPressTime { get; private set; }

		public Vector2 StartPressPosition { get; private set; }

		public Vector2 DeltaPosition { get; private set; }

		public InpuPhase Phase { get; private set; }

		public TouchPhase UnityPhace { get; private set; }

		public bool IsNguiClick { get; internal set; }

		public bool PressedLastUpdate { get; internal set; }

		public InputInstance(bool isMouse, int index)
		{
			ClickUtility = new InputClickUtility(this);
			enabled = true;
			IsUI = false;
			path_ = new TraceList<Vector2>(10u);
			IsMouse = isMouse;
			Index = index;
			if (IsMouse)
			{
				IsMoustLeft = index == 0;
				IsMoustRight = index == 1;
			}
			Phase = InpuPhase.None;
			UnityPhace = TouchPhase.Ended;
			Title = ((!IsMouse) ? ("Touch " + (Index + 1)) : ((!IsMoustLeft) ? "Right Mouse" : "Left Mouse"));
		}

		internal void Update()
		{
			if (!enabled)
			{
				Reset();
				return;
			}
			PressedLastUpdate = false;
			LastPosition = CurrentPosition;
			Touch t;
			if (IsMouse)
			{
				CurrentPosition = Input.mousePosition;
				DeltaPosition = CurrentPosition - LastPosition;
				bool mouseButton = Input.GetMouseButton(Index);
				UpdatePhase(mouseButton);
			}
			else if (GetTouch(out t))
			{
				CurrentPosition = t.position;
				bool touchPressed = t.phase == TouchPhase.Stationary || t.phase == TouchPhase.Began || t.phase == TouchPhase.Moved;
				DeltaPosition = CurrentPosition - LastPosition;
				if (t.phase == TouchPhase.Began || t.phase == TouchPhase.Ended)
				{
					DeltaPosition = Vector2.zero;
				}
				else if (t.phase == TouchPhase.Moved && useDeltaCorrection)
				{
					DeltaPosition = CorrectDeltaPosition(DeltaPosition, t);
				}
				UpdatePhase(touchPressed);
			}
			else
			{
				DeltaPosition = Vector2.zero;
				UpdatePhase(false);
			}
			UpdateSpeed();
		}

		private void UpdateSpeed()
		{
			path_.Add(CurrentPosition);
			if (path_.Count < 2)
			{
				Speed = 0f;
				return;
			}
			float num = 0f;
			Vector3 a = path_[0];
			for (int i = 1; i < path_.Count; i++)
			{
				Vector3 vector = path_[i];
				num += Vector3.Distance(a, vector);
				a = vector;
			}
			Speed = num / (float)path_.Count;
		}

		private void UpdatePhase(bool touchPressed)
		{
			if (Pressed)
			{
				if (touchPressed)
				{
					Phase = InpuPhase.Pressed;
					UnityPhace = TouchPhase.Stationary;
					float num = Vector2.Distance(StartPressPosition, CurrentPosition);
					if (num > MaxDistanceSincePress)
					{
						MaxDistanceSincePress = num;
					}
				}
				else
				{
					Phase = InpuPhase.Ended;
					UnityPhace = TouchPhase.Ended;
					Pressed = false;
					ClickUtility.Release();
					PressedLastUpdate = true;
				}
			}
			else if (touchPressed)
			{
				StartPressTime = Time.unscaledTime;
				StartPressPosition = CurrentPosition;
				MaxDistanceSincePress = 0f;
				LastPosition = CurrentPosition;
				DeltaPosition = Vector2.zero;
				Phase = InpuPhase.Start;
				UnityPhace = TouchPhase.Began;
				Pressed = true;
				ClickUtility.Press();
			}
			else
			{
				Reset();
			}
		}

		private bool GetTouch(out Touch t)
		{
			for (int i = 0; i < Input.touchCount; i++)
			{
				t = Input.GetTouch(i);
				if (t.fingerId == Index)
				{
					return true;
				}
			}
			t = default(Touch);
			return false;
		}

		internal void Reset()
		{
			path_.Clear();
			Speed = 0f;
			StartPressTime = 0f;
			if (Pressed)
			{
				ClickUtility.Release();
			}
			Pressed = false;
			type = MobileInputType.None;
			Phase = InpuPhase.None;
			UnityPhace = TouchPhase.Ended;
			IsUI = false;
			IsIgnoredUI = false;
		}

		private static Vector2 CorrectDeltaPosition(Vector2 deltaPosition, Touch touch)
		{
			if (touch.deltaTime > 0.08f)
			{
				Vector2 vector = deltaPosition;
				Vector2 vector2 = new Vector2(Mathf.Sign(vector.x), Mathf.Sign(vector.y));
				Vector2 vector3 = new Vector2(Mathf.Abs(vector.x), Mathf.Abs(vector.y));
				if (Mathf.Abs(vector.x) > 0f && vector3.x <= 11f)
				{
					vector3.x = Mathf.Clamp(vector3.x / 5f, 1f, 11f);
				}
				if (Mathf.Abs(vector.y) > 0f && vector3.y <= 11f)
				{
					vector3.y = Mathf.Clamp(vector3.y / 5f, 1f, 11f);
				}
				return new Vector2(vector3.x * vector2.x, vector3.y * vector2.y);
			}
			return deltaPosition;
		}
	}
}

using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class InputEventArgs : EventArgs
	{
		public int? alpha;

		public RaycastHit hit;

		public Vector2 holdStartPosition;

		public KeyCode keyCode;

		public Vector2 pointerPosition;

		public float scrollDelta;

		public bool used;

		public InputInstance touch;
	}
}

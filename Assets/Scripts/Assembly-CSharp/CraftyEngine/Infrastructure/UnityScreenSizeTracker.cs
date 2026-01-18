using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class UnityScreenSizeTracker : Singleton
	{
		private bool chanded_;

		public Vector2 Size
		{
			get
			{
				return new Vector2(Width, Height);
			}
		}

		public Vector2 Center
		{
			get
			{
				return Size * 0.5f;
			}
		}

		public int Width { get; private set; }

		public int Height { get; private set; }

		public event Action ScreenSizeChangedDelayed;

		public event Action ScreenSizeChanged;

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>().Subscribe(UnityEventType.Update, CheckScreenSize);
		}

		public override void Dispose()
		{
			this.ScreenSizeChanged = null;
		}

		private void CheckScreenSize()
		{
			if (chanded_)
			{
				chanded_ = false;
				if (this.ScreenSizeChangedDelayed != null)
				{
					this.ScreenSizeChangedDelayed();
				}
			}
			if (Width != Screen.width || Height != Screen.height)
			{
				Width = Screen.width;
				Height = Screen.height;
				chanded_ = true;
				if (this.ScreenSizeChanged != null)
				{
					this.ScreenSizeChanged();
				}
			}
		}
	}
}

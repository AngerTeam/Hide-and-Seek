using System;
using Extensions;
using UnityEngine;

namespace PlayerModule
{
	[Serializable]
	public class PlayerVisibilityModel : IDisposable, IVisible
	{
		public string persId;

		[SerializeField]
		private bool byPlayerSide_;

		[SerializeField]
		private bool byGameLogic_;

		[SerializeField]
		private bool byGameState_;

		[SerializeField]
		private bool byHealth_;

		[SerializeField]
		private bool byServerPosition_;

		[SerializeField]
		private bool byCameraMode_;

		public bool ByPlayerSide
		{
			get
			{
				return byPlayerSide_;
			}
			set
			{
				if (byPlayerSide_ != value)
				{
					byPlayerSide_ = value;
					UpdateVisible();
				}
			}
		}

		public bool ByGameLogic
		{
			get
			{
				return byGameLogic_;
			}
			set
			{
				if (byGameLogic_ != value)
				{
					byGameLogic_ = value;
					UpdateVisible();
				}
			}
		}

		public bool ByGameState
		{
			get
			{
				return byGameState_;
			}
			set
			{
				if (byGameState_ != value)
				{
					byGameState_ = value;
					UpdateVisible();
				}
			}
		}

		public bool ByHealth
		{
			get
			{
				return byHealth_;
			}
			set
			{
				if (byHealth_ != value)
				{
					byHealth_ = value;
					UpdateVisible();
				}
			}
		}

		public bool ByServerPosition
		{
			get
			{
				return byServerPosition_;
			}
			set
			{
				if (byServerPosition_ != value)
				{
					byServerPosition_ = value;
					UpdateVisible();
				}
			}
		}

		public bool Visible { get; private set; }

		public bool ByCameraMode
		{
			get
			{
				return byCameraMode_;
			}
			set
			{
				if (byCameraMode_ != value)
				{
					byCameraMode_ = value;
					UpdateVisible();
				}
			}
		}

		public event Action VisibleChanged;

		public PlayerVisibilityModel()
		{
			Reset();
			ByCameraMode = true;
			UpdateVisible();
		}

		public void Dispose()
		{
			this.VisibleChanged = null;
		}

		public void Reset()
		{
			ByGameLogic = true;
			ByHealth = true;
			ByServerPosition = true;
			ByGameState = true;
			ByPlayerSide = true;
		}

		private void UpdateVisible()
		{
			bool flag = ByGameState && ByGameLogic && ByPlayerSide && ByHealth && ByServerPosition && ByCameraMode;
			if (flag != Visible)
			{
				Visible = flag;
				this.VisibleChanged.SafeInvoke();
			}
		}

		public override string ToString()
		{
			return string.Format("{0} Visible: {1}\nByGameState {2}\nByGameLogic {3}\nByHealth {4}\nByServerPosition {5}\nByPlayerSide{6}", persId, Visible, ByGameState, ByGameLogic, ByHealth, ByServerPosition, ByPlayerSide);
		}
	}
}

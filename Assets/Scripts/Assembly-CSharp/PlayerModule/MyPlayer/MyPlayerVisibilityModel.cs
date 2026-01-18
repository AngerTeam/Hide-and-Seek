using System;

namespace PlayerModule.MyPlayer
{
	[Serializable]
	public class MyPlayerVisibilityModel : IVisible
	{
		private PlayerVisibilityModel visibility;

		public bool VisibleGameState;

		public bool VisibleBySubstate;

		public bool VisibleByWindow;

		public bool VisibleByControlMode;

		public bool VisibleByCameraMode;

		public bool Visible
		{
			get
			{
				return visibility.ByHealth && VisibleGameState && VisibleBySubstate && VisibleByWindow && VisibleByCameraMode && VisibleByControlMode;
			}
		}

		public MyPlayerVisibilityModel(PlayerVisibilityModel visibility)
		{
			this.visibility = visibility;
			Reset();
		}

		public void Reset()
		{
			VisibleBySubstate = true;
			VisibleByControlMode = true;
			VisibleGameState = true;
			VisibleByWindow = true;
		}
	}
}

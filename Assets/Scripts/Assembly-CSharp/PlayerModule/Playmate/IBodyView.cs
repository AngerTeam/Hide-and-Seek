using System;

namespace PlayerModule.Playmate
{
	public interface IBodyView : IDisposable
	{
		int Type { get; set; }

		bool supportsSkin { get; set; }

		bool supportsItem { get; set; }

		bool corpseAnimationRequired { get; set; }

		event Action Updated;

		void SetVisible(bool value);

		void Load();

		void Init();

		void SetModel(PlayerStatsModel model);
	}
}

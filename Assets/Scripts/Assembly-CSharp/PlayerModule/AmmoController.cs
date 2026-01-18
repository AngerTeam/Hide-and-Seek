namespace PlayerModule
{
	public class AmmoController : ArtikulHandler
	{
		private int shotsAvalible_;

		private int shotsTaken_;

		public bool OutOfAmmo
		{
			get
			{
				return shotsTaken_ >= shotsAvalible_ && shotsAvalible_ > 0;
			}
		}

		public int ShotsLeft
		{
			get
			{
				return shotsAvalible_ - shotsTaken_;
			}
		}

		public AmmoController(PlayerStatsModel model, bool permanent)
		{
			SetModel(model);
			model.Died += HandleDied;
		}

		public void Reload()
		{
			shotsTaken_ = 0;
		}

		public void TakeShot()
		{
			shotsTaken_++;
		}

		protected override void UpdateArtikul()
		{
			Reload();
			if (selectedArtikul.reload_time <= 0f)
			{
				shotsAvalible_ = 0;
			}
			else
			{
				shotsAvalible_ = selectedArtikul.reload_shots;
			}
		}

		private void HandleDied()
		{
			Reload();
		}
	}
}

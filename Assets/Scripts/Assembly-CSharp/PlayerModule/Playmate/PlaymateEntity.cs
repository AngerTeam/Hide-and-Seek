namespace PlayerModule.Playmate
{
	public class PlaymateEntity : PlayerEntityBase
	{
		private PlaymateSoundController soundContoController_;

		private bool disposed_;

		public PlaymateController Controller { get; private set; }

		public PlayerStatsModel Model { get; private set; }

		public PlaymateEntity(PlayerStatsModel model, bool permanent, bool myPlayer)
			: base(permanent)
		{
			Model = model;
			Controller = new PlaymateController(model, permanent, myPlayer);
			Controller.BodyViewUpdated += HandleBodyViewUpdated;
			soundContoController_ = new PlaymateSoundController(model, Controller.ActionsHandler);
			SetupActionTransactions();
			model.projectile.targetType = ProjectileTargetType.Undefined;
		}

		private void HandleBodyViewUpdated()
		{
			soundContoController_.SetTransform(Model.visual.Transform);
		}

		public override void Dispose()
		{
			if (!disposed_)
			{
				base.Dispose();
				Controller.Dispose();
				soundContoController_.Dispose();
				disposed_ = true;
			}
		}

		private void SetupActionTransactions()
		{
			Model.Died += Controller.SpawnCorpse;
		}
	}
}

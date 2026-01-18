using System;
using Animations;
using ArticulViewModule;
using Extensions;

namespace PlayerModule
{
	public abstract class PlayerController : ArtikulHandler
	{
		public PlayerAnimationsController AnimationsController { get; protected set; }

		public ActionHandler ActionsHandler { get; private set; }

		public ToolArticulView View { get; private set; }

		protected virtual bool ModelVisible
		{
			get
			{
				return base.Model.visibility.Visible;
			}
		}

		public event Action<string> ProjectileHitHappened;

		public void SetProjectile(PlayerVisualModelByCamera current)
		{
			SetProjectileAsc(current.ProjectileAsc);
			SetProjectileContainer(current.ProjectileArticulView);
		}

		public void SetProjectileContainer(ArticulViewBase view)
		{
			SetProjectileContainer(view as ToolArticulView);
		}

		public void SetProjectileContainer(ToolArticulView view)
		{
			ActionsHandler.ContactHappened -= HandleProjectileComplete;
			if (View != null && View.FxView != null)
			{
				View.FxView.ProjectileAnimationComplete -= HandleProjectileComplete;
			}
			View = view;
			if (View != null && View.FxView != null && view.FxView.HasProjectile)
			{
				View.FxView.ProjectileAnimationComplete += HandleProjectileComplete;
			}
			else
			{
				ActionsHandler.ContactHappened += HandleProjectileComplete;
			}
		}

		private void HandleProjectileComplete()
		{
			this.ProjectileHitHappened.SafeInvoke(null);
		}

		private void HandleProjectileComplete(string targetPersId)
		{
			this.ProjectileHitHappened.SafeInvoke(targetPersId);
		}

		protected void SetProjectileAsc(AnimatedItemView itemView)
		{
			if (itemView != null)
			{
				itemView.Asc.StateChanged -= HandleStateChanged;
				itemView.Asc.StateChanged += HandleStateChanged;
			}
		}

		protected void HandleStateChanged(string state)
		{
			if (!ModelVisible)
			{
				return;
			}
			switch (state)
			{
			case "cooldown":
			case "idle":
				if (ViewExists())
				{
					View.FxView.SpawnProjectile();
				}
				break;
			case "dig":
			case "attack":
				if (base.Model.action == 9)
				{
					AbilityUseStart(base.Model.projectile);
				}
				else if (ViewExists())
				{
					View.SendProjectile(base.Model.projectile);
					View.FxView.HandleMoment("start");
				}
				break;
			}
		}

		protected virtual void AbilityUseStart(ProjectileModel projectileModel)
		{
		}

		protected virtual void AbilityUseContact()
		{
		}

		private bool ViewExists()
		{
			return View != null && View.FxView != null;
		}

		protected void Init(PlayerStatsModel model, bool permanent, bool myPlayer)
		{
			SetModel(model, false);
			ActionsHandler = new ActionHandler(model, permanent, myPlayer);
			ActionsHandler.ContactHappened += HandleContactHappened;
		}

		private void HandleContactHappened()
		{
			if (base.Model.action == 9)
			{
				AbilityUseContact();
			}
			else if (ViewExists())
			{
				View.FxView.HandleMoment("contact");
			}
		}
	}
}

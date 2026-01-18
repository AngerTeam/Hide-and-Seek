using System;
using ArticulViewModule;
using Extensions;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class BodyController : IDisposable
	{
		private PlayerBodyManager manager_;

		private IBodyView previousBodyView_;

		private PlayerStatsModel model_;

		public IBodyView BodyView { get; private set; }

		public int CurrentType
		{
			get
			{
				return (BodyView != null) ? BodyView.Type : 0;
			}
		}

		public event Action Updated;

		public BodyController(PlayerStatsModel model)
		{
			SingletonManager.Get<PlayerBodyManager>(out manager_);
			model_ = model;
			model_.AllowAttackChaned += HandleAllowAttackChaned;
			model_.BodyTypeChanged += HandleBodyTypeChanged;
			model_.SkinChanged += HandleSkinChanged;
			model_.SelectedArtikulChanged += HandleSelectedArtikulChanged;
			model_.SideChanged += SetFrenemyLayer;
			model_.visibility.VisibleChanged += HandleVisibleChanged;
			Load();
		}

		private void HandleAllowAttackChaned()
		{
			SetFrenemyLayer();
		}

		public virtual void Dispose()
		{
			if (BodyView != null)
			{
				BodyView.Dispose();
			}
			BodyView = null;
			this.Updated = null;
			model_.BodyTypeChanged -= HandleBodyTypeChanged;
			model_.SkinChanged -= HandleSkinChanged;
			model_.SelectedArtikulChanged -= HandleSelectedArtikulChanged;
			model_.SideChanged -= SetFrenemyLayer;
			model_.visibility.VisibleChanged -= HandleVisibleChanged;
		}

		private void HandleBodyTypeChanged()
		{
			Load();
		}

		private void HandleVisibleChanged()
		{
			if (model_.visibility.Visible && (BodyView == null || CurrentType != model_.BodyType))
			{
				Load();
			}
			else if (BodyView != null)
			{
				BodyView.SetVisible(model_.visibility.Visible);
				SetFrenemyLayer();
			}
		}

		private void HandleBodyViewUpdated()
		{
			this.Updated.SafeInvoke();
			if (previousBodyView_ != null)
			{
				previousBodyView_.Dispose();
				previousBodyView_ = null;
			}
			SetFrenemyLayer();
		}

		private void HandleSelectedArtikulChanged(int obj)
		{
			if (BodyView != null && BodyView.supportsItem)
			{
				BodyView.Load();
			}
		}

		private void HandleSkinChanged(int obj)
		{
			if (BodyView != null && BodyView.supportsSkin)
			{
				BodyView.Load();
			}
		}

		public virtual void Load()
		{
			if ((!model_.IsDummy && !model_.visibility.Visible) || !SingletonManager.Contains<ArtikulItemViewManager>())
			{
				return;
			}
			if (BodyView != null)
			{
				if (BodyView.Type == model_.BodyType)
				{
					return;
				}
				BodyView.Updated -= HandleBodyViewUpdated;
				previousBodyView_ = BodyView;
			}
			BodyView = manager_.GetBodyView(model_.BodyType);
			BodyView.Updated += HandleBodyViewUpdated;
			BodyView.SetModel(model_);
			BodyView.Init();
			BodyView.Load();
			SetFrenemyLayer();
		}

		private void SetFrenemyLayer()
		{
			if (model_.visual.bodyColliders == null)
			{
				return;
			}
			int layer = ((!model_.InMyPlayerTeam && model_.AllowAttack) ? 14 : 15);
			Collider[] bodyColliders = model_.visual.bodyColliders;
			foreach (Collider collider in bodyColliders)
			{
				if (collider != null)
				{
					collider.gameObject.layer = layer;
				}
			}
		}
	}
}

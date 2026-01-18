using System;
using ChestsViewModule;
using Extensions;
using PlayerModule;
using PlayerModule.Playmate;
using UnityEngine;

namespace CraftyGameEngine.Player
{
	public sealed class ActorHolderUI3D : IDisposable
	{
		private UI3DViewTexture ui3DView_;

		private float heightOffset_;

		private float scale_;

		private Transform parent_;

		private bool autoUpdate_;

		public PlaymateEntity PlaymateEntity { get; private set; }

		public event Action ViewUpdated;

		public void AddActor(PlayerStatsModel model, Transform parent, bool permanent, float scale = 2f, float heightOffset = 0f, bool autoUpdate = true, bool isDummy = true)
		{
			parent_ = parent;
			scale_ = scale;
			heightOffset_ = heightOffset;
			autoUpdate_ = autoUpdate;
			DisposeActor();
			model.IsDummy = isDummy;
			model.SetPosition(Vector3.zero, Vector3.zero);
			PlaymateEntity = new PlaymateEntity(model, permanent, false);
			PlaymateEntity.Controller.BodyViewUpdated += HandleBodyViewUpdated;
			HandleBodyViewUpdated();
		}

		private void HandleBodyViewUpdated()
		{
			Transform transform = PlaymateEntity.Model.visual.Transform;
			if (!(transform == null))
			{
				transform.localScale = Vector3.one * scale_;
				if (ui3DView_ != null)
				{
					ui3DView_.Dispose();
				}
				ui3DView_ = new UI3DViewTexture(autoUpdate: autoUpdate_, prefabInstance: transform.gameObject, scale: 1f);
				SwitchActive(true);
				SetFlaunt();
				this.ViewUpdated.SafeInvoke();
			}
		}

		public void SwitchActive(bool on)
		{
			if (ui3DView_ == null)
			{
				return;
			}
			if (on)
			{
				if (parent_ != null)
				{
					ui3DView_.SetParent(parent_);
				}
				ui3DView_.SetCameraDistance(2f, heightOffset_);
			}
			ui3DView_.SwitchActive(on);
		}

		public void Dispose()
		{
			DisposeActor();
		}

		public void DisposeActor()
		{
			if (PlaymateEntity != null)
			{
				PlaymateEntity.Dispose();
				PlaymateEntity = null;
			}
			if (ui3DView_ != null)
			{
				ui3DView_.Dispose();
				ui3DView_ = null;
			}
		}

		public void SetFlaunt()
		{
			if (PlaymateEntity != null)
			{
				PlaymateEntity.Model.IsCocky = true;
			}
		}

		public void SetAction(int actionId)
		{
			if (PlaymateEntity != null)
			{
				PlaymateEntity.Model.action = actionId;
			}
		}
	}
}

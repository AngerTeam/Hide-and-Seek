using System;
using PlayerModule;
using PlayerModule.Playmate;
using UnityEngine;

namespace CraftyGameEngine.Player
{
	public sealed class ActorHolder : IDisposable
	{
		private float scale_;

		public PlaymateEntity PlaymateEntity { get; private set; }

		public void AddActor(PlayerStatsModel model, bool permanent, float scale = 2f)
		{
			scale_ = scale;
			if (PlaymateEntity != null)
			{
				DisposeActor();
			}
			PlaymateEntity = new PlaymateEntity(model, permanent, false);
			PlaymateEntity.Controller.BodyViewUpdated += HandleBodyViewUpdated;
		}

		private void HandleBodyViewUpdated()
		{
			PlaymateEntity.Model.visual.Transform.localScale = Vector3.one * scale_;
			SetFlaunt();
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
		}

		public void SetFlaunt()
		{
			if (PlaymateEntity != null)
			{
				PlaymateEntity.Model.IsCocky = true;
			}
		}
	}
}

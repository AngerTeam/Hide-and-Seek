using System;
using CraftyEngine.Sounds;
using DG.Tweening;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerHurtEffectView : IDisposable
	{
		private Color color_;

		private Sequence hurtRedSequence_;

		private PlayerVisualModel model_;

		public PlayerHurtEffectView(PlayerVisualModel model)
		{
			model_ = model;
			Color white = Color.white;
			white.a = 0f;
			hurtRedSequence_ = DOTween.Sequence();
			hurtRedSequence_.Append(DOTween.To(() => Color.red, delegate(Color c)
			{
				color_ = c;
			}, white, 0.6f));
			hurtRedSequence_.Pause();
			hurtRedSequence_.SetAutoKill(false);
			hurtRedSequence_.OnUpdate(Update);
		}

		public void Dispose()
		{
			hurtRedSequence_.Kill();
		}

		public void BlinkRed()
		{
			hurtRedSequence_.Restart();
		}

		public void PlayHurtSound(Vector3 position, string persId, bool death)
		{
			if (death)
			{
				SoundProvider.PlaySingleSound3D(position, 36);
			}
			else
			{
				SoundProvider.PlayGroupSound3D(position, 4, 1f);
			}
		}

		private void Update()
		{
			if (model_.bodyMaterial == null)
			{
				return;
			}
			for (int i = 0; i < model_.bodyMaterial.Length; i++)
			{
				Material material = model_.bodyMaterial[i];
				if (material != null)
				{
					material.color = color_;
				}
			}
		}
	}
}

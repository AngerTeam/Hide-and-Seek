using DG.Tweening;
using UnityEngine;

namespace Animations
{
	public class LayeredAsc : AnimatorOverrideStatesController
	{
		public float defaultHandsLayerWeight;

		public LayeredAsc(int layersCount)
			: base(layersCount)
		{
			defaultHandsLayerWeight = 1f;
		}

		public void BlendLayerWeight(int layer, float value, float duration)
		{
			AnimatorLayerHolder layerHolder = base.Layers[layer];
			if (layerHolder.blend != null)
			{
				layerHolder.blend.Kill();
			}
			if (layerHolder.weight != value)
			{
				layerHolder.blend = DOTween.To(() => layerHolder.weight, delegate(float w)
				{
					layerHolder.weight = w;
				}, value, duration).SetEase(Ease.InOutQuad).OnUpdate(delegate
				{
					SetLayerWeight(layer, layerHolder.weight);
				});
			}
		}

		public void ResetLayerWeight()
		{
			if (base.Layers.Length < 2)
			{
				return;
			}
			AnimatorLayerHolder animatorLayerHolder = base.Layers[1];
			if (animatorLayerHolder != null)
			{
				if (animatorLayerHolder.blend != null)
				{
					animatorLayerHolder.blend.Kill();
				}
				animatorLayerHolder.weight = defaultHandsLayerWeight;
				SetLayerWeight(1, defaultHandsLayerWeight);
			}
		}

		public override void SetGameObject(GameObject instaince)
		{
			base.SetGameObject(instaince);
			ResetLayerWeight();
		}

		public void SetLayerWeight(int layer, float value)
		{
			if (base.Animator != null && base.Animator.isInitialized && base.Animator.runtimeAnimatorController != null && base.Animator.GetLayerWeight(layer) != value)
			{
				base.Animator.SetLayerWeight(layer, value);
			}
		}
	}
}

using Animations;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils.Unity;
using CraftyVoxelEngine;
using DG.Tweening;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerCorpseView
	{
		private static Material dissolveCorpseMaterial;

		private AnimatonsCacheHolder animatonsCacheHolder_;

		public PlayerCorpseView()
		{
			if (dissolveCorpseMaterial == null)
			{
				dissolveCorpseMaterial = Resources.Load<Material>("DissolveCorpse/DissolveCorpseMaterial");
			}
		}

		private void ClearCorpse(GameObject corpse)
		{
			if (corpse != null)
			{
				Object.Destroy(corpse);
			}
		}

		public GameObject Spawn(GameObject source)
		{
			VoxelEngine voxelEngine = SingletonManager.Get<VoxelEngine>();
			VoxelRaycastHit voxelRaycastHit = voxelEngine.Manager.RayCast(source.transform.position, Vector3.down, 50f, true);
			GameObject clone = Object.Instantiate(source);
			clone.name = source.name + "(Corpse)";
			clone.SetActive(true);
			clone.transform.position = voxelRaycastHit.Point;
			Collider[] componentsInChildren = clone.GetComponentsInChildren<Collider>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].enabled = false;
			}
			Renderer[] componentsInChildren2 = clone.GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in componentsInChildren2)
			{
				Texture mainTexture = renderer.material.mainTexture;
				renderer.material = dissolveCorpseMaterial;
				renderer.material.mainTexture = mainTexture;
			}
			UnityEvent.OnNextUpdate(delegate
			{
				DisableEmitters(clone);
			});
			return clone;
		}

		private void DisableEmitters(GameObject clone)
		{
			if (!(clone == null))
			{
				ParticleSystem[] componentsInChildren = clone.GetComponentsInChildren<ParticleSystem>();
				foreach (ParticleSystem particleSystem in componentsInChildren)
				{
					ParticleSystem.EmissionModule emission = particleSystem.emission;
					emission.enabled = false;
				}
			}
		}

		public void Play(GameObject clone, bool animationReqiered = false, Vector3? from = null)
		{
			if (clone == null)
			{
				return;
			}
			clone.SetActive(true);
			Renderer[] renderers = GameObjectUtils.GetComponentsInChildren<Renderer>(clone, true);
			float duration = 5f;
			float alpha = 0f;
			clone.transform.DOMove(clone.transform.position + Vector3.down * 0.5f, duration).SetEase(Ease.InExpo);
			DOTween.To(() => alpha, delegate(float a)
			{
				alpha = a;
			}, 1f, duration).SetEase(Ease.InExpo).OnComplete(delegate
			{
				ClearCorpse(clone);
			})
				.OnUpdate(delegate
				{
					Render(renderers, alpha);
				});
			SingletonManager.Get<AnimatonsCacheHolder>(out animatonsCacheHolder_);
			if (animatonsCacheHolder_.statesController != null)
			{
				UnityEvent.OnNextUpdate(delegate
				{
					PlayDeathAnimation(clone);
				});
			}
			SoundProvider.PlaySingleSound3D(clone.transform.position, 36);
			if (animationReqiered)
			{
				Vector3 eulerAngles = clone.transform.eulerAngles;
				if (from.HasValue)
				{
					float y = from.Value.x - clone.transform.position.x;
					float x = from.Value.z - clone.transform.position.z;
					float y2 = Mathf.Atan2(y, x) * 57.29578f;
					eulerAngles.x = -90f;
					eulerAngles.y = y2;
				}
				else
				{
					eulerAngles.x = -90f;
				}
				PlayerCorpseViewAnimator playerCorpseViewAnimator = new PlayerCorpseViewAnimator();
				playerCorpseViewAnimator.target = clone.transform;
				playerCorpseViewAnimator.result = eulerAngles;
				playerCorpseViewAnimator.Play();
			}
		}

		private void PlayDeathAnimation(GameObject clone)
		{
			Animator[] componentsInChildren = GameObjectUtils.GetComponentsInChildren<Animator>(clone, true);
			Animator[] array = componentsInChildren;
			foreach (Animator animator in array)
			{
				animator.gameObject.SetActive(false);
				animator.gameObject.SetActive(true);
				animatonsCacheHolder_.statesController.SetAnimator(animator);
				animatonsCacheHolder_.statesController.Play("death");
			}
		}

		private void Render(Renderer[] renderers, float alpha)
		{
			foreach (Renderer renderer in renderers)
			{
				if (renderer != null)
				{
					renderer.sharedMaterial.SetFloat("_Cutoff", alpha);
				}
			}
		}
	}
}

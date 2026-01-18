using System;
using System.Collections.Generic;
using Animations;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils.Unity;
using Extensions;
using InventoryModule;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public abstract class BodyView : AnimatedItemView, IDisposable, IBodyView
	{
		public GameObject gameObject;

		protected ActorHierarchy hierarchy;

		protected PlayerStatsModel model;

		private bool visible_;

		protected BodyViewSkinController skinController;

		private Animator animator_;

		public int Type { get; set; }

		public bool supportsSkin { get; set; }

		public bool supportsItem { get; set; }

		public bool corpseAnimationRequired { get; set; }

		public event Action Updated;

		protected BodyView(string prefabName, int forcedAnimation)
		{
			if (forcedAnimation > 0)
			{
				forcedAnimationId = forcedAnimation;
			}
			visible_ = true;
			type = AnimationType.ThirdPersonBody;
			PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
			prefabsManager.Load("PlayerPrefabHolder");
			hierarchy = prefabsManager.Instantiate<ActorHierarchy>(prefabName);
			hierarchy.passCollider.gameObject.SetActive(false);
			skinController = new BodyViewSkinController();
			skinController.Loaded += ApplySkin;
		}

		public abstract void Init();

		public override void Dispose()
		{
			this.Updated = null;
			if (gameObject != null)
			{
				UnityEngine.Object.Destroy(gameObject);
			}
			base.Dispose();
		}

		public virtual void Load()
		{
			hierarchy.transform.SetParent(null, false);
			if (gameObject != null)
			{
				UnityEngine.Object.Destroy(gameObject);
			}
			GetBodyBundle();
		}

		public virtual void LoadAnimations()
		{
			LoadAnimations(gameObject);
		}

		public void SetColliderLayer(int layer)
		{
			Collider[] bodyColliders = hierarchy.bodyColliders;
			foreach (Collider collider in bodyColliders)
			{
				collider.gameObject.layer = layer;
			}
			hierarchy.headCollider.gameObject.layer = layer;
		}

		public void SetModel(PlayerStatsModel model)
		{
			PlayerModelHolder playerModelHolder;
			for (int i = 0; i < hierarchy.bodyColliders.Length; i++)
			{
				Collider collider = hierarchy.bodyColliders[i];
				playerModelHolder = collider.gameObject.AddComponent<PlayerModelHolder>();
				playerModelHolder.Model = model;
			}
			playerModelHolder = hierarchy.headCollider.gameObject.AddComponent<PlayerModelHolder>();
			playerModelHolder.Model = model;
			model.Died += StopIdleSound;
			this.model = model;
		}

		public virtual void UpdateSetSelectedArtikul()
		{
			if (!InventoryContentMap.Artikuls.TryGetValue(model.SelectedArtikul, out selectedArtikul))
			{
				selectedArtikul = InventoryContentMap.CraftSettings.handArtikul;
			}
		}

		public virtual void SetVisible(bool visible)
		{
			visible_ = visible;
			if (!(gameObject == null))
			{
				GameObjectUtils.SwitchActive(gameObject, visible_ && skinController.SkinLoaded);
				hierarchy.headCollider.enabled = visible;
				for (int i = 0; i < hierarchy.bodyColliders.Length; i++)
				{
					hierarchy.bodyColliders[i].enabled = visible;
				}
			}
		}

		protected virtual void StopIdleSound()
		{
		}

		protected abstract FileHolder GetBodyBundle();

		protected FileHolder GetBodyBundle(int skinId)
		{
			return skinController.GetBodyBundle(skinId);
		}

		protected Material CreateMaterial(Material sourceMaterial)
		{
			Material material = new Material(sourceMaterial);
			material.shader = Shader.Find("Unlit/ColoredTexture");
			material.color = new Color(1f, 1f, 1f, 0f);
			return material;
		}

		private void ReportUpdated()
		{
			GameObject gameObject = GameObjectUtils.FindChild(this.gameObject, "spine");
			animator_ = this.gameObject.GetComponent<Animator>();
			model.visual.Animator = animator_;
			model.visual.GameObject = this.gameObject;
			model.visual.Renderer = this.gameObject.GetComponentInChildren<SkinnedMeshRenderer>();
			model.visual.Renderer.sharedMaterial = CreateMaterial(model.visual.Renderer.sharedMaterial);
			model.visual.SpineBone = ((!(gameObject == null)) ? gameObject.transform : null);
			model.visual.Animator.gameObject.SetActive(false);
			model.visual.Animator.gameObject.SetActive(true);
			model.visual.Transform = this.gameObject.transform;
			model.visual.bodyColliders = new List<Collider>(hierarchy.bodyColliders) { hierarchy.headCollider }.ToArray();
			this.Updated.SafeInvoke();
			model.visual.Animator.applyRootMotion = !model.visual.Animator.applyRootMotion;
			model.visual.Animator.applyRootMotion = !model.visual.Animator.applyRootMotion;
			SetVisible(visible_);
		}

		private void ApplySkin()
		{
			gameObject = skinController.Instance;
			if (!(gameObject == null))
			{
				GameObjectUtils.SwitchActive(gameObject, visible_);
				hierarchy.transform.SetParent(gameObject.transform, false);
				hierarchy.transform.localPosition = Vector3.zero;
				hierarchy.transform.localRotation = Quaternion.identity;
				gameObject.name = string.Format("Playmate {0} ({1})", model.nickname, model.persId);
				if (AnimationsContentMap.AnimationSettings.allowBlendWeight)
				{
					base.LayeredAsc.defaultHandsLayerWeight = ((model.IsDummy || model.IsCocky) ? 1 : 0);
				}
				else
				{
					base.LayeredAsc.defaultHandsLayerWeight = 1f;
				}
				base.LayeredAsc.ResetLayerWeight();
				base.Asc.SetGameObject(gameObject);
				OnSkinApplyied();
				UnityEvent.OnNextUpdate(ReportUpdated);
				UpdateSetSelectedArtikul();
				LoadAnimations();
			}
		}

		protected virtual void OnSkinApplyied()
		{
		}
	}
}

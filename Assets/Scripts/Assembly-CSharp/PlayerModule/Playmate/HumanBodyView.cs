using System.Collections.Generic;
using Animations;
using CraftyEngine.Infrastructure.FileSystem;
using InventoryModule;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class HumanBodyView : BodyView
	{
		private int currentSkin_;

		private int currentArticul_;

		private AnimatorLayerBlendController blend_;

		private PlayerItemView itemView_;

		public HumanBodyView()
			: base("PlayerFrame", 0)
		{
		}

		public HumanBodyView(string prefabName, int animationId)
			: base(prefabName, animationId)
		{
		}

		public override void Init()
		{
			itemView_ = new PlayerItemView();
			InitAsc();
			Updated += HandleUpdated;
			blend_ = new AnimatorLayerBlendController(base.LayeredAsc, model, this);
		}

		protected override FileHolder GetBodyBundle()
		{
			return GetBodyBundle(model.SkinId);
		}

		public override void Load()
		{
			bool flag = false;
			if (currentSkin_ != model.SkinId)
			{
				currentSkin_ = model.SkinId;
				itemView_.SetBody(hierarchy.transform);
				base.Load();
				flag = true;
			}
			if (currentArticul_ != model.SelectedArtikul)
			{
				currentArticul_ = model.SelectedArtikul;
				itemView_.selectedArtikul = InventoryModuleController.GetArticul(currentArticul_);
				selectedArtikul = itemView_.selectedArtikul;
				itemView_.Load();
				if (!flag)
				{
					LoadAnimations();
				}
			}
		}

		private void HandleUpdated()
		{
			itemView_.SetBody(model.visual.Transform);
			PlayerVisualModelByCamera byCamera3Rd = model.visual.byCamera3Rd;
			byCamera3Rd.views = new AnimatedItemView[2] { this, itemView_ };
			byCamera3Rd.ProjectileAsc = itemView_;
			byCamera3Rd.ProjectileArticulView = itemView_.toolView_;
			byCamera3Rd.ReportUpdated();
			Renderer[] componentsInChildren = gameObject.GetComponentsInChildren<Renderer>();
			List<Material> list = new List<Material>();
			Renderer[] array = componentsInChildren;
			foreach (Renderer renderer in array)
			{
				if (renderer.material != null)
				{
					list.Add(renderer.material);
				}
			}
			model.visual.bodyMaterial = list.ToArray();
		}

		public override void Dispose()
		{
			base.Dispose();
			blend_.Dispose();
			itemView_.Dispose();
		}

		public override void SetVisible(bool visible)
		{
			base.SetVisible(visible);
			blend_.SetVisible(visible);
			itemView_.SetVisible(visible);
			itemView_.ResetAnimator();
			ResetAnimator();
			if (visible && model.visual.Transform != null)
			{
				HandleUpdated();
			}
		}
	}
}

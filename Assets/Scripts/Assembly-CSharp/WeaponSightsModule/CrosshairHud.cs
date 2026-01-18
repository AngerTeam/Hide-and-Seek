using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using DG.Tweening;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace WeaponSightsModule
{
	public class CrosshairHud : HeadUpDisplay
	{
		private readonly CrosshairHierarchy crossHair_;

		private readonly Tweener crossHairScaleTween_;

		private readonly NguiFileManager nguiFileManager_;

		private LookingAt currentlookingAtState_;

		private Sequence crossHairTween_;

		private Texture meleeTexture_;

		private Texture rangedTexture_;

		public CrosshairHud()
		{
			SingletonManager.TryGet<NguiFileManager>(out nguiFileManager_);
			prefabsManager.Load("WeaponSightsPrefabsHolder");
			crossHair_ = prefabsManager.InstantiateNGUIIn<CrosshairHierarchy>("UICrossHair", nguiManager.UiRoot.gameObject);
			crossHair_.panel.depth = 10;
			crossHairScaleTween_ = DOTween.To(() => Vector3.one, delegate(Vector3 s)
			{
				crossHair_.texturesRoot.localScale = s;
			}, Vector3.one * 1.2f, 0.5f).SetLoops(-1, LoopType.Yoyo).SetEase(Ease.InOutQuad)
				.SetAutoKill(false);
			hudStateSwitcher.Register(1, crossHair_.texturesRoot.gameObject);
			Interactive(LookingAt.Nothing, true);
		}

		public override void Dispose()
		{
			Object.Destroy(crossHair_);
			if (crossHairTween_ != null)
			{
				crossHairTween_.Kill();
			}
			if (crossHairTween_ != null)
			{
				crossHairTween_.Kill();
			}
		}

		public override void Resubscribe()
		{
			crossHair_.gameObject.SetActive(true);
		}

		public void Interactive(LookingAt lookingAt, bool instant = false)
		{
			if (!(crossHair_ != null) || currentlookingAtState_ == lookingAt)
			{
				return;
			}
			currentlookingAtState_ = lookingAt;
			if (crossHairTween_ != null)
			{
				crossHairTween_.Kill();
			}
			bool flag = false;
			Color color = Color.white;
			float duration = 0.25f;
			switch (lookingAt)
			{
			case LookingAt.Shape:
				flag = true;
				color = Color.green;
				break;
			case LookingAt.Enemy:
				color = Color.red;
				duration = 0.1f;
				break;
			}
			if (flag)
			{
				crossHairScaleTween_.Restart();
			}
			else
			{
				crossHairScaleTween_.Pause();
			}
			if (instant)
			{
				SetColor(color);
				return;
			}
			crossHairTween_ = DOTween.Sequence();
			crossHairTween_.Insert(0f, DOTween.To(() => crossHair_.centerTexture.color, delegate(Color s)
			{
				SetColor(s);
			}, color, duration));
			if (!flag && crossHair_.texturesRoot.localScale != Vector3.one)
			{
				crossHairTween_.Insert(0f, DOTween.To(() => crossHair_.texturesRoot.localScale, delegate(Vector3 s)
				{
					crossHair_.texturesRoot.localScale = s;
				}, Vector3.one, duration));
			}
		}

		public void SetCrosshairIcon(string icon)
		{
			if (!string.IsNullOrEmpty(icon))
			{
				QueueManager queueManager = SingletonManager.Get<QueueManager>();
				FileHolder fileHolder = nguiFileManager_.SetUiTexture(crossHair_.centerTexture, icon);
				crossHair_.centerTexture.gameObject.SetActive(true);
				crossHair_.centerTexture.enabled = false;
				queueManager.AddTask(fileHolder.fileGetter);
				queueManager.AddTask(delegate
				{
					crossHair_.centerTexture.MakePixelPerfect();
					crossHair_.centerTexture.width *= 2;
					crossHair_.centerTexture.height *= 2;
					if (fileHolder.loadedTexture != null)
					{
						crossHair_.centerTexture.enabled = true;
						fileHolder.loadedTexture.filterMode = FilterMode.Point;
					}
				});
			}
			else
			{
				crossHair_.centerTexture.gameObject.SetActive(false);
			}
		}

		public void SetCrosshairLegacyIcon(bool ranged)
		{
			crossHair_.centerTexture.enabled = false;
			crossHair_.centerTexture.mainTexture = ((!ranged) ? (meleeTexture_ ?? (meleeTexture_ = Resources.Load<Texture>("crosshair_melee"))) : (rangedTexture_ ?? (rangedTexture_ = Resources.Load<Texture>("crosshair_ranged"))));
			crossHair_.centerTexture.MakePixelPerfect();
			crossHair_.centerTexture.width *= 2;
			crossHair_.centerTexture.height *= 2;
			crossHair_.centerTexture.enabled = true;
		}

		public void SetCrosshairPartIcon(string icon)
		{
			if (!string.IsNullOrEmpty(icon))
			{
				QueueManager queueManager = SingletonManager.Get<QueueManager>();
				FileHolder fileHolder = nguiFileManager_.SetUiTexture(crossHair_.partTextures[0], icon);
				for (int i = 0; i < crossHair_.partTextures.Length; i++)
				{
					UITexture uITexture = crossHair_.partTextures[i];
					uITexture.gameObject.SetActive(true);
					uITexture.enabled = false;
				}
				queueManager.AddTask(fileHolder.fileGetter);
				queueManager.AddTask(delegate
				{
					if (fileHolder.loadedTexture != null)
					{
						for (int k = 0; k < crossHair_.partTextures.Length; k++)
						{
							UITexture uITexture3 = crossHair_.partTextures[k];
							uITexture3.mainTexture = fileHolder.loadedTexture;
							uITexture3.enabled = true;
							uITexture3.MakePixelPerfect();
							uITexture3.width *= 2;
							uITexture3.height *= 2;
						}
						crossHair_.centerTexture.enabled = true;
						fileHolder.loadedTexture.filterMode = FilterMode.Point;
					}
				});
			}
			else
			{
				for (int j = 0; j < crossHair_.partTextures.Length; j++)
				{
					UITexture uITexture2 = crossHair_.partTextures[j];
					uITexture2.gameObject.SetActive(false);
				}
			}
		}

		public void SetCrosshairScatter(float pixelSize)
		{
			float pixelSizeAdjustment = UIRoot.GetPixelSizeAdjustment(crossHair_.texturesRoot.gameObject);
			for (int i = 0; i < crossHair_.partTextures.Length; i++)
			{
				UITexture uITexture = crossHair_.partTextures[i];
				Vector3 vector = Quaternion.Inverse(crossHair_.texturesRoot.localRotation) * uITexture.transform.up;
				uITexture.transform.localPosition = vector * pixelSize * pixelSizeAdjustment;
			}
		}

		public void SetRotationAngle(float angle)
		{
			crossHair_.texturesRoot.localEulerAngles = new Vector3(0f, 0f, angle);
		}

		private void SetColor(Color color)
		{
			crossHair_.centerTexture.color = color;
			for (int i = 0; i < crossHair_.partTextures.Length; i++)
			{
				UITexture uITexture = crossHair_.partTextures[i];
				uITexture.color = color;
			}
		}

		private void SetPartTexture(UITexture uiTexture, Texture texture)
		{
			uiTexture.MakePixelPerfect();
			uiTexture.width *= 2;
			uiTexture.height *= 2;
		}
	}
}

using System;
using CraftyEngine.Infrastructure.FileSystem;
using Extensions;
using PlayerModule;
using UI3DModule;
using UnityEngine;

namespace ChestsViewModule
{
	public class ViewChest : IDisposable
	{
		public UI3DView ui3dView;

		public FileHolder fileHolder;

		public Animation animation;

		private Action callback_;

		public void Instantiate(int modelId, float scale = 1.15f, Action callback = null)
		{
			callback_ = callback;
			LoadArtikulModelManager singlton;
			SingletonManager.Get<LoadArtikulModelManager>(out singlton);
			singlton.GetModel(out fileHolder, modelId, delegate
			{
				SetChestModel(scale);
			});
		}

		private void SetChestModel(float scale)
		{
			if (fileHolder != null)
			{
				ui3dView = UI3DManager.InstantiateView(fileHolder, scale);
				if (ui3dView == null)
				{
					return;
				}
				animation = ui3dView.modelHolder.GetComponentInChildren<Animation>();
				if (animation != null)
				{
					animation.playAutomatically = false;
					animation["chest_impatience"].wrapMode = WrapMode.Loop;
					animation["chest_closing"].wrapMode = WrapMode.Once;
					Animate("chest_idle");
				}
				ui3dView.SwitchActive(false);
			}
			callback_.SafeInvoke();
		}

		public void SwitchActive(bool on)
		{
			if (ui3dView != null)
			{
				ui3dView.SwitchActive(on);
			}
		}

		public void SetParent(Transform parent, bool zeroPosition = false, bool ancor = true)
		{
			if (ui3dView != null)
			{
				ui3dView.SetParent(parent, zeroPosition, ancor);
			}
		}

		public void SetCameraDistance(float distance = 2.2f, float height = -0.3f)
		{
			if (ui3dView != null)
			{
				ui3dView.SetCameraDistance(distance, height);
			}
		}

		public void Animate(string animationState)
		{
			if (animation != null)
			{
				animation.Play(animationState);
			}
		}

		public void Dispose()
		{
			if (ui3dView != null)
			{
				ui3dView.Dispose();
			}
		}
	}
}

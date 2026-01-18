using DG.Tweening;
using HudSystem;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerWhiteBlinkController : HeadUpDisplay
	{
		private const float FLASH_TIME = 1f;

		private const float FLASH_ALPHA = 1f;

		private MistScreenHierarchy hierarchy_;

		private Tweener tween_;

		public MyPlayerWhiteBlinkController()
		{
			prefabsManager.Load("PlayerUiPrefabHolder");
			hierarchy_ = prefabsManager.InstantiateNGUIIn<MistScreenHierarchy>("UIWhiteMistScreen", nguiManager.UiRoot.gameObject);
			hierarchy_.widget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			hierarchy_.widget.alpha = 0f;
		}

		public void BlinkWhite()
		{
			if (tween_ != null)
			{
				tween_.Kill();
			}
			hierarchy_.widget.alpha = 1f;
			tween_ = DOTween.To(() => hierarchy_.widget.alpha, delegate(float a)
			{
				hierarchy_.widget.alpha = a;
			}, 0f, 1f).SetEase(Ease.InQuad);
		}

		public override void Dispose()
		{
			Object.Destroy(hierarchy_);
		}
	}
}

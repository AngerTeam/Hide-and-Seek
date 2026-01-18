using UnityEngine;

namespace ChestsViewModule
{
	public class UI3DViewTexture : UI3DView
	{
		private UITexture uiTexture_;

		public UI3DViewTexture(GameObject prefabInstance, float scale = 1f, bool autoUpdate = true)
			: base(prefabInstance, scale, autoUpdate)
		{
		}

		public override void SetParent(Transform parent, bool zeroPosition = false, bool ancor = true)
		{
			uiTexture_ = parent.GetComponent<UITexture>();
			if (uiTexture_ != null)
			{
				hierarchy_.ui3dCamera.targetTexture = new RenderTexture(uiTexture_.width, uiTexture_.height, uiTexture_.depth);
				hierarchy_.ui3dCamera.clearFlags = CameraClearFlags.Color;
				hierarchy_.ui3dCamera.backgroundColor = new Color(0f, 0f, 0f, 0f);
			}
			base.SetParent(parent, zeroPosition, ancor);
		}

		protected override void Update()
		{
			if (!(UICamera.currentCamera == null) && !(hierarchy_ == null) && (bool)uiTexture_)
			{
				RenderTexture active = RenderTexture.active;
				RenderTexture.active = hierarchy_.ui3dCamera.targetTexture;
				hierarchy_.ui3dCamera.Render();
				uiTexture_.mainTexture = RenderTexture.active;
				RenderTexture.active = active;
			}
		}
	}
}

using CraftyEngine.Infrastructure.FileSystem;
using PlayerModule.Playmate;
using UnityEngine;

namespace HideAndSeek
{
	public class VoxelMosntrBodyView : HumanBodyView
	{
		public VoxelMosntrBodyView()
			: base("PlayerVoxelMonstrFrame", HideAndSeekContentMap.HideSeekSettings.ANIMATIONS_ID_HIDEVOXELMONSTR)
		{
		}

		public override void Init()
		{
			model.visual.NicknameAnchorHeight = 2.5f;
			base.Init();
		}

		protected override FileHolder GetBodyBundle()
		{
			return GetBodyBundle(HideAndSeekContentMap.HideSeekSettings.HIDE_MONSTR_SKIN);
		}

		protected override void OnSkinApplyied()
		{
			gameObject.transform.localScale = Vector3.one * HideAndSeekContentMap.HideSeekSettings.hideAndSeekMonstrScale;
		}
	}
}

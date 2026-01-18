using CraftyEngine.Content;

namespace HideAndSeek
{
	public class HideSeekSettingsEntries : ContentItem
	{
		public int HIDE_SKIN = 55;

		public float hideCastTime = 2f;

		public float interactionDistanceHide = 3f;

		public int ANIMATIONS_ID_HIDEVOXEL = 53;

		public float hideAndSeekHiderSpeedBoost = 0.36f;

		public float hideAndSeekSeekerSpeedBoost = 0.16f;

		public int hideVoxelsCount = 10;

		public int HIDE_VOXELS_CHEST_ID = 72;

		public float hideAndSeekMonstrSpeedBoost = 1f;

		public int ANIMATIONS_ID_HIDEVOXELMONSTR = 71;

		public float hideAndSeekMonstrScale = 2f;

		public float hidePlayerDamageCoef = 2f;

		public float hidePlayerDefenseCoef = 0.2f;

		public int HIDE_MONSTR_SKIN = 82;

		public int MONSTER_STAGE_START_SOUND_ID = 85;

		public override void Deserialize()
		{
			HIDE_SKIN = TryGetInt(HideAndSeekContentKeys.HIDE_SKIN, 55);
			hideCastTime = TryGetFloat(HideAndSeekContentKeys.hideCastTime, 2f);
			interactionDistanceHide = TryGetFloat(HideAndSeekContentKeys.interactionDistanceHide, 3f);
			ANIMATIONS_ID_HIDEVOXEL = TryGetInt(HideAndSeekContentKeys.ANIMATIONS_ID_HIDEVOXEL, 53);
			hideAndSeekHiderSpeedBoost = TryGetFloat(HideAndSeekContentKeys.hideAndSeekHiderSpeedBoost, 0.36f);
			hideAndSeekSeekerSpeedBoost = TryGetFloat(HideAndSeekContentKeys.hideAndSeekSeekerSpeedBoost, 0.16f);
			hideVoxelsCount = TryGetInt(HideAndSeekContentKeys.hideVoxelsCount, 10);
			HIDE_VOXELS_CHEST_ID = TryGetInt(HideAndSeekContentKeys.HIDE_VOXELS_CHEST_ID, 72);
			hideAndSeekMonstrSpeedBoost = TryGetFloat(HideAndSeekContentKeys.hideAndSeekMonstrSpeedBoost, 1f);
			ANIMATIONS_ID_HIDEVOXELMONSTR = TryGetInt(HideAndSeekContentKeys.ANIMATIONS_ID_HIDEVOXELMONSTR, 71);
			hideAndSeekMonstrScale = TryGetFloat(HideAndSeekContentKeys.hideAndSeekMonstrScale, 2f);
			hidePlayerDamageCoef = TryGetFloat(HideAndSeekContentKeys.hidePlayerDamageCoef, 2f);
			hidePlayerDefenseCoef = TryGetFloat(HideAndSeekContentKeys.hidePlayerDefenseCoef, 0.2f);
			HIDE_MONSTR_SKIN = TryGetInt(HideAndSeekContentKeys.HIDE_MONSTR_SKIN, 82);
			MONSTER_STAGE_START_SOUND_ID = TryGetInt(HideAndSeekContentKeys.MONSTER_STAGE_START_SOUND_ID, 85);
			base.Deserialize();
		}
	}
}

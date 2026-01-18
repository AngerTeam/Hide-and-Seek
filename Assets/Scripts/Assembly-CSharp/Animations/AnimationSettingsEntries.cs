using CraftyEngine.Content;

namespace Animations
{
	public class AnimationSettingsEntries : ContentItem
	{
		public int ANIMATIONS_ID_MELEE = 9;

		public int ANIMATIONS_ID_RUN = 5;

		public int ANIMATIONS_ID_MELEE_ITEM = 62;

		public bool allowOverrideRun = true;

		public bool allowBlendWeight = true;

		public bool allowVericalRunAnimations;

		public override void Deserialize()
		{
			ANIMATIONS_ID_MELEE = TryGetInt(AnimationsContentKeys.ANIMATIONS_ID_MELEE, 9);
			ANIMATIONS_ID_RUN = TryGetInt(AnimationsContentKeys.ANIMATIONS_ID_RUN, 5);
			ANIMATIONS_ID_MELEE_ITEM = TryGetInt(AnimationsContentKeys.ANIMATIONS_ID_MELEE_ITEM, 62);
			base.Deserialize();
		}
	}
}

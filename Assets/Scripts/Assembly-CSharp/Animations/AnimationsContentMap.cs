using System.Collections.Generic;
using CraftyEngine.Content;

namespace Animations
{
	public class AnimationsContentMap : ContentMapBase
	{
		public static AnimationSettingsEntries AnimationSettings;

		public static Dictionary<int, AnimationsEntries> Animations;

		public override void Deserialize()
		{
			AnimationsContentKeys.Deserialize();
			AnimationSettings = FillSettings<AnimationSettingsEntries>("settings");
			Animations = ReadInt<AnimationsEntries>(AnimationsContentKeys.animations);
			base.Deserialize();
		}
	}
}

using System.Collections.Generic;
using CraftyEngine.Content;

namespace ExperienceModule
{
	public class ExpirienceContentMap : ContentMapBase
	{
		public static Dictionary<int, ExpLevelsEntries> ExpLevels;

		public override void Deserialize()
		{
			ExpirienceContentKeys.Deserialize();
			ExpLevels = ReadInt<ExpLevelsEntries>(ExpirienceContentKeys.exp_levels);
			base.Deserialize();
		}
	}
}

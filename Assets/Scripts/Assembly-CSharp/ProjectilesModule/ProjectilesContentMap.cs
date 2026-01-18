using System.Collections.Generic;
using CraftyEngine.Content;

namespace ProjectilesModule
{
	public class ProjectilesContentMap : ContentMapBase
	{
		public static Dictionary<int, ProjectilesEntries> Projectiles;

		public override void Deserialize()
		{
			ProjectilesContentKeys.Deserialize();
			Projectiles = ReadInt<ProjectilesEntries>(ProjectilesContentKeys.projectiles);
			base.Deserialize();
		}
	}
}

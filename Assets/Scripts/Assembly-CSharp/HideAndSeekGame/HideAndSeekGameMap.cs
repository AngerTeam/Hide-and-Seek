using System.Collections.Generic;
using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class HideAndSeekGameMap : ContentMapBase
	{
		public static GameConstantsEntries GameConstants;

		public static ProjectPicturesEntries ProjectPictures;

		public static Dictionary<int, IslandsEntries> Islands;

		public static Dictionary<int, LocationsEntries> Locations;

		public static Dictionary<int, LocationObjectsEntries> LocationObjects;

		public override void Deserialize()
		{
			HideAndSeekGametKeys.Deserialize();
			GameConstants = FillSettings<GameConstantsEntries>("settings");
			ProjectPictures = FillSettings<ProjectPicturesEntries>("settings");
			Islands = ReadInt<IslandsEntries>(HideAndSeekGametKeys.islands);
			Locations = ReadInt<LocationsEntries>(HideAndSeekGametKeys.locations);
			LocationObjects = ReadInt<LocationObjectsEntries>(HideAndSeekGametKeys.location_objects);
			base.Deserialize();
		}
	}
}

using System.Collections.Generic;
using CraftyEngine.Content;

namespace ArticulView
{
	public class ArticulViewContentMap : ContentMapBase
	{
		public static Dictionary<int, ArtikulModelsEntries> ArtikulModels;

		public static Dictionary<int, SkinsEntries> Skins;

		public override void Deserialize()
		{
			ArticulViewContentKeys.Deserialize();
			ArtikulModels = ReadInt<ArtikulModelsEntries>(ArticulViewContentKeys.artikul_models);
			Skins = ReadInt<SkinsEntries>(ArticulViewContentKeys.skins);
			base.Deserialize();
		}
	}
}

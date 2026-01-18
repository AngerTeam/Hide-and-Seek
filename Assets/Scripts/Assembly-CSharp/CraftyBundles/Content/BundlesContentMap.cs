using System.Collections.Generic;
using CraftyEngine.Content;

namespace CraftyBundles.Content
{
	public class BundlesContentMap : ContentMapBase
	{
		public static Dictionary<int, AtlasesEntries> Atlases;

		public override void Deserialize()
		{
			BundlesContentKeys.Deserialize();
			Atlases = ReadInt<AtlasesEntries>(BundlesContentKeys.atlases);
			base.Deserialize();
		}
	}
}

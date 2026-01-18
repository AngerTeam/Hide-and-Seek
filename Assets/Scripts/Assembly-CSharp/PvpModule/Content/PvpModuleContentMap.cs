using System.Collections.Generic;
using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class PvpModuleContentMap : ContentMapBase
	{
		public static PvpSettingsEntries PvpSettings;

		public static Dictionary<int, NicknamesEntries> Nicknames;

		public static Dictionary<int, PvpModesEntries> PvpModes;

		public static Dictionary<int, TerrainsEntries> Terrains;

		public static Dictionary<int, MapsEntries> Maps;

		public static Dictionary<int, MapModesEntries> MapModes;

		public static Dictionary<int, MapTerrainsEntries> MapTerrains;

		public override void Deserialize()
		{
			PvpModuleContentKeys.Deserialize();
			PvpSettings = FillSettings<PvpSettingsEntries>("settings");
			Nicknames = ReadInt<NicknamesEntries>(PvpModuleContentKeys.nicknames);
			PvpModes = ReadInt<PvpModesEntries>(PvpModuleContentKeys.pvp_modes);
			Terrains = ReadInt<TerrainsEntries>(PvpModuleContentKeys.terrains);
			Maps = ReadInt<MapsEntries>(PvpModuleContentKeys.maps);
			MapModes = ReadInt<MapModesEntries>(PvpModuleContentKeys.map_modes);
			MapTerrains = ReadInt<MapTerrainsEntries>(PvpModuleContentKeys.map_terrains);
			base.Deserialize();
		}
	}
}

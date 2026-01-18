using System.Collections.Generic;
using CraftyEngine.Content;

namespace WeaponSightsModule
{
	public class WeaponSightsContentMap : ContentMapBase
	{
		public static WeaponSightsSettingsEntries WeaponSightsSettings;

		public static Dictionary<int, WeaponSightsEntries> WeaponSights;

		public override void Deserialize()
		{
			WeaponSightsContentKeys.Deserialize();
			WeaponSightsSettings = FillSettings<WeaponSightsSettingsEntries>("settings");
			WeaponSights = ReadInt<WeaponSightsEntries>(WeaponSightsContentKeys.weapon_sights);
			base.Deserialize();
		}
	}
}

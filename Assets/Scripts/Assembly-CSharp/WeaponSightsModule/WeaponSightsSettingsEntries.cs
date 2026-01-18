using CraftyEngine.Content;

namespace WeaponSightsModule
{
	public class WeaponSightsSettingsEntries : ContentItem
	{
		public int meleeWeaponSightId = 1;

		public int rangeWeaponSightId = 2;

		public WeaponSightsEntries meleeWeaponSight;

		public WeaponSightsEntries rangeWeaponSight;

		public override void Deserialize()
		{
			meleeWeaponSightId = TryGetInt(WeaponSightsContentKeys.meleeWeaponSightId, 1);
			rangeWeaponSightId = TryGetInt(WeaponSightsContentKeys.rangeWeaponSightId, 2);
			base.Deserialize();
		}
	}
}

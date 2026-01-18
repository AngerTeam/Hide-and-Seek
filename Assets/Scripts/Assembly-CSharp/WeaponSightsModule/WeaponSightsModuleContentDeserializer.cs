using CraftyEngine.Content;

namespace WeaponSightsModule
{
	public class WeaponSightsModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<WeaponSightsContentMap>();
			if (WeaponSightsContentMap.WeaponSights == null)
			{
				return;
			}
			foreach (WeaponSightsEntries value in WeaponSightsContentMap.WeaponSights.Values)
			{
				value.aim_enable = value.aim_fov < 1f;
			}
			WeaponSightsContentMap.WeaponSights.TryGetValue(WeaponSightsContentMap.WeaponSightsSettings.meleeWeaponSightId, out WeaponSightsContentMap.WeaponSightsSettings.meleeWeaponSight);
			WeaponSightsContentMap.WeaponSights.TryGetValue(WeaponSightsContentMap.WeaponSightsSettings.rangeWeaponSightId, out WeaponSightsContentMap.WeaponSightsSettings.rangeWeaponSight);
		}
	}
}

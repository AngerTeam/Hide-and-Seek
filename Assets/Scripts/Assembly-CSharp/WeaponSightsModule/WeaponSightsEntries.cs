using CraftyEngine.Content;

namespace WeaponSightsModule
{
	public class WeaponSightsEntries : ContentItem
	{
		public int id;

		public string title;

		public string primary_crosshair_icon;

		public string primary_crosshair_part_icon;

		public string aim_crosshair_icon;

		public string aim_crosshair_part_icon;

		public string aim_background_icon;

		public float aim_fov;

		public float aim_weapon_range_ratio;

		public int auto_aiming;

		public int sniper_auto_aiming;

		public float aim_sensitivity_ratio;

		public float rotation;

		public bool aim_enable;

		public string GetFullPrimaryCrosshairIconPath()
		{
			return WeaponSightsContentKeys.GetFullPrimaryCrosshairIconPath24 + primary_crosshair_icon;
		}

		public string GetFullPrimaryCrosshairPartIconPath()
		{
			return WeaponSightsContentKeys.GetFullPrimaryCrosshairPartIconPath25 + primary_crosshair_part_icon;
		}

		public string GetFullAimCrosshairIconPath()
		{
			return WeaponSightsContentKeys.GetFullAimCrosshairIconPath26 + aim_crosshair_icon;
		}

		public string GetFullAimCrosshairPartIconPath()
		{
			return WeaponSightsContentKeys.GetFullAimCrosshairPartIconPath27 + aim_crosshair_part_icon;
		}

		public string GetFullAimBackgroundIconPath()
		{
			return WeaponSightsContentKeys.GetFullAimBackgroundIconPath28 + aim_background_icon;
		}

		public override void Deserialize()
		{
			id = TryGetInt(WeaponSightsContentKeys.id);
			intKey = id;
			title = TryGetString(WeaponSightsContentKeys.title, string.Empty);
			primary_crosshair_icon = TryGetString(WeaponSightsContentKeys.primary_crosshair_icon, string.Empty);
			primary_crosshair_part_icon = TryGetString(WeaponSightsContentKeys.primary_crosshair_part_icon, string.Empty);
			aim_crosshair_icon = TryGetString(WeaponSightsContentKeys.aim_crosshair_icon, string.Empty);
			aim_crosshair_part_icon = TryGetString(WeaponSightsContentKeys.aim_crosshair_part_icon, string.Empty);
			aim_background_icon = TryGetString(WeaponSightsContentKeys.aim_background_icon, string.Empty);
			aim_fov = TryGetFloat(WeaponSightsContentKeys.aim_fov);
			aim_weapon_range_ratio = TryGetFloat(WeaponSightsContentKeys.aim_weapon_range_ratio);
			auto_aiming = TryGetInt(WeaponSightsContentKeys.auto_aiming);
			sniper_auto_aiming = TryGetInt(WeaponSightsContentKeys.sniper_auto_aiming);
			aim_sensitivity_ratio = TryGetFloat(WeaponSightsContentKeys.aim_sensitivity_ratio);
			rotation = TryGetFloat(WeaponSightsContentKeys.rotation);
			base.Deserialize();
		}
	}
}

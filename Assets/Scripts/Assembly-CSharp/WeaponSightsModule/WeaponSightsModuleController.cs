using HudSystem;
using InventoryModule;

namespace WeaponSightsModule
{
	public class WeaponSightsModuleController : Singleton
	{
		public static void InitModule()
		{
			SingletonManager.Add<WeaponSightsModuleContentDeserializer>(1);
			SingletonManager.Add<WeaponSightsModuleController>(1);
		}

		public override void OnDataLoaded()
		{
			foreach (ArtikulsEntries value in InventoryContentMap.Artikuls.Values)
			{
				WeaponSightsEntries weaponSight = value.WeaponSight;
				if (weaponSight != null)
				{
					value.weapon_range_aim = weaponSight.aim_weapon_range_ratio * value.weapon_range;
					value.autoaiming_enable = weaponSight.auto_aiming != 0;
					value.sniper_autoaiming_enable = weaponSight.sniper_auto_aiming != 0;
				}
				else
				{
					value.weapon_range_aim = value.weapon_range;
				}
			}
			GuiModuleHolder.Add<CrosshairHud>();
			GuiModuleHolder.Add<AimScopeHud>();
		}
	}
}

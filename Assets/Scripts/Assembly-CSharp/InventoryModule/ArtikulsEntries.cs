using System.Collections.Generic;
using Animations;
using CraftyEngine.Content;
using FxModule;
using HideAndSeek;
using ProjectilesModule;
using WeaponSightsModule;

namespace InventoryModule
{
	public class ArtikulsEntries : ContentItem
	{
		public ArtikulsAnimations myPlayerAnimations;

		public ArtikulsAnimations playmateAnimations;

		private FxEntries[] fxEntries_;

		public HideVoxelsEntries hideVoxel;

		public int id;

		public int type_id;

		public int group_id;

		public int kind_id;

		public int voxel_id;

		public int model_id;

		public int rarity_id;

		public string player_slot_id;

		public string title;

		public string description;

		public int building_id;

		public int instrument_id;

		public int stack_size;

		public int flags;

		public int fuel_type_id;

		public int fuel_time;

		public string icon;

		public string large_icon;

		public string large_icon_preview;

		public int sound_group_id;

		public int cooldown_sound_group_id;

		public int reload_sound_group_id;

		public int durability_type_id;

		public int durability;

		public int block_damage;

		public int block_damage_common;

		public int damage;

		public float hit_repulsion_force;

		public float cooldown;

		public float weapon_range;

		public int weapon_type;

		public int weapon_sight_id;

		public int reload_shots;

		public float reload_time;

		public int projectile_id;

		public int ability_id;

		public int projectiles_per_shot;

		public float weapon_recoil_force;

		public float weapon_recoil_max;

		public float scatter_first_angle;

		public float scatter_max_angle;

		public float scatter_running_angle;

		public float scatter_inc_step;

		public float scatter_dec_speed;

		public float scatter_dec_pause;

		public float scatter_aim_ratio;

		public int chest_open_time;

		public int chest_boost_price;

		public int chest_bonus_id;

		public int min_level;

		public string offset_in_hand;

		public string client_version;

		public int animation_first_person;

		public int animation_third_person;

		public int animation_item;

		public int projectile;

		public int projectile_fx_id;

		public int shot_fx_id;

		public float slowdown_factor;

		public float slowdown_factor_impact;

		public float slowdown_aim_factor;

		public float sort_val;

		public int can_unlock;

		public int unlock_price_type;

		public int unlock_price;

		public bool isHand;

		public WeaponTypesEntries weaponType;

		public bool ranged;

		public int iconId;

		private ProjectilesEntries projectileEntry_;

		public float weapon_range_aim;

		public bool autoaiming_enable;

		public bool sniper_autoaiming_enable;

		private WeaponSightsEntries weaponSight_;

		public FxEntries[] FxEntries
		{
			get
			{
				if (FxContentMap.ArtikulFx == null)
				{
					return null;
				}
				if (fxEntries_ != null)
				{
					return fxEntries_;
				}
				List<FxEntries> list = new List<FxEntries>();
				foreach (ArtikulFxEntries value in FxContentMap.ArtikulFx.Values)
				{
					if (value.artikul_id == id)
					{
						list.Add(FxContentMap.Fx[value.fx_id]);
					}
				}
				fxEntries_ = list.ToArray();
				return fxEntries_;
			}
		}

		public ProjectilesEntries ProjectileEntry
		{
			get
			{
				if (projectile_id == 0 || ProjectilesContentMap.Projectiles == null)
				{
					return null;
				}
				if (projectileEntry_ != null)
				{
					return projectileEntry_;
				}
				ProjectilesContentMap.Projectiles.TryGetValue(projectile_id, out projectileEntry_);
				return projectileEntry_;
			}
		}

		public WeaponSightsEntries WeaponSight
		{
			get
			{
				if (WeaponSightsContentMap.WeaponSights == null)
				{
					return null;
				}
				if (weaponSight_ != null)
				{
					return weaponSight_;
				}
				if (!WeaponSightsContentMap.WeaponSights.TryGetValue(weapon_sight_id, out weaponSight_))
				{
					if (weaponType != null)
					{
						if (!WeaponSightsContentMap.WeaponSights.TryGetValue(weaponType.weapon_sight_id, out weaponSight_))
						{
							weaponSight_ = ((!ranged) ? WeaponSightsContentMap.WeaponSightsSettings.meleeWeaponSight : WeaponSightsContentMap.WeaponSightsSettings.rangeWeaponSight);
						}
					}
					else
					{
						weaponSight_ = WeaponSightsContentMap.WeaponSightsSettings.meleeWeaponSight;
					}
				}
				return weaponSight_;
			}
		}

		public ArtikulsEntries()
		{
			myPlayerAnimations = new ArtikulsAnimations();
			playmateAnimations = new ArtikulsAnimations();
		}

		public string GetFullLargeIconPath()
		{
			return InventoryContentKeys.GetFullLargeIconPath2 + large_icon;
		}

		public string GetFullLargeIconPreviewPath()
		{
			return InventoryContentKeys.GetFullLargeIconPreviewPath3 + large_icon_preview;
		}

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			type_id = TryGetInt(InventoryContentKeys.type_id);
			group_id = TryGetInt(InventoryContentKeys.group_id);
			kind_id = TryGetInt(InventoryContentKeys.kind_id);
			voxel_id = TryGetInt(InventoryContentKeys.voxel_id);
			model_id = TryGetInt(InventoryContentKeys.model_id);
			rarity_id = TryGetInt(InventoryContentKeys.rarity_id);
			player_slot_id = TryGetString(InventoryContentKeys.player_slot_id, string.Empty);
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			description = TryGetString(InventoryContentKeys.description, string.Empty);
			building_id = TryGetInt(InventoryContentKeys.building_id);
			instrument_id = TryGetInt(InventoryContentKeys.instrument_id);
			stack_size = TryGetInt(InventoryContentKeys.stack_size);
			flags = TryGetInt(InventoryContentKeys.flags);
			fuel_type_id = TryGetInt(InventoryContentKeys.fuel_type_id);
			fuel_time = TryGetInt(InventoryContentKeys.fuel_time);
			icon = TryGetString(InventoryContentKeys.icon, string.Empty);
			large_icon = TryGetString(InventoryContentKeys.large_icon, string.Empty);
			large_icon_preview = TryGetString(InventoryContentKeys.large_icon_preview, string.Empty);
			sound_group_id = TryGetInt(InventoryContentKeys.sound_group_id);
			cooldown_sound_group_id = TryGetInt(InventoryContentKeys.cooldown_sound_group_id);
			reload_sound_group_id = TryGetInt(InventoryContentKeys.reload_sound_group_id);
			durability_type_id = TryGetInt(InventoryContentKeys.durability_type_id);
			durability = TryGetInt(InventoryContentKeys.durability);
			block_damage = TryGetInt(InventoryContentKeys.block_damage);
			block_damage_common = TryGetInt(InventoryContentKeys.block_damage_common);
			damage = TryGetInt(InventoryContentKeys.damage);
			hit_repulsion_force = TryGetFloat(InventoryContentKeys.hit_repulsion_force);
			cooldown = TryGetFloat(InventoryContentKeys.cooldown);
			weapon_range = TryGetFloat(InventoryContentKeys.weapon_range);
			weapon_type = TryGetInt(InventoryContentKeys.weapon_type);
			weapon_sight_id = TryGetInt(InventoryContentKeys.weapon_sight_id);
			reload_shots = TryGetInt(InventoryContentKeys.reload_shots);
			reload_time = TryGetFloat(InventoryContentKeys.reload_time);
			projectile_id = TryGetInt(InventoryContentKeys.projectile_id);
			ability_id = TryGetInt(InventoryContentKeys.ability_id);
			projectiles_per_shot = TryGetInt(InventoryContentKeys.projectiles_per_shot);
			weapon_recoil_force = TryGetFloat(InventoryContentKeys.weapon_recoil_force);
			weapon_recoil_max = TryGetFloat(InventoryContentKeys.weapon_recoil_max);
			scatter_first_angle = TryGetFloat(InventoryContentKeys.scatter_first_angle);
			scatter_max_angle = TryGetFloat(InventoryContentKeys.scatter_max_angle);
			scatter_running_angle = TryGetFloat(InventoryContentKeys.scatter_running_angle);
			scatter_inc_step = TryGetFloat(InventoryContentKeys.scatter_inc_step);
			scatter_dec_speed = TryGetFloat(InventoryContentKeys.scatter_dec_speed);
			scatter_dec_pause = TryGetFloat(InventoryContentKeys.scatter_dec_pause);
			scatter_aim_ratio = TryGetFloat(InventoryContentKeys.scatter_aim_ratio);
			chest_open_time = TryGetInt(InventoryContentKeys.chest_open_time);
			chest_boost_price = TryGetInt(InventoryContentKeys.chest_boost_price);
			chest_bonus_id = TryGetInt(InventoryContentKeys.chest_bonus_id);
			min_level = TryGetInt(InventoryContentKeys.min_level);
			offset_in_hand = TryGetString(InventoryContentKeys.offset_in_hand, string.Empty);
			client_version = TryGetString(InventoryContentKeys.client_version, string.Empty);
			animation_first_person = TryGetInt(InventoryContentKeys.animation_first_person);
			animation_third_person = TryGetInt(InventoryContentKeys.animation_third_person);
			animation_item = TryGetInt(InventoryContentKeys.animation_item);
			projectile = TryGetInt(InventoryContentKeys.projectile);
			projectile_fx_id = TryGetInt(InventoryContentKeys.projectile_fx_id);
			shot_fx_id = TryGetInt(InventoryContentKeys.shot_fx_id);
			slowdown_factor = TryGetFloat(InventoryContentKeys.slowdown_factor);
			slowdown_factor_impact = TryGetFloat(InventoryContentKeys.slowdown_factor_impact);
			slowdown_aim_factor = TryGetFloat(InventoryContentKeys.slowdown_aim_factor);
			sort_val = TryGetFloat(InventoryContentKeys.sort_val);
			can_unlock = TryGetInt(InventoryContentKeys.can_unlock);
			unlock_price_type = TryGetInt(InventoryContentKeys.unlock_price_type);
			unlock_price = TryGetInt(InventoryContentKeys.unlock_price);
			base.Deserialize();
		}
	}
}

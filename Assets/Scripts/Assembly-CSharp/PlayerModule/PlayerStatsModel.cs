using System;
using CraftyVoxelEngine;
using Extensions;
using HideAndSeek;
using InventoryModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace PlayerModule
{
	[Serializable]
	public class PlayerStatsModel : IDisposable, IDynamicObstacle
	{
		public PlayerHideAndSeekModel hideAndSeek;

		public PlayerVisualModel visual;

		public int HealthMax;

		public bool IsDummy;

		public bool IsCocky;

		[SerializeField]
		private int action_;

		public int networkAction;

		public int MobId;

		public bool ResetRoleState;

		public int SpawnTime;

		public int StreakCurrent;

		public string nickname;

		public bool online;

		public string persId = string.Empty;

		public int place;

		private int reward_;

		public int points;

		private int battleExperiance_;

		public MyPlayerExperianceModel experiance;

		public ProjectileModel projectile;

		public PlayerVisibilityModel visibility;

		public PlayerCombatModel combat;

		public IVisible resultVisibility;

		[SerializeField]
		private int skindId_;

		[SerializeField]
		private int bodyType_;

		public bool allowSpawnReport;

		public bool reportSpawnPending;

		public bool allowArtikulChange;

		[SerializeField]
		private int selectedArtikul_;

		private bool allowAttack_;

		public string AttackerId;

		[SerializeField]
		private int healthCurrent_;

		[SerializeField]
		private bool isDead_;

		private bool aiming_;

		public bool jumping;

		public float moveSpeed;

		private bool reloading_;

		private int ammo_;

		private int grenadeAmmo_;

		public bool IsMob
		{
			get
			{
				return BodyType == 4;
			}
		}

		public bool HasPosition
		{
			get
			{
				return visibility.ByServerPosition;
			}
		}

		public bool IsMyPlayer { get; set; }

		public int action
		{
			get
			{
				return action_;
			}
			set
			{
				if (action_ != value)
				{
					action_ = value;
					this.ActionChanged.SafeInvoke();
				}
			}
		}

		public int reward
		{
			get
			{
				return reward_;
			}
			set
			{
				if (value != reward_)
				{
					reward_ = value;
					this.RewardUpdated.SafeInvoke();
				}
			}
		}

		public int BattleExperiance
		{
			get
			{
				return battleExperiance_;
			}
			set
			{
				if (battleExperiance_ != value)
				{
					battleExperiance_ = value;
					this.BattleExperianceChanged.SafeInvoke();
				}
			}
		}

		public int SkinId
		{
			get
			{
				return skindId_;
			}
			set
			{
				if (skindId_ != value)
				{
					skindId_ = value;
					this.SkinChanged.SafeInvoke(skindId_);
				}
			}
		}

		public int BodyType
		{
			get
			{
				return bodyType_;
			}
			set
			{
				if (bodyType_ != value)
				{
					bodyType_ = value;
					this.BodyTypeChanged.SafeInvoke();
				}
			}
		}

		public Vector3 Position { get; private set; }

		public Vector3 Rotation { get; private set; }

		public float artikulReloadTime
		{
			get
			{
				ArtikulsEntries weapon = InventoryModuleController.GetWeapon(SelectedArtikul);
				if (weapon == null)
				{
					return 0f;
				}
				return weapon.reload_time;
			}
		}

		public bool artikulReloadEnable
		{
			get
			{
				ArtikulsEntries weapon = InventoryModuleController.GetWeapon(SelectedArtikul);
				if (weapon == null)
				{
					return false;
				}
				return weapon.reload_shots > 0;
			}
		}

		public int SelectedArtikul
		{
			get
			{
				return selectedArtikul_;
			}
			set
			{
				if (allowArtikulChange)
				{
					bool flag = selectedArtikul_ != value;
					selectedArtikul_ = value;
					if (flag)
					{
						this.SelectedArtikulChanged.SafeInvoke(selectedArtikul_);
					}
				}
			}
		}

		[SerializeField]
		public int Side { get; private set; }

		public bool AllowAttack
		{
			get
			{
				return allowAttack_;
			}
			set
			{
				if (allowAttack_ != value)
				{
					allowAttack_ = value;
					this.AllowAttackChaned.SafeInvoke();
				}
			}
		}

		public bool InMyPlayerTeam { get; private set; }

		public int HealthCurrent
		{
			get
			{
				return healthCurrent_;
			}
			set
			{
				if (healthCurrent_ != value)
				{
					int param = healthCurrent_;
					healthCurrent_ = value;
					if (value > HealthMax)
					{
						healthCurrent_ = HealthMax;
					}
					if (healthCurrent_ <= 0)
					{
						IsDead = true;
						healthCurrent_ = 0;
					}
					else
					{
						IsDead = false;
					}
					if (HealthMax == 0 || IsDummy)
					{
						visibility.ByHealth = true;
					}
					else
					{
						visibility.ByHealth = !IsDead;
					}
					this.HealthChanged.SafeInvoke(param, healthCurrent_, AttackerId);
				}
			}
		}

		public bool IsDead
		{
			get
			{
				return isDead_;
			}
			set
			{
				if (isDead_ != value)
				{
					isDead_ = value;
					if (isDead_)
					{
						Reset();
						this.Died.SafeInvoke();
					}
					else
					{
						this.Ressurected.SafeInvoke();
					}
				}
			}
		}

		public bool Aiming
		{
			get
			{
				return aiming_;
			}
			set
			{
				if (aiming_ != value)
				{
					aiming_ = value;
					this.AimingChanged.SafeInvoke(aiming_);
				}
			}
		}

		public bool Reloading
		{
			get
			{
				return reloading_;
			}
			set
			{
				if (reloading_ != value)
				{
					reloading_ = value;
					this.Reload.SafeInvoke(reloading_);
				}
			}
		}

		public int Ammo
		{
			get
			{
				return ammo_;
			}
			set
			{
				ammo_ = value;
				this.Shot.SafeInvoke(ammo_);
			}
		}

		public int GrenadeAmmo
		{
			get
			{
				return grenadeAmmo_;
			}
			set
			{
				if (grenadeAmmo_ != value)
				{
					grenadeAmmo_ = value;
					this.GrenadeAmmoChanged.SafeInvoke(grenadeAmmo_);
				}
			}
		}

		public float WeaponScatter { get; set; }

		public event Action Reseted;

		public event Action ActionChanged;

		public event Action RewardUpdated;

		public event Action BattleExperianceChanged;

		public event Action Respawned;

		public event Action<int> SkinChanged;

		public event Action BodyTypeChanged;

		public event Action<bool> PositionUpdated;

		public event Action<int> SelectedArtikulChanged;

		public event Action SideChanged;

		public event Action AllowAttackChaned;

		public event Action<int, int, string> HealthChanged;

		public event Action<Vector3, float> PushPlayer;

		public event Action BlinkRed;

		public event Action Died;

		public event Action Ressurected;

		public event Action<bool> AimingChanged;

		public event Action<bool> Reload;

		public event Action<int> Shot;

		public event Action<int> GrenadeAmmoChanged;

		public PlayerStatsModel()
		{
			visual = new PlayerVisualModel();
			allowArtikulChange = true;
			allowAttack_ = true;
			experiance = new MyPlayerExperianceModel();
			online = true;
			projectile = new ProjectileModel();
			visibility = new PlayerVisibilityModel();
			resultVisibility = visibility;
			combat = new PlayerCombatModel();
		}

		public static PlayerStatsModel Clone(PlayerStatsModel source)
		{
			PlayerStatsModel playerStatsModel = new PlayerStatsModel();
			playerStatsModel.persId = source.persId + " (clone)";
			playerStatsModel.nickname = source.nickname;
			playerStatsModel.experiance.level = source.experiance.level;
			playerStatsModel.SelectedArtikul = source.SelectedArtikul;
			playerStatsModel.SkinId = source.SkinId;
			playerStatsModel.HealthCurrent = source.HealthCurrent;
			playerStatsModel.Position = source.Position;
			playerStatsModel.Rotation = source.Rotation;
			return playerStatsModel;
		}

		public void SetSpawnTime(int spawnTime)
		{
			if (spawnTime != 0)
			{
				SpawnTime = spawnTime;
			}
		}

		public override string ToString()
		{
			return string.Format("player {0} place:{1} reward:{2} kills:{4} {3}", persId, place, reward, (!IsMyPlayer) ? string.Empty : "(player)", combat.KillFragsCount);
		}

		public void Dispose()
		{
			this.SkinChanged = null;
			this.PositionUpdated = null;
			this.SelectedArtikulChanged = null;
			this.SideChanged = null;
			this.HealthChanged = null;
			this.Died = null;
			this.Ressurected = null;
			this.Respawned = null;
			visibility.Dispose();
			combat.Dispose();
		}

		public void Reset()
		{
			IsCocky = false;
			action = 0;
			StreakCurrent = 0;
			this.Reseted.SafeInvoke();
		}

		public void Respawn()
		{
			this.Respawned.SafeInvoke();
		}

		public void SetPosition(Vector3 position, Vector3 rotation, bool interpolate = true)
		{
			Rotation = rotation;
			SetPosition(position, interpolate);
		}

		public void SetPosition(Vector3 position, bool interpolate = true)
		{
			if (allowSpawnReport && !interpolate)
			{
				reportSpawnPending = true;
			}
			Position = position;
			this.PositionUpdated.SafeInvoke(interpolate);
		}

		public void SetSide(int side, bool inMyPlayerTeam)
		{
			bool flag = Side != side || InMyPlayerTeam != inMyPlayerTeam;
			Side = side;
			InMyPlayerTeam = inMyPlayerTeam;
			if (flag)
			{
				this.SideChanged.SafeInvoke();
			}
		}

		public void ResetPlayerHealth()
		{
			HealthCurrent = HealthMax;
		}

		public void InvokePushPlayer(Vector3 direction, float pushForce)
		{
			if (!isDead_)
			{
				this.PushPlayer.SafeInvoke(direction, pushForce);
			}
		}

		public void InvokeBlinkRed()
		{
			if (!isDead_)
			{
				this.BlinkRed.SafeInvoke();
			}
		}
	}
}

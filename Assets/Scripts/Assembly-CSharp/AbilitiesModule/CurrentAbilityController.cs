using System;
using FxModule;
using InventoryModule;
using PlayerModule;
using UnityEngine;

namespace AbilitiesModule
{
	public class CurrentAbilityController : IDisposable
	{
		private FxView[] fxViews;

		private AbilitiesHolder abilitiesHolder_;

		private int projectile_;

		public AbilityModel CurrentAbility { get; private set; }

		public CurrentAbilityController()
		{
			SingletonManager.Get<AbilitiesHolder>(out abilitiesHolder_);
		}

		public void AbilityStart(ProjectileModel projectileModel)
		{
			if (fxViews != null)
			{
				FxView[] array = fxViews;
				foreach (FxView fxView in array)
				{
					fxView.SendProjectile(projectileModel);
					fxView.HandleMoment("start");
				}
			}
		}

		public void AbilityContactHappened()
		{
			if (fxViews != null)
			{
				FxView[] array = fxViews;
				foreach (FxView fxView in array)
				{
					fxView.HandleMoment("contact");
				}
			}
		}

		public void SetAbility(int artikulId)
		{
			ArtikulsEntries weapon = InventoryModuleController.GetWeapon(artikulId);
			SetAbility(weapon);
		}

		public void SetAbility(ArtikulsEntries artikulData)
		{
			projectile_ = artikulData.projectile;
			if (artikulData.ability_id > 0)
			{
				AbilityModel value;
				if (abilitiesHolder_.Abilities.TryGetValue(artikulData.ability_id, out value))
				{
					CurrentAbility = value;
					return;
				}
				Log.Error("Ability not found:" + artikulData.ability_id);
				CurrentAbility = null;
			}
			else
			{
				CurrentAbility = null;
			}
		}

		public void LoadFx(GameObject instance = null)
		{
			if (CurrentAbility != null)
			{
				fxViews = new FxView[CurrentAbility.actionModels.Count];
				for (int i = 0; i < CurrentAbility.actionModels.Count; i++)
				{
					fxViews[i] = new FxView(instance, projectile_, CurrentAbility.actionModels[i].fxEntries.ToArray(), null, 0f);
				}
			}
			else
			{
				fxViews = new FxView[0];
			}
		}

		public void Dispose()
		{
			if (fxViews != null)
			{
				FxView[] array = fxViews;
				foreach (FxView fxView in array)
				{
					fxView.Dispose();
				}
			}
		}
	}
}

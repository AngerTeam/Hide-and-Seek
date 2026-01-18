using System;
using InventoryModule;

namespace PlayerModule
{
	public abstract class ArtikulHandler : IDisposable
	{
		protected ArtikulsEntries selectedArtikul;

		public PlayerStatsModel Model { get; private set; }

		protected void SetModel(PlayerStatsModel model, bool instantUpdate = true)
		{
			Model = model;
			model.SelectedArtikulChanged += HandleSelectedArtikulChanged;
			if (instantUpdate)
			{
				GetArtikul();
			}
		}

		protected virtual void UpdateArtikul()
		{
		}

		protected void GetArtikul()
		{
			HandleSelectedArtikulChanged(Model.SelectedArtikul);
		}

		private void HandleSelectedArtikulChanged(int id)
		{
			if (!InventoryContentMap.Artikuls.TryGetValue(id, out selectedArtikul))
			{
				selectedArtikul = InventoryContentMap.CraftSettings.handArtikul;
			}
			UpdateArtikul();
		}

		public virtual void Dispose()
		{
			Model.SelectedArtikulChanged -= HandleSelectedArtikulChanged;
		}
	}
}

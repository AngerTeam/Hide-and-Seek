using System;

namespace InventoryModule
{
	[Serializable]
	public class ArtikulItem
	{
		private static ArtikulsEntries fakeEntry_ = new ArtikulsEntries
		{
			title = "Unknown Artikul",
			id = int.MaxValue
		};

		private int amount_;

		private int wear_;

		public bool infiniteLogic;

		public bool infiniteView;

		public int Amount
		{
			get
			{
				return amount_;
			}
			set
			{
				if (amount_ != value)
				{
					Dirty = true;
					amount_ = value;
				}
			}
		}

		public int AmountMax
		{
			get
			{
				return Entry.stack_size;
			}
		}

		public int IconId { get; private set; }

		public int ArtikulId { get; private set; }

		public bool Dirty { get; set; }

		public ArtikulsEntries Entry { get; private set; }

		public bool IsTemp { get; set; }

		public bool Wearable
		{
			get
			{
				return WearMax != 0 && (Entry.type_id == 3 || Entry.type_id == 4);
			}
		}

		public int Wear
		{
			get
			{
				return wear_;
			}
			set
			{
				if (wear_ != value)
				{
					Dirty = true;
					wear_ = value;
				}
			}
		}

		public int WearMax
		{
			get
			{
				return Entry.durability;
			}
		}

		public ArtikulItem(ArtikulItem source)
		{
			ArtikulId = source.ArtikulId;
			IsTemp = source.IsTemp;
			Amount = source.Amount;
			Wear = source.Wear;
			Init();
		}

		public ArtikulItem(int artikul, int amount = 1, int wear = 0, bool isTemp = false)
		{
			ArtikulId = artikul;
			IsTemp = isTemp;
			Amount = amount;
			Wear = wear;
			Init();
		}

		public void Undirtyfy()
		{
			Dirty = false;
		}

		private void Init()
		{
			ArtikulsEntries value;
			Entry = ((!InventoryContentMap.Artikuls.TryGetValue(ArtikulId, out value)) ? fakeEntry_ : value);
			IconId = ((Entry.iconId != 0) ? Entry.iconId : ArtikulId);
		}
	}
}

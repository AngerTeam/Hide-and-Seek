using System;
using Extensions;
using InventoryViewModule;

namespace InventoryModule
{
	[Serializable]
	public class SlotModel
	{
		public ArtikulItem GhostItem;

		public int groupId;

		public int index;

		public string name;

		public char slotType;

		public SlotView slotView;

		public int x;

		public int y;

		public bool system;

		public bool transparentAsGhost;

		public int? bindIndex;

		public int ArtikulId
		{
			get
			{
				return (!IsEmpty) ? Item.ArtikulId : 0;
			}
		}

		public int Amount
		{
			get
			{
				return (!IsEmpty) ? Item.Amount : 0;
			}
		}

		public int Wear
		{
			get
			{
				return (!IsEmpty) ? Item.Wear : 0;
			}
		}

		public ArtikulsEntries Entry
		{
			get
			{
				return (!IsEmpty) ? Item.Entry : null;
			}
		}

		public bool IsEmpty
		{
			get
			{
				return Item == null;
			}
		}

		public bool IsTemp
		{
			get
			{
				return !IsEmpty && Item.IsTemp;
			}
		}

		public ArtikulItem Item { get; private set; }

		public bool Dirty { get; set; }

		public bool Selected { get; set; }

		public bool Splitting { get; set; }

		public bool AllowInsert { get; set; }

		public bool AllowTake { get; set; }

		public bool AllowEvents { get; set; }

		public bool CanDrag { get; set; }

		public bool CanDrop { get; set; }

		public bool Movable { get; set; }

		public bool Interactable { get; set; }

		public bool Splittable { get; set; }

		public event Action ItemChanged;

		public SlotModel()
		{
			transparentAsGhost = true;
			Dirty = true;
			CanDrag = true;
			CanDrop = true;
			Interactable = true;
			Movable = true;
			Splittable = true;
			AllowTake = true;
			AllowInsert = true;
			AllowEvents = true;
		}

		public void Clear()
		{
			if (Item != null)
			{
				Dirty = true;
			}
			Item = null;
			this.ItemChanged.SafeInvoke();
		}

		public void Insert(int artikulId, int amount = 1, int wear = 0, bool isTemp = false)
		{
			ArtikulItem newItem = new ArtikulItem(artikulId, amount, wear, isTemp);
			Insert(newItem);
		}

		public void Insert(ArtikulItem newItem)
		{
			Dirty = true;
			if (newItem == null || newItem.ArtikulId == 0)
			{
				Item = null;
			}
			else
			{
				Item = newItem;
			}
			if (this.ItemChanged != null)
			{
				this.ItemChanged.SafeInvoke();
			}
		}

		public void Append(ArtikulItem newItem)
		{
			if (IsEmpty)
			{
				Insert(newItem);
				return;
			}
			if (Item.ArtikulId == newItem.ArtikulId)
			{
				int num = newItem.Amount + Item.Amount;
				if (num <= Item.AmountMax)
				{
					Item.Amount = num;
					Dirty = true;
					if (this.ItemChanged != null)
					{
						this.ItemChanged.SafeInvoke();
					}
					return;
				}
			}
			Log.Error("Unable to append {0} into {1}", newItem, Item);
		}
	}
}

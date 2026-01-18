using System;
using System.Collections.Generic;
using Extensions;
using NguiTools;

namespace InventoryModule
{
	public class InvetnoryController : Singleton
	{
		private InventoryModel model_;

		private SlotModel tempSlot_;

		private InventorySplitController splitController_;

		public event Action<SlotMoveArgs> SlotContentsMoved;

		public event Action<SlotModel, SlotModel> SlotsSwaped;

		public List<SlotModel> AddSlotsGroup(char slotCode, int count, bool craft = false)
		{
			List<SlotModel> list = new List<SlotModel>();
			model_.Slots[slotCode] = list;
			int num = (int)Math.Sqrt(count);
			int num2 = 0;
			int num3 = 0;
			for (int i = 0; i < count; i++)
			{
				SlotModel slotModel = new SlotModel();
				list.Add(slotModel);
				slotModel.index = i;
				slotModel.name = slotCode + i.ToString();
				slotModel.slotType = slotCode;
				if (craft)
				{
					slotModel.x = num2;
					slotModel.y = num3;
					num2++;
					if (num2 == num)
					{
						num2 = 0;
						num3++;
					}
				}
			}
			return list;
		}

		public override void Dispose()
		{
			this.SlotContentsMoved = null;
			this.SlotsSwaped = null;
			splitController_.Dispose();
		}

		public int GetArtikulSlotType(int artikulId, bool isTemp)
		{
			ArtikulsEntries value;
			InventoryContentMap.Artikuls.TryGetValue(artikulId, out value);
			return GetArtikulSlotType(value, isTemp);
		}

		public int GetArtikulSlotType(ArtikulsEntries artikul, bool isTemp)
		{
			if (isTemp)
			{
				return 2;
			}
			if (artikul.type_id == 3 || artikul.type_id == 4)
			{
				return 0;
			}
			return 1;
		}

		public void GetRarity(int rarityId, int artikulId, out RarityEntries rarity)
		{
			if (!InventoryContentMap.Rarity.TryGetValue(rarityId, out rarity))
			{
				InventoryContentMap.Rarity.TryGetValue(InventoryContentMap.CraftSettings.default_rarity_id, out rarity);
			}
		}

		public SlotModel GetSlotByCode(string slotCode)
		{
			char key = slotCode[0];
			string s = slotCode.Remove(0, 1);
			int num = int.Parse(s);
			List<SlotModel> value;
			if (model_.Slots.TryGetValue(key, out value))
			{
				foreach (SlotModel item in value)
				{
					if (item.index == num)
					{
						return item;
					}
				}
			}
			return null;
		}

		public override void Init()
		{
			SingletonManager.Get<InventoryModel>(out model_);
			tempSlot_ = new SlotModel();
			splitController_ = new InventorySplitController();
		}

		public void MoveSlot(SlotModel slotA, SlotModel slotB, int amount)
		{
			ArtikulItem artikulItem = new ArtikulItem(slotA.Item);
			artikulItem.Amount = slotB.Amount + amount;
			slotB.Insert(artikulItem);
			slotA.Item.Amount -= amount;
			if (slotA.Amount <= 0)
			{
				slotA.Clear();
			}
			if (slotA.AllowEvents && slotB.AllowEvents)
			{
				SlotMoveArgs param = new SlotMoveArgs(slotA.name, slotB.name, slotB.ArtikulId, amount);
				this.SlotContentsMoved.SafeInvoke(param);
			}
		}

		public void SetBackgroundSprite(UISprite backSprite, ArtikulsEntries artikul)
		{
			if (backSprite != null)
			{
				RarityEntries rarity;
				GetRarity(artikul.rarity_id, artikul.id, out rarity);
				if (rarity != null)
				{
					backSprite.spriteName = rarity.background_sprite_name;
					return;
				}
				Log.Warning("Rarity not set for {0} artukul.", artikul.id);
			}
		}

		public void SetLargeIcon(UI2DSprite sprite, int artikulId, UISprite backSprite = null)
		{
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
			{
				if (value.large_icon != string.Empty)
				{
					NguiFileManager nguiFileManager = SingletonManager.Get<NguiFileManager>();
					nguiFileManager.SetUI2DSprite(sprite, value.GetFullLargeIconPath());
				}
				if (backSprite != null)
				{
					SetBackgroundSprite(backSprite, value);
				}
			}
		}

		public SlotModel[] SlotsToArray(Dictionary<char, List<SlotModel>> dic)
		{
			List<SlotModel> list = new List<SlotModel>();
			foreach (KeyValuePair<char, List<SlotModel>> item in dic)
			{
				foreach (SlotModel item2 in item.Value)
				{
					if (!item2.IsEmpty)
					{
						list.Add(item2);
					}
				}
			}
			return list.ToArray();
		}

		public void SwapSlots(SlotModel slotA, SlotModel slotB)
		{
			tempSlot_.Insert(slotA.Item);
			if (slotB.IsEmpty)
			{
				slotA.Clear();
			}
			else
			{
				slotA.Insert(slotB.Item);
			}
			if (tempSlot_.IsEmpty)
			{
				slotB.Clear();
			}
			else
			{
				slotB.Insert(tempSlot_.Item);
			}
			tempSlot_.Clear();
			this.SlotsSwaped.SafeInvoke(slotA, slotB);
		}

		public bool TryAddToSlot(SlotModel slot, int artikul, int count)
		{
			return TryAddToSlot(slot, new ArtikulItem(artikul, count));
		}

		public bool TryAddToSlot(SlotModel slot, ArtikulItem item)
		{
			if (slot.IsEmpty)
			{
				slot.Insert(item);
				return true;
			}
			if (slot.Item.ArtikulId != item.ArtikulId)
			{
				return false;
			}
			int num = slot.Entry.stack_size - slot.Amount;
			if (num >= item.Amount)
			{
				slot.Item.Amount += item.Amount;
				return true;
			}
			return false;
		}

		public bool HasArtikul(ushort artikulId, int amount)
		{
			int num = 0;
			foreach (List<SlotModel> value in model_.Slots.Values)
			{
				foreach (SlotModel item in value)
				{
					if (item.ArtikulId == artikulId)
					{
						num += item.Amount;
					}
					if (num >= amount)
					{
						return true;
					}
				}
			}
			return false;
		}
	}
}

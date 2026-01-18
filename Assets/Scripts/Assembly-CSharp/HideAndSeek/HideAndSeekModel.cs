using System;
using System.Collections.Generic;
using CraftyVoxelEngine;
using Extensions;
using InventoryModule;

namespace HideAndSeek
{
	public class HideAndSeekModel : Singleton
	{
		public List<HiddenPlayer> hiddenVoxels;

		private int hidersAmount_;

		private bool allowSelect_;

		private HideVoxelsEntries defaultHideVoxel_;

		public bool lastSelectedVoxel;

		public int HidersAmount
		{
			get
			{
				return hidersAmount_;
			}
			set
			{
				if (hidersAmount_ != value)
				{
					hidersAmount_ = value;
					this.HidersAmountChanged.SafeInvoke();
				}
			}
		}

		public bool AllowSelect
		{
			get
			{
				return allowSelect_;
			}
			set
			{
				if (allowSelect_ != value)
				{
					allowSelect_ = value;
					this.AllowSelectChanged.SafeInvoke();
				}
			}
		}

		public HideVoxelsEntries DefaultHideVoxel
		{
			get
			{
				return defaultHideVoxel_;
			}
			set
			{
				if (defaultHideVoxel_ != value)
				{
					defaultHideVoxel_ = value;
					this.DefaultHideVoxelChanged.SafeInvoke();
				}
			}
		}

		public List<SlotModel> Slots { get; set; }

		public event Action HidersAmountChanged;

		public event Action<int> AmountChanged;

		public event Action<int, int?> BuyClicked;

		public event Action CastingStarted;

		public event Action DefaultHideVoxelChanged;

		public event Action AllowSelectChanged;

		public override void Init()
		{
			hiddenVoxels = new List<HiddenPlayer>();
		}

		public bool GetSlotById(int hideVoxelId, out SlotModel slot)
		{
			for (int i = 0; i < Slots.Count; i++)
			{
				slot = Slots[i];
				if (slot.GhostItem.Entry.hideVoxel.id == hideVoxelId)
				{
					return true;
				}
			}
			slot = null;
			return false;
		}

		public void ReportCastingStarted()
		{
			this.CastingStarted.SafeInvoke();
		}

		public void SetAmount(int hideVoxelId, int amount)
		{
			HideVoxelsEntries hideVoxelsEntries = HideAndSeekContentMap.HideVoxels[hideVoxelId];
			ArtikulsEntries artikul = hideVoxelsEntries.artikul;
			SlotModel slot;
			if (GetSlotById(hideVoxelId, out slot))
			{
				slot.Insert(artikul.id, amount);
				this.AmountChanged.SafeInvoke(hideVoxelId);
			}
		}

		public void TryBuy(int hideVoxelId, int? count)
		{
			this.BuyClicked.SafeInvoke(hideVoxelId, count);
		}

		public bool CheckHiddenPlayer(VoxelKey hidePosition)
		{
			for (int i = 0; i < hiddenVoxels.Count; i++)
			{
				if (hiddenVoxels[i].position.Equals(hidePosition))
				{
					return true;
				}
			}
			return false;
		}

		public void TryRemoveHiddenPlayer(VoxelKey hidePosition)
		{
			for (int i = 0; i < hiddenVoxels.Count; i++)
			{
				if (hiddenVoxels[i].position.Equals(hidePosition))
				{
					hiddenVoxels.RemoveAt(i);
					break;
				}
			}
		}

		public void TryAddHiddenPlayer(VoxelKey hidePosition)
		{
			if (!CheckHiddenPlayer(hidePosition))
			{
				hiddenVoxels.Add(new HiddenPlayer
				{
					position = hidePosition
				});
			}
		}
	}
}

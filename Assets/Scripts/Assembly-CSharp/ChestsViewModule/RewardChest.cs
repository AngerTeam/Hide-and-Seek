using System;
using InventoryModule;

namespace ChestsViewModule
{
	public class RewardChest : IDisposable
	{
		public int slotId;

		public int artikulId;

		public ArtikulsEntries artikul;

		public string itemName;

		public string iconPath;

		public int timeToOpen;

		public int boostPrice;

		public int bonusId;

		public int startTime;

		public RewardChestState state;

		public RewardChestType type;

		public ViewChest view;

		public int EndTime
		{
			get
			{
				return startTime + timeToOpen;
			}
		}

		public RewardChest()
		{
			view = new ViewChest();
		}

		public void Animate(string animationState)
		{
			view.Animate(animationState);
		}

		public void Dispose()
		{
			if (view != null)
			{
				view.Dispose();
			}
		}
	}
}

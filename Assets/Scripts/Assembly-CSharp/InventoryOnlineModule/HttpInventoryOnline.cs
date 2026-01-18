using HttpNetwork;
using RemoteData.Lua;

namespace InventoryOnlineModule
{
	public class HttpInventoryOnline : Singleton, IInventoryOnline, ISingleton
	{
		public bool disableCraft;

		public bool disableSlots;

		private HttpOnlineManager http_;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public void SendCraftGetResult(int recipeId, string buildingRef, int articulId, int count, int craftCount, string slotId)
		{
			if (!disableCraft)
			{
				CraftResultLuaCommand craftResultLuaCommand = new CraftResultLuaCommand(articulId, recipeId, count, craftCount);
				if (!string.IsNullOrEmpty(slotId))
				{
					craftResultLuaCommand.slotId = slotId;
				}
				http_.Send(craftResultLuaCommand);
			}
		}

		public void SendMoveSlot(string fromSlotId, string toSlotId, int articulId, int count)
		{
			if (!disableSlots)
			{
				http_.Send(new SlotMoveLuaCommand(fromSlotId, toSlotId, articulId, count));
			}
		}

		public void SendSelectSlot(string slotId)
		{
			if (!disableSlots)
			{
				http_.Send(new SlotSelectLuaCommand(slotId));
			}
		}

		public void SendSwapSlot(string fromSlotId, string toSlotId)
		{
			if (!disableSlots)
			{
				http_.Send(new SlotSwapLuaCommand(fromSlotId, toSlotId));
			}
		}

		public void SendCleanSlot(string slotId)
		{
			if (!disableSlots)
			{
				http_.Send(new SlotCleanLuaCommand(slotId));
			}
		}
	}
}

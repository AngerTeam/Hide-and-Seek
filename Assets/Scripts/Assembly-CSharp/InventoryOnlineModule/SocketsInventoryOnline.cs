using CraftyNetworkEngine.Sockets;
using Interlace.Amf;
using RemoteData.Socket;

namespace InventoryOnlineModule
{
	public class SocketsInventoryOnline : SocketsOnlineManagerApi, IInventoryOnline, ISingleton
	{
		public void SendCraftGetResult(int recipeId, string buildingRef, int articulId, int count, int craftCount, string slotId)
		{
			CraftResultCommand command = new CraftResultCommand(articulId, recipeId, count, craftCount, slotId);
			Send(command);
		}

		public void SendMoveSlot(string fromSlotId, string toSlotId, int articulId, int count)
		{
			Send(new SlotMoveCommand(articulId, fromSlotId, toSlotId, count));
		}

		public void SendSwapSlot(string fromSlotId, string toSlotId)
		{
			Send(new SlotSwapCommand(fromSlotId, toSlotId));
		}

		public void SendCleanSlot(string slotId)
		{
			Send(new SlotCleanCommand(slotId));
		}

		public void SendSelectSlot(string slotId)
		{
			SlotSelectCommand slotSelectCommand = new SlotSelectCommand(slotId);
			slotSelectCommand.ResponceRecieved += HandleSendSelectResponceRecieved;
			Send(slotSelectCommand);
		}

		private void HandleSendSelectResponceRecieved(AmfObject amfObject)
		{
			Log.Info("SendSelectSlot completed successfully");
		}
	}
}

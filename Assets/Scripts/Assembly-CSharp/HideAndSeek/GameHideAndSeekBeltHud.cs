using InventoryViewModule;

namespace HideAndSeek
{
	public class GameHideAndSeekBeltHud : BeltHud<HideAndSeekInventoryWindow>
	{
		public GameHideAndSeekBeltHud()
			: base('p', 2, SelectionHandlerMode.Select)
		{
			enableTrashSlot = true;
		}
	}
}

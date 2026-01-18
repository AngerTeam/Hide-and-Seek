namespace InventoryViewModule
{
	public class GameBeltHud : BeltHud<GameInventoryWindow>
	{
		public GameBeltHud()
			: base('p', 2, SelectionHandlerMode.Select)
		{
			enableTrashSlot = true;
		}
	}
}

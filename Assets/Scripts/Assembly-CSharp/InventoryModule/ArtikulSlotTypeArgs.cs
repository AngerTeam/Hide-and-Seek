using System;

namespace InventoryModule
{
	public class ArtikulSlotTypeArgs : EventArgs
	{
		public int type;

		public int artikulId;

		public ArtikulSlotTypeArgs(int type, int artikulId)
		{
			this.type = type;
			this.artikulId = artikulId;
			this.artikulId = artikulId;
		}
	}
}

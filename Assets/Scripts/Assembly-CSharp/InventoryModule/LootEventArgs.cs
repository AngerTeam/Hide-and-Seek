using System;
using LootModule;
using UnityEngine;

namespace InventoryModule
{
	public class LootEventArgs : EventArgs
	{
		public LootItem loot;

		public Vector3 itemPosition;

		public LootEventType type;

		public LootEventArgs(LootEventType type)
		{
			this.type = type;
		}
	}
}

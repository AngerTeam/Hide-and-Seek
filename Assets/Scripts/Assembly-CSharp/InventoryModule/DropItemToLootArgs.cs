using System;
using UnityEngine;

namespace InventoryModule
{
	public class DropItemToLootArgs : EventArgs
	{
		public int ArticulId { get; private set; }

		public int Count { get; private set; }

		public Vector3 Position { get; private set; }

		public string FromRef { get; private set; }

		public bool IsDropFromPlayer { get; private set; }

		public bool IsDropFromCraft { get; private set; }

		public int Wear { get; private set; }

		public bool IsTemp { get; private set; }

		public DropItemToLootArgs(int articulId, int count, Vector3 position, string fromRef, bool isDropFromPlayer, bool isDropFromCraft, int wear = 0, bool isTemp = false)
		{
			ArticulId = articulId;
			Count = count;
			Position = position;
			FromRef = fromRef;
			IsDropFromPlayer = isDropFromPlayer;
			IsDropFromCraft = isDropFromCraft;
			Wear = wear;
			IsTemp = isTemp;
		}
	}
}

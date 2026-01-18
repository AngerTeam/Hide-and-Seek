using System;
using UnityEngine;

namespace InventoryViewModule
{
	public class InventorySlotHierarchy : MonoBehaviour
	{
		public UIWidget widget;

		public UIWidget selectionBorderA;

		public UIWidget selectionBorderB;

		public UISlider durabilitySlider;

		public UILabel amountLabel;

		public UISprite icon;

		public UISprite placeHolder;

		public UISprite tempIcon;

		public UISprite infinityIcon;

		public UILabel bindKeyLabel;

		public UISprite background;

		public UISprite backgroundBorder;

		public UILabel title;

		[NonSerialized]
		public SlotController slot;
	}
}

using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	[Serializable]
	public class AtlasImage
	{
		public Texture2D texture;

		public int borderLeft;

		public int borderRight;

		public int borderTop;

		public int borderBottom;

		public bool hasBorder
		{
			get
			{
				return (borderLeft | borderRight | borderTop | borderBottom) != 0;
			}
		}
	}
}

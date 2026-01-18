using System;
using InventoryModule;
using UnityEngine;

namespace ArticulViewModule
{
	public class ArtikulItemView : IDisposable
	{
		public ArticulViewBase View { get; private set; }

		public Transform Container
		{
			get
			{
				return (View != null && !(View.Container == null)) ? View.Container.transform : null;
			}
		}

		public ArtikulItemView(Transform parent, ArtikulsEntries articul, float offsetY, float scale, bool inHandAngle = false)
		{
			if (articul != null)
			{
				ArtikulItemViewManager artikulItemViewManager = SingletonManager.Get<ArtikulItemViewManager>();
				View = artikulItemViewManager.GetRenderer(articul.id);
				View.inHandAngle = inHandAngle;
				if (scale != 0f)
				{
					View.multypleScale = scale;
				}
				View.Render(parent, articul.id);
			}
		}

		public void Dispose()
		{
			if (View != null)
			{
				View.Dispose();
			}
			View = null;
		}
	}
}

using System;
using CraftyEngine.Infrastructure;
using NguiTools;
using UnityEngine;

namespace WindowsModule
{
	public class GameSubwindow
	{
		protected PrefabsManagerNGUI prefabsManager_;

		protected NguiManager nguiManager_;

		public GameObject container;

		public GameObject backContainer;

		public bool Visible { get; private set; }

		protected event EventHandler<BoolEventArguments> ViewChanged;

		public GameSubwindow()
		{
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
		}

		public void UpdateVisibility(bool visible)
		{
			if (Visible != visible)
			{
				Visible = visible;
				container.SetActive(visible);
				ReportViewChanged();
				if (Visible)
				{
					Show();
				}
				else
				{
					Hide();
				}
			}
		}

		public virtual void SelectById(int itemId)
		{
		}

		public virtual void Init()
		{
		}

		public virtual void Clear()
		{
		}

		public virtual void Show()
		{
		}

		public virtual void Hide()
		{
		}

		public void ReportViewChanged()
		{
			if (this.ViewChanged != null)
			{
				this.ViewChanged(this, new BoolEventArguments(Visible));
			}
		}
	}
}

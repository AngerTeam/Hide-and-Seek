using System;
using System.Collections.Generic;

namespace WindowsModule
{
	[Obsolete]
	public class SubwindowManager
	{
		public Dictionary<int, GameSubwindow> subwindows;

		public int CurrentSubwindowId { get; private set; }

		public SubwindowManager()
		{
			subwindows = new Dictionary<int, GameSubwindow>();
		}

		public void Add(int id, GameSubwindow subwindow)
		{
			subwindows[id] = subwindow;
			subwindow.container.SetActive(false);
			subwindow.UpdateVisibility(false);
		}

		public void ShowCurrentSubwindow()
		{
			ShowSubwindow(CurrentSubwindowId);
		}

		public void ShowSubwindow(int id)
		{
			foreach (KeyValuePair<int, GameSubwindow> subwindow in subwindows)
			{
				if (subwindow.Key != id)
				{
					subwindow.Value.UpdateVisibility(false);
				}
			}
			foreach (KeyValuePair<int, GameSubwindow> subwindow2 in subwindows)
			{
				if (subwindow2.Key == id)
				{
					CurrentSubwindowId = id;
					subwindow2.Value.UpdateVisibility(true);
				}
			}
		}

		public void HideAllSubwindows()
		{
			foreach (KeyValuePair<int, GameSubwindow> subwindow in subwindows)
			{
				subwindow.Value.UpdateVisibility(false);
			}
		}
	}
}

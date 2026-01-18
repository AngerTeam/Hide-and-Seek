using System;
using Extensions;
using UnityEngine;

namespace HudSystem
{
	public class HudStateItem
	{
		public GameObject gameObject;

		public string debugName;

		public event Action<int> Activated;

		public HudStateItem(GameObject gameObject)
		{
			this.gameObject = gameObject;
			debugName = gameObject.name;
		}

		public HudStateItem(Behaviour behaviour)
		{
			gameObject = behaviour.gameObject;
			debugName = gameObject.name;
		}

		public void ReportActivated(int id)
		{
			this.Activated.SafeInvoke(id);
		}
	}
}

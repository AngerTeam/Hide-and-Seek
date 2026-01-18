using System;
using System.Collections.Generic;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Utils
{
	public class DebugButtonsManager : Singleton
	{
		public List<DebugButton> Buttons { get; private set; }

		public event Action<DebugButton> ButtonAdded;

		public override void Init()
		{
			Buttons = new List<DebugButton>();
		}

		public void Add(string title, KeyCode hotKey, Action action, bool second = false)
		{
			DebugButton debugButton = new DebugButton();
			debugButton.title = ((!CompileConstants.MOBILE) ? string.Format("{0} ({1})", title, hotKey) : title);
			debugButton.hotKey = hotKey;
			debugButton.action = action;
			DebugButton debugButton2 = debugButton;
			Buttons.Add(debugButton2);
			this.ButtonAdded.SafeInvoke(debugButton2);
		}
	}
}

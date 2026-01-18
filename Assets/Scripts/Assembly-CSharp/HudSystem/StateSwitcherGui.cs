using System;
using System.Collections.Generic;
using UnityEngine;

namespace HudSystem
{
	public class StateSwitcherGui
	{
		public FlagListHelper Helper { get; private set; }

		public event Action<int> Switch;

		public StateSwitcherGui()
		{
			Helper = new FlagListHelper();
		}

		private void RenderStates(List<FlagState> states)
		{
			for (int i = 0; i < states.Count; i++)
			{
				FlagState flagState = states[i];
				GUILayout.BeginHorizontal();
				if (GUILayout.Button("set", GUILayout.Width(35f)))
				{
					SwitchState(flagState.number);
				}
				bool flag = GUILayout.Toggle(flagState.value, flagState.name);
				if (flag != flagState.value)
				{
					flagState.value = flag;
					if (flagState.value)
					{
						SwitchState(flagState.number);
					}
				}
				GUILayout.EndHorizontal();
			}
		}

		private void SwitchState(int number)
		{
			this.Switch(number);
			Helper.Switch(number);
		}

		public void OnGUI()
		{
			GUILayout.Label("states:");
			RenderStates(Helper.Flags);
			GUILayout.Label("filters:");
			RenderStates(Helper.Filters);
		}
	}
}

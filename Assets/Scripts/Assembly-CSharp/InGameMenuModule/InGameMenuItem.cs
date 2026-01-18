using System;

namespace InGameMenuModule
{
	public class InGameMenuItem
	{
		public string title;

		public InGameMenuItemType type;

		internal string titleValue;

		internal UIButton button;

		public Action buttonHandler;

		public bool toggleState;

		public UILabel Text { get; internal set; }

		public InGameMenuItem(string title, InGameMenuItemType type)
		{
			title = Localisations.Get(title);
			this.title = title;
			this.type = type;
		}
	}
}

using System.Collections.Generic;

namespace CraftyEngine.Infrastructure
{
	public class InputModel : Singleton
	{
		public float clickDistanceTreshold = 25f;

		public float clickDurationTreshold = 0.25f;

		public bool Alt;

		public bool Shift;

		public bool Space;

		public bool allowHotkeyProcess;

		public List<InputInstance> InputIntances { get; private set; }

		public InputInstance CurrentInstance { get; set; }

		public override void Init()
		{
			InputIntances = new List<InputInstance>();
		}

		public InputInstance GetInstance(int i)
		{
			return CurrentInstance = InputIntances[i];
		}
	}
}

using System;

namespace CraftyEngine
{
	public class AdjustableSetting
	{
		public Action<float> floatHandler;

		public Action<bool> toggleHandler;

		public Action buttonHandler;

		public AdjustableSettingType type;

		public float value;

		public float valueMin;

		public float valueMax;

		public bool toggle;

		public string title;
	}
}

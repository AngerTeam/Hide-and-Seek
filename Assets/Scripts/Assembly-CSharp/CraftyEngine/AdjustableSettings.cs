using System;
using System.Collections.Generic;

namespace CraftyEngine
{
	public abstract class AdjustableSettings
	{
		public int id;

		public static Dictionary<int, AdjustableSettings> allSettings;

		public List<AdjustableSetting> settings;

		protected AdjustableSettings(int id)
		{
			this.id = id;
			settings = new List<AdjustableSetting>();
		}

		public static void Register<T>() where T : AdjustableSettings, new()
		{
			T val = new T();
			if (allSettings == null)
			{
				allSettings = new Dictionary<int, AdjustableSettings>();
			}
			allSettings.Add(val.id, val);
		}

		public abstract void Build();

		protected void Add(string title, float value, float min, float max, Action<float> floatHandler)
		{
			AdjustableSetting adjustableSetting = new AdjustableSetting();
			adjustableSetting.title = title;
			adjustableSetting.value = value;
			adjustableSetting.valueMin = min;
			adjustableSetting.valueMax = max;
			adjustableSetting.type = AdjustableSettingType.Slider;
			adjustableSetting.floatHandler = floatHandler;
			settings.Add(adjustableSetting);
		}

		protected void Add(string title)
		{
			AdjustableSetting adjustableSetting = new AdjustableSetting();
			adjustableSetting.title = title;
			adjustableSetting.type = AdjustableSettingType.Title;
			settings.Add(adjustableSetting);
		}

		protected void Add(string title, Action buttonHandler)
		{
			AdjustableSetting adjustableSetting = new AdjustableSetting();
			adjustableSetting.title = title;
			adjustableSetting.type = AdjustableSettingType.Button;
			adjustableSetting.buttonHandler = buttonHandler;
			settings.Add(adjustableSetting);
		}

		protected void Add(string title, bool value, Action<bool> toggleHandler)
		{
			AdjustableSetting adjustableSetting = new AdjustableSetting();
			adjustableSetting.title = title;
			adjustableSetting.type = AdjustableSettingType.Toggle;
			adjustableSetting.toggleHandler = toggleHandler;
			adjustableSetting.toggle = value;
			settings.Add(adjustableSetting);
		}
	}
}

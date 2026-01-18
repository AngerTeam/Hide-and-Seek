using System;
using System.Collections.Generic;
using System.Reflection;
using CraftyEngine.Utils;

namespace HudSystem
{
	public class FlagListHelper
	{
		public List<FlagState> Flags { get; private set; }

		public List<FlagState> Filters { get; private set; }

		public List<FlagState> All { get; private set; }

		public void Parse(Type type)
		{
			FieldInfo[] fields = type.GetFields(BindingFlags.Static | BindingFlags.Public);
			for (int i = 0; i < fields.Length; i++)
			{
				int num = (int)fields[i].GetValue(null);
				Add(num, string.Format("{0} ({1})", fields[i].Name, num));
			}
		}

		public void Switch(int number)
		{
			for (int i = 0; i < All.Count; i++)
			{
				FlagState flagState = All[i];
				flagState.value = EnumUtils.Contains(number, flagState.number);
			}
		}

		public void Add(int value, string name)
		{
			if (All == null)
			{
				All = new List<FlagState>();
				Flags = new List<FlagState>();
				Filters = new List<FlagState>();
			}
			FlagState flagState = new FlagState();
			flagState.number = value;
			flagState.name = name;
			if (EnumUtils.IsPowerOfTwo(value))
			{
				Flags.Add(flagState);
			}
			else
			{
				Filters.Add(flagState);
			}
			All.Add(flagState);
		}

		public string GetName(int number)
		{
			for (int i = 0; i < All.Count; i++)
			{
				FlagState flagState = All[i];
				if (flagState.number == number)
				{
					return flagState.name;
				}
			}
			return "Undefined: " + number;
		}
	}
}

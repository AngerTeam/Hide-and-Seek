using System;
using System.Collections.Generic;

namespace SA.Fitness
{
	public class DataPoint
	{
		private DataType dataType;

		private Dictionary<string, object> fields = new Dictionary<string, object>();

		public DataType DataType
		{
			get
			{
				return dataType;
			}
		}

		public Dictionary<string, object> Fields
		{
			get
			{
				return fields;
			}
		}

		public DataPoint(DataType type, string[] bundle)
		{
			dataType = type;
			for (int i = 1; i < bundle.Length; i++)
			{
				if (!bundle[i].Equals(string.Empty))
				{
					string[] array = bundle[i].Split(new string[1] { "|" }, StringSplitOptions.None);
					fields.Add(array[0], array[1]);
				}
			}
		}
	}
}

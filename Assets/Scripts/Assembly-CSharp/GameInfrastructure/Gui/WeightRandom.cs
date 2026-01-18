using System.Collections.Generic;
using UnityEngine;

namespace GameInfrastructure.Gui
{
	public class WeightRandom
	{
		private static List<IWeightable> list_;

		public static T GetRandom<T>(T[] array) where T : IWeightable
		{
			if (list_ == null)
			{
				list_ = new List<IWeightable>();
			}
			list_.Clear();
			float num = 0f;
			for (int i = 0; i < array.Length; i++)
			{
				float weight = array[i].Weight;
				if (weight > 0f)
				{
					num += weight;
					list_.Add(array[i]);
				}
			}
			float num2 = Random.value * num;
			num = 0f;
			for (int j = 0; j < list_.Count; j++)
			{
				num += list_[j].Weight;
				if (num > num2)
				{
					return (T)list_[j];
				}
			}
			return (T)list_[list_.Count - 1];
		}
	}
}

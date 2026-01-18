using System;
using System.Collections;

namespace CraftyEngine.Utils
{
	public static class ListExtensions
	{
		public static void IterateAndRemove(this IList list, Predicate<int> checkIfRemove)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				if (checkIfRemove(num))
				{
					list.RemoveAt(num);
				}
			}
		}
	}
}

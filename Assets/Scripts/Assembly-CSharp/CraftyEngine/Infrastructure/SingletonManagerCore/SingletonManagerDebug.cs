using System.Collections.Generic;
using System.Text;

namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class SingletonManagerDebug
	{
		public static string GetDebugInfo()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("SingletonManager result:");
			List<SingletonMetaData> list = new List<SingletonMetaData>();
			list.AddRange(SingletonManager.GetSingletons(2).uniqueSingletons);
			list.AddRange(SingletonManager.GetSingletons(1).uniqueSingletons);
			list.Sort(Sort);
			for (int i = 0; i < list.Count; i++)
			{
				SingletonMetaData singletonMetaData = list[i];
				if (singletonMetaData.executionTime == null)
				{
					continue;
				}
				double num = (double)singletonMetaData.totalExecutionTime / 10000000.0;
				if (!(num > 0.001))
				{
					continue;
				}
				string value = string.Format("\t{0} {1:f3}s:", singletonMetaData.debugName, num);
				stringBuilder.AppendLine(value);
				foreach (KeyValuePair<SingletonPhase, float> item in singletonMetaData.executionTime)
				{
					double num2 = (double)item.Value / 10000000.0;
					if (num2 > 1E-07)
					{
						stringBuilder.Append(string.Format("\t{0}: {1:f3};", item.Key, num2));
					}
				}
			}
			return stringBuilder.ToString();
		}

		private static int Sort(SingletonMetaData a, SingletonMetaData b)
		{
			return b.totalExecutionTime.CompareTo(a.totalExecutionTime);
		}
	}
}

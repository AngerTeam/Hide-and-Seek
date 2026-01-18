namespace System.Collections.Generic
{
	public static class IListExtensions
	{
		public static TResultElement[] ExtractArray<TSourseElement, TResultElement>(this IList<TSourseElement> enumerable, Func<TSourseElement, TResultElement> exctractor)
		{
			TResultElement[] array = new TResultElement[enumerable.Count];
			for (int i = 0; i < enumerable.Count; i++)
			{
				array[i] = exctractor(enumerable[i]);
			}
			return array;
		}
	}
}

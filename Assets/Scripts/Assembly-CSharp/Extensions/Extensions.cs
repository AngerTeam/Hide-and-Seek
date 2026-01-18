using System;

namespace Extensions
{
	public static class Extensions
	{
		public static void SafeInvoke(this Action target)
		{
			if (target == null)
			{
				return;
			}
			try
			{
				target();
			}
			catch (Exception data)
			{
				Exc.Report(3004, target, data);
			}
		}

		public static void SafeInvoke<T0>(this Action<T0> target, T0 param0)
		{
			if (target == null)
			{
				return;
			}
			try
			{
				target(param0);
			}
			catch (Exception data)
			{
				Exc.Report(3004, target, data);
			}
		}

		public static void SafeInvoke<T0, T1>(this Action<T0, T1> target, T0 param0, T1 param1)
		{
			if (target == null)
			{
				return;
			}
			try
			{
				target(param0, param1);
			}
			catch (Exception data)
			{
				Exc.Report(3004, target, data);
			}
		}

		public static void SafeInvoke<T0, T1, T2>(this Action<T0, T1, T2> target, T0 param0, T1 param1, T2 param2)
		{
			if (target == null)
			{
				return;
			}
			try
			{
				target(param0, param1, param2);
			}
			catch (Exception data)
			{
				Exc.Report(3004, target, data);
			}
		}
	}
}

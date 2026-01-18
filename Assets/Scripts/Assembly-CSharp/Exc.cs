using System;
using ExceptionsModule;
using Extensions;

public static class Exc
{
	public static event Action<ExceptionArgs> ExceptionRecieved;

	public static void Report(int exceptionId, object context = null, object data = null, bool debug = false)
	{
		Exc.ExceptionRecieved.SafeInvoke(new ExceptionArgs(exceptionId, null, context, data, debug));
	}
}

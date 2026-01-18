using System;
using System.Collections.Generic;

public static class ParsePushesStub
{
	public static event Action<string, Dictionary<string, object>> OnPushReceived;

	static ParsePushesStub()
	{
		ParsePushesStub.OnPushReceived = delegate
		{
		};
	}

	public static void InitParse()
	{
	}
}

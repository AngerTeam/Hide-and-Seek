namespace SA.Fitness
{
	public static class Proxy
	{
		private const string CLASS_NAME = "com.stansassets.fitness.Bridge";

		private static void Call(string methodName, params object[] args)
		{
			AN_ProxyPool.CallStatic("com.stansassets.fitness.Bridge", methodName, args);
		}

		private static ReturnType Call<ReturnType>(string methodName, params object[] args)
		{
			return AN_ProxyPool.CallStatic<ReturnType>("com.stansassets.fitness.Bridge", methodName, args);
		}

		public static void Connect(string connectionRequest)
		{
			Call("connect", connectionRequest);
		}

		public static void Disconnect()
		{
			Call("disconnect");
		}

		public static void RequestDataSources(string request)
		{
			Call("requestDataSources", request);
		}

		public static void RegisterSensorListener(string request)
		{
			Call("addSensorListener", request);
		}
	}
}

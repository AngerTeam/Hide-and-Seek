using UnityEngine;

public static class DataStorage
{
	public const int RETRY_COUNT = 3;

	public static float disconnectTime = 30f;

	public static float disconnectTimeForNotConnected = 60f;

	public static float updateRateNetwork = 0.1f;

	public static float updateRateView = 0.15f;

	public static int maxConnections = 100;

	public static string socketUrl = "localhost";

	public static string rpc = "http://10.0.1.35:8000/";

	public static string version = "Undefined";

	public static string bundleIdentifier;

	public static string releaseVersion;

	public static string launcherVersion;

	public static string logFile = "log";

	public static int logLevel = 1;

	public static Vector3 lobbyPrevPosition = Vector3.zero;

	public static Vector3 lobbyPrevnRotation = Vector3.zero;

	public static bool isAdmin = CompileConstants.EDITOR;

	public static bool forbidDropToLoot = false;

	public static bool splashScreenVisible = false;

	public static int rewardChestsCount = 0;

	public static bool manualLoadOnly = true;

	public static bool initialLoad;

	public static int primeStartedTimestamp;

	public static int primeEndedTimestamp;

	public static int currentModeId;
}

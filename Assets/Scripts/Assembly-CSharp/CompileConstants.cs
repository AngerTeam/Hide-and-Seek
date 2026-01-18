public class CompileConstants
{
	public const string PLATFORM_WIN = "WIN";

	public const string PLATFORM_OSX = "OSX";

	public const string PLATFORM_ANDROID = "ANDROID";

	public const string PLATFORM_IOS = "IOS";

	public const string PLATFORM_LINUX = "LINUX";

	public static bool EDITOR = false;

	public static bool ANDROID = true;

	public static bool IOS = false;

	public static bool MOBILE = ANDROID || IOS;

	public static string EXTENSION_WIN = ".exe";

	public static string EXTENSION_OSX = ".app";

	public static string EXTENSION_ANDROID = ".apk";

	public static string BUNDLE_TYPE_STANDALONE = "standalone";

	public static string BUNDLE_TYPE_ANDROID = "android_atc";

	public static string BUNDLE_TYPE_IOS = "ios";

	public static bool DEVELOP = true;

	public static bool RELEASE = false;

	public static string PLATFORM = "ANDROID";

	public static string BUNDLE_TYPE = BUNDLE_TYPE_ANDROID;

	public static string EXTENSION = EXTENSION_ANDROID;

	public static bool PLATFORM_IS_OSX = false;

	public static bool PLATFORM_IS_WIN = false;

	public static string CONTENT_TEST = "Test";

	public static string CONTENT_PRE = "Pre";

	public static string CONTENT_DEV = "Dev";

	public static string CONTENT_RELEASE = string.Empty;

	public static string CONTENT_LOCAL = "Local";

	public static string CONTENT_TYPE = CONTENT_RELEASE;

	public static bool CONTENT_IS_TEST = false;

	public static bool CONTENT_IS_PRE = false;

	public static bool CONTENT_IS_RELEASE = true;

	public static bool CONTENT_IS_LOCAL = false;

	public static bool CONTENT_IS_DEV = false;
}

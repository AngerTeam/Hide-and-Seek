using UnityEngine;

public class MNP_PlatformSettings : ScriptableObject
{
	private const string ISNSettingsAssetName = "MNPSettings";

	private const string ISNSettingsPath = "Plugins/StansAssets/Support/Settings/Resources/";

	private const string ISNSettingsAssetExtension = ".asset";

	public const string VERSION_NUMBER = "4.8/17";

	public MNAndroidDialogTheme AndroidDialogTheme;

	private static MNP_PlatformSettings instance;

	public static MNP_PlatformSettings Instance
	{
		get
		{
			if (instance == null)
			{
				instance = Resources.Load("MNPSettings") as MNP_PlatformSettings;
				if (instance == null)
				{
					instance = ScriptableObject.CreateInstance<MNP_PlatformSettings>();
				}
			}
			return instance;
		}
	}
}

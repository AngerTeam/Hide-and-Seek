using System;
using SA.Common.Pattern;
using UnityEngine;

public class UM_Location : Singleton<UM_Location>
{
	public static event Action<UM_LocaleInfo> OnLocaleLoaded;

	static UM_Location()
	{
		UM_Location.OnLocaleLoaded = delegate
		{
		};
	}

	public void GetLocale()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.IPhonePlayer:
			IOSNativeUtility.OnLocaleLoaded += HandleOnLocaleLoaded_IOS;
			Singleton<IOSNativeUtility>.Instance.GetLocale();
			break;
		case RuntimePlatform.Android:
			AndroidNativeUtility.LocaleInfoLoaded += HandleLocaleInfoLoaded_Android;
			Singleton<AndroidNativeUtility>.Instance.LoadLocaleInfo();
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	private void HandleLocaleInfoLoaded_Android(AN_Locale locale)
	{
		AndroidNativeUtility.LocaleInfoLoaded -= HandleLocaleInfoLoaded_Android;
		UM_Location.OnLocaleLoaded(new UM_LocaleInfo(locale));
	}

	private void HandleOnLocaleLoaded_IOS(ISN_Locale locale)
	{
		IOSNativeUtility.OnLocaleLoaded -= HandleOnLocaleLoaded_IOS;
		UM_Location.OnLocaleLoaded(new UM_LocaleInfo(locale));
	}
}

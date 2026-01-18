using System;
using AdsModule.Content;
using AppodealAds.Unity.Api;
using AppodealAds.Unity.Common;
using CraftyEngine.Infrastructure;
using Extensions;

namespace AdsModule
{
	public class AppodealManager : PermanentSingleton, INonSkippableVideoAdListener, IPermissionGrantedListener
	{
		public Action VideoShown;

		public Action VideoFailed;

		public override void OnDataLoaded()
		{
			string appKey = null;
			if (!CompileConstants.EDITOR)
			{
				if (CompileConstants.ANDROID)
				{
					appKey = AdsContentMap.AdsSettings.appodealAppKeyAndroid;
				}
				else if (CompileConstants.IOS)
				{
					appKey = AdsContentMap.AdsSettings.appodealAppKeyIos;
				}
			}
			Appodeal.disableLocationPermissionCheck();
			Appodeal.requestAndroidMPermissions(this);
			Appodeal.setLogging(true);
			Appodeal.setNonSkippableVideoCallbacks(this);
			Appodeal.disableWriteExternalStoragePermissionCheck();
			Appodeal.initialize(appKey, 128);
		}

		private void TurnCamera(bool on)
		{
			CameraManager cameraManager;
			SingletonManager.Get<CameraManager>(out cameraManager);
			QueueManager singlton;
			SingletonManager.Get<QueueManager>(out singlton);
			singlton.AddTask(delegate
			{
				cameraManager.SetVisiblePlease(this, on);
			});
		}

		public bool IsLoaded()
		{
			try
			{
				return Appodeal.isLoaded(128);
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
				return false;
			}
		}

		public void ShowVideo()
		{
			Appodeal.show(128);
		}

		public void onNonSkippableVideoLoaded()
		{
			Log.Info("NonSkippable Video loaded");
		}

		public void onNonSkippableVideoFailedToLoad()
		{
			Log.Info("NonSkippable Video failed");
			VideoFailed.SafeInvoke();
		}

		public void onNonSkippableVideoShown()
		{
			Log.Info("NonSkippable Video opened");
			TurnCamera(false);
		}

		public void onNonSkippableVideoClosed()
		{
			Log.Info("NonSkippable Video closed");
			TurnCamera(true);
		}

		public void onNonSkippableVideoFinished()
		{
			Log.Info("NonSkippable Video finished");
			VideoShown.SafeInvoke();
		}

		public void writeExternalStorageResponse(int result)
		{
			if (result == 0)
			{
				Log.Info("WRITE_EXTERNAL_STORAGE permission granted");
			}
			else
			{
				Log.Info("WRITE_EXTERNAL_STORAGE permission grant refused");
			}
		}

		public void accessCoarseLocationResponse(int result)
		{
			if (result == 0)
			{
				Log.Info("ACCESS_COARSE_LOCATION permission granted");
			}
			else
			{
				Log.Info("ACCESS_COARSE_LOCATION permission grant refused");
			}
		}
	}
}

using CraftyEngine.Content;
using SplashesModule;
using UnityEngine;
using WindowsModule;

namespace UpdateModule
{
	public class UpdateManager : Singleton
	{
		private DialogWindowManager dialogManager_;

		private ContentLoaderModel contentModel_;

		public override void Init()
		{
			SingletonManager.Get<ContentLoaderModel>(out contentModel_);
			SingletonManager.Get<DialogWindowManager>(out dialogManager_);
			contentModel_.NewVersionDetected += ShowUpdateMessage;
		}

		public override void Dispose()
		{
			contentModel_.NewVersionDetected -= ShowUpdateMessage;
		}

		public void ShowUpdateMessage()
		{
			SingletonManager.Get<SplashScreenManager>().ShowDefaultScreen();
			if (CompileConstants.ANDROID)
			{
				string message = Localisations.Get("Obsolete_Version_Android");
				dialogManager_.ShowMessage(message, delegate
				{
					OpenUrl(contentModel_.newVersionUrl);
				});
			}
			else if (CompileConstants.IOS)
			{
				string message2 = Localisations.Get("Obsolete_Version_IOS");
				dialogManager_.ShowMessage(message2, delegate
				{
					OpenUrl(contentModel_.newVersionUrl);
				});
			}
			else if (!CompileConstants.MOBILE)
			{
				string message3 = Localisations.Get("Obsolete_Version_Standalone");
				dialogManager_.ShowMessage(message3, Quit);
			}
			else
			{
				string message4 = Localisations.Get("Obsolete_Version");
				dialogManager_.ShowMessage(message4, Quit);
			}
		}

		private void OpenUrl(string url)
		{
			Application.OpenURL(url);
		}

		private void Quit()
		{
			Application.Quit();
		}
	}
}

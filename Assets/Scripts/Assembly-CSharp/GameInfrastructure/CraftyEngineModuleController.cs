using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using CraftyEngine.Utils;
using ExceptionsModule;

namespace GameInfrastructure
{
	public class CraftyEngineModuleController
	{
		public static string defaultHosting;

		public static void InitCurrentSystem(int layer, bool init = true)
		{
			AddUnityEvent(layer);
			SingletonManager.Add<QueueManager>(layer);
			AddFilesManager(layer);
			if (init)
			{
				SingletonManager.InitiatePhase(SingletonPhase.Init, layer);
				SingletonManager.InitiatePhase(SingletonPhase.DataLoaded, layer);
			}
		}

		private static void AddUnityEvent(int layer)
		{
			SingletonManager.AddAlias<UnityEventRuntimeConductor, UnityEvent>(layer);
		}

		public static void InitEternalBasicSystem(int layer)
		{
			Log.Init();
			AddUnityEvent(layer);
			SingletonManager.Add<UnityTimerManager>(layer);
			ExceptionsModuleController.InitModule(0);
			SingletonManager.InitiatePhase(SingletonPhase.Init, layer);
		}

		public static void InitPermanentBasicSystem(int layer)
		{
			SingletonManager.Add<LegacyPermanentFilesManager>(layer);
			AddUnityEvent(layer);
			AddFilesManager(layer);
			SingletonManager.Add<QueueManager>(layer);
			SingletonManager.Add<MessageBroadcaster>(layer);
			SingletonManager.Add<CraftyEngineContentDeserializer>(layer);
		}

		public static void AddFilesManager(int layer)
		{
			if (string.IsNullOrEmpty(defaultHosting))
			{
				Log.Error("defaultHosting is undefined!");
			}
			FilesManager filesManager = SingletonManager.Add<FilesManager>(layer);
			filesManager.defaultHosting = defaultHosting;
		}
	}
}

using CraftyEngine.Infrastructure;
using CraftyEngine.States;

namespace CraftyEngine.Content
{
	public class ContentLoaderEntity : Singleton
	{
		private ContentLoaderModel model_;

		private UnityEvent unityEvent_;

		public ProgressableStateMachine StateMachine { get; private set; }

		public static void InitModule(int layer)
		{
			SingletonManager.Add<ContentLoaderModel>(layer);
			SingletonManager.Add<ContentLoaderEntity>(layer);
			if (CompileConstants.EDITOR)
			{
				SingletonManager.Add<EditorContentInfiltrationController>(layer);
			}
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			StateMachine.Dispose();
		}

		public override void Init()
		{
			SingletonManager.Get<ContentLoaderModel>(out model_);
			ContentLoaderController @object = new ContentLoaderController();
			State state = new ProgressState("Idle", 0f);
			State state2 = new ProgressState("loadVersion", 0.4f);
			State state3 = new ProgressState("checkVersion", 0.5f);
			State state4 = new ProgressState("reportNewVersion", 1f);
			State state5 = new ProgressState("loadDeploy", 0.6f);
			State state6 = new ProgressState("Success", 1f);
			state.AddTransaction(state2, () => model_.working);
			state2.AddTransaction(state3, () => model_.VersionLoaded);
			state3.AddTransaction(state4, () => model_.newVersionDetected);
			state3.AddTransaction(state5);
			state5.AddTransaction(state6, () => model_.DeployLoaded);
			state2.Entered += @object.LoadVersion;
			state3.Entered += @object.CheckVersion;
			state5.Entered += @object.LoadDeploy;
			state6.Entered += @object.ReportSuccess;
			state4.Entered += model_.ReportNewVersion;
			StateMachine = new ProgressableStateMachine(state, "ContentLoader");
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			if (model_.working)
			{
				StateMachine.Update();
			}
		}
	}
}

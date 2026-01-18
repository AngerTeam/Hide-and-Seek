using CraftyEngine.States;
using MyPlayerInput;
using PlayerModule.Playmate;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerEntity : PlayerEntityBase
	{
		private MyPlayerInputModel myPlayerInputModel_;

		public MyPlayerController Controller { get; private set; }

		public StateMachine InputStateMachine { get; private set; }

		public MyPlayerActionsController MyActionsController { get; private set; }

		public MyPlayerHudAndSoundController SoundController { get; private set; }

		public MyPlayerEntity()
			: base(true)
		{
			MyPlayerEntity myPlayerEntity = this;
			MyPlayerStatsModel model;
			SingletonManager.Get<MyPlayerStatsModel>(out model);
			SingletonManager.Get<MyPlayerInputModel>(out myPlayerInputModel_);
			model.stats.visibility.ByCameraMode = false;
			Controller = new MyPlayerController();
			MyActionsController = new MyPlayerActionsController(model);
			MyActionsController.ActionChanged += delegate
			{
				myPlayerEntity.Controller.ActionsHandler.Update(true);
			};
			State state = new State("Limbo");
			State state2 = new State("NoHand");
			State state3 = new State("Frozen");
			State state4 = new State("Normal");
			InputStateMachine = new StateMachine(state, "MyPlayer");
			if (InputStateMachine.EditorView != null)
			{
				ModelView modelView = InputStateMachine.EditorView.gameObject.AddComponent<ModelView>();
				modelView.myModel = model;
			}
			state.AddTransaction(state2, () => model.Enable);
			state.Exited += Controller.Init;
			state2.AddTransaction(state3, () => model.myVisibility.Visible);
			state3.AddTransaction(state2, () => !model.myVisibility.Visible);
			state3.AddTransaction(state4, () => model.input.EnabledByUi && model.myVisibility.Visible);
			state4.AddTransaction(state2, () => model.input.EnabledByUi && !model.myVisibility.Visible);
			state4.AddTransaction(state3, () => !model.input.EnabledByUi || !model.myVisibility.Visible);
			state2.Entered += delegate
			{
				myPlayerEntity.Controller.SetVisible(false);
			};
			state3.Entered += delegate
			{
				myPlayerEntity.Controller.EnableInput(false);
				myPlayerEntity.Controller.SetVisible(true);
				myPlayerEntity.MyActionsController.RefreshArticul();
			};
			state4.Entered += delegate
			{
				myPlayerEntity.Controller.EnableInput(true);
			};
			SoundController = new MyPlayerHudAndSoundController(model, Controller.ActionsHandler);
			myPlayerInputModel_.EnabledByPlayerState = true;
		}

		public override void Update()
		{
			base.Update();
			InputStateMachine.Update();
		}

		public override void Dispose()
		{
			base.Dispose();
			InputStateMachine.Dispose();
			Controller.Dispose();
			SoundController.Dispose();
		}
	}
}

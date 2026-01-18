namespace CraftyVoxelEngine
{
	public class VoxelInteraction : Singleton
	{
		public VoxelInteractionController controller;

		public VoxelInteractionModel model;

		public VoxelInteractionLogic logic;

		public VoxelInteractionInput input;

		private VoxelInteractionRuntime runtime_;

		public override void Init()
		{
			SingletonManager.Get<VoxelInteractionModel>(out model);
			controller = new VoxelInteractionController(model);
			logic = new VoxelInteractionLogic(model);
			runtime_ = new VoxelInteractionRuntime(model);
			input = new VoxelInteractionInput(model, logic, controller);
		}

		public override void Dispose()
		{
			input.Dispose();
			runtime_.Dispose();
			controller.Dispose();
		}
	}
}

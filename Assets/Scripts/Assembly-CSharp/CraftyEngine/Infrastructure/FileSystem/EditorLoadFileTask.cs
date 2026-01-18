namespace CraftyEngine.Infrastructure.FileSystem
{
	public class EditorLoadFileTask : LoadFileTask
	{
		public EditorLoadFileTask(int layer)
			: base(layer)
		{
			base.State = LoadState.Loaded;
		}

		public override void UnityUpdate()
		{
		}
	}
}

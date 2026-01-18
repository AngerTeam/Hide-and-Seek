namespace CraftyEngine.States
{
	public class ProgressState : State
	{
		public float progress;

		public ProgressState(string name, float progress)
			: base(name)
		{
			this.progress = progress;
		}
	}
}

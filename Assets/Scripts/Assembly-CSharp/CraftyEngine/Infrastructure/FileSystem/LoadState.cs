namespace CraftyEngine.Infrastructure.FileSystem
{
	public enum LoadState
	{
		Idle = 0,
		Stopped = 1,
		Loading = 2,
		Loaded = 3,
		Unloaded = 4,
		Errored = 5
	}
}

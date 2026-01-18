namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public enum SingletonPhase
	{
		Init = 0,
		DataLoaded = 1,
		Sync = 2,
		LogicLoaded = 3,
		ThreadStop = 4,
		Reset = 5
	}
}

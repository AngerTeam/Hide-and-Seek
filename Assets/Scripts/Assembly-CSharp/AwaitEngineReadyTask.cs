using CraftyEngine.Infrastructure;

public class AwaitEngineReadyTask : AsynchronousTask
{
	public override void Start()
	{
	}

	public void EngineReady()
	{
		Complete();
	}
}

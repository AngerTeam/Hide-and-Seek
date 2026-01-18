using System;

namespace CraftyEngine.Infrastructure
{
	public interface IUpdate
	{
		event Action Updated;
	}
}

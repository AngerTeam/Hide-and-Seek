using System;

namespace CraftyEngine.Infrastructure
{
	public interface IProgressable
	{
		float Weight { get; }

		float Progress { get; }

		event Action<float> Progressed;
	}
}

using System;

namespace RestoreServiceModule
{
	public interface IRestoreServiceWrapper
	{
		event Action<bool> AuthFinished;

		void Init();

		bool IsAuthenticated();

		string GetPlayerId();
	}
}

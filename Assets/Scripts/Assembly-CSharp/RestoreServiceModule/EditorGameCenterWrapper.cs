using System;
using Extensions;

namespace RestoreServiceModule
{
	public class EditorGameCenterWrapper : IRestoreServiceWrapper
	{
		public event Action<bool> AuthFinished;

		public void Init()
		{
			this.AuthFinished.SafeInvoke(true);
		}

		public bool IsAuthenticated()
		{
			return true;
		}

		public string GetPlayerId()
		{
			return "TestId12345";
		}
	}
}

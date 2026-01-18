using UnityEngine;

namespace LogSystem
{
	public class LogTargetRelease : Log.LogTarget
	{
		public override void AddMessage(Log.LogCategory category, string message)
		{
			if (category == Log.LogCategory.Error)
			{
				Debug.LogError("cLog: " + message);
			}
		}
	}
}

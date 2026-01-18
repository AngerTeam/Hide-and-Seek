using CraftyEngine.Infrastructure;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace TutorialModule
{
	public class TutorialStatePlayerControl : TutorialState
	{
		protected MyPlayerStatsModel myPlayerStatsModel_;

		protected Vector3 start;

		private UnityEvent unityEvent;

		public TutorialStatePlayerControl()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<UnityEvent>(out unityEvent);
		}

		public override void OnComplete()
		{
			unityEvent.Unsubscribe(UnityEventType.Update, Update);
		}

		public override void OnStart()
		{
			unityEvent.Subscribe(UnityEventType.Update, Update);
		}

		protected virtual void Update()
		{
		}
	}
}

using System;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace PlayerModule
{
	public sealed class ActionHandler : ArtikulHandler
	{
		public float? attackMoment;

		public float? cooldownMoment;

		public float? contactMoment;

		private bool myPlayer_;

		private UnityEvent unityEvent_;

		public int CurrentAction { get; private set; }

		public event Action ContactHappened;

		public event Action<int> ActionChangedLogic;

		public event Action<int> ActionChanged;

		public ActionHandler(PlayerStatsModel model, bool permanent, bool myPlayer)
		{
			myPlayer_ = myPlayer;
			SetModel(model, false);
			CurrentAction = -1;
			SingletonManager.Get<UnityEvent>(out unityEvent_, permanent ? 1 : 2);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public override void Dispose()
		{
			base.Dispose();
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		}

		public void Update()
		{
			Update(false);
		}

		public void Update(bool force)
		{
			HandleUpdate();
			if (base.Model.action != CurrentAction || force)
			{
				CurrentAction = base.Model.action;
				ReportActionChanged(base.Model.action);
			}
		}

		private void ReportActionChanged(int action)
		{
			this.ActionChangedLogic.SafeInvoke(action);
			this.ActionChanged.SafeInvoke(action);
		}

		private void HandleUpdate()
		{
			if (!myPlayer_ && (CurrentAction == 1 || CurrentAction == 9 || CurrentAction == 2))
			{
				if (cooldownMoment.HasValue && Time.time >= cooldownMoment.Value)
				{
					cooldownMoment = null;
					ReportActionChanged(5);
				}
				else if (attackMoment.HasValue)
				{
					float? num = attackMoment;
					if (num.HasValue && Time.time >= num.Value)
					{
						attackMoment = null;
						ReportActionChanged(CurrentAction);
					}
				}
			}
			if (contactMoment.HasValue)
			{
				float? num2 = contactMoment;
				if (num2.HasValue && Time.time >= num2.Value)
				{
					contactMoment = null;
					this.ContactHappened.SafeInvoke();
				}
			}
		}
	}
}

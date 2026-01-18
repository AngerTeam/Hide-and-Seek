using System;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlaymatePositionManager : Singleton
	{
		public delegate Vector3 PushVectorMethod(Vector3 direction, float pushForce);

		public static PushVectorMethod GetPushVector;

		private Type currentType_;

		public override void Init()
		{
			SetCurrentController<PlaymatePositionController>(PlaymatePositionController.GetPushVector);
		}

		public IPlaymatePositionController GetCurrentController()
		{
			return (IPlaymatePositionController)Activator.CreateInstance(currentType_);
		}

		public void SetCurrentController<T>(PushVectorMethod getPushVector) where T : IPlaymatePositionController, new()
		{
			currentType_ = typeof(T);
			GetPushVector = getPushVector;
		}
	}
}

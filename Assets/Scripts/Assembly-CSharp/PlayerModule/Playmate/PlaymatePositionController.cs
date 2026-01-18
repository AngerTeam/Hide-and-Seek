using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlaymatePositionController : IPlaymatePositionController
	{
		public Transform Transform { get; set; }

		public void SetTransform(Transform transform)
		{
			Transform = transform;
		}

		public void SetServerPosition(Vector3 position, Quaternion rotation)
		{
			if (Transform != null)
			{
				Transform.localPosition = position;
				Transform.localRotation = rotation;
			}
		}

		public void PushOnHit(Vector3 direction, float pushForce)
		{
		}

		public static Vector3 GetPushVector(Vector3 direction, float pushForce)
		{
			return Vector3.zero;
		}

		public void Dispose()
		{
		}
	}
}

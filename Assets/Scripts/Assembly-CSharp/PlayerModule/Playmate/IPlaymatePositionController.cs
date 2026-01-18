using UnityEngine;

namespace PlayerModule.Playmate
{
	public interface IPlaymatePositionController
	{
		Transform Transform { get; set; }

		void SetServerPosition(Vector3 position, Quaternion rotation);

		void PushOnHit(Vector3 direction, float pushForce);

		void SetTransform(Transform transform);

		void Dispose();
	}
}

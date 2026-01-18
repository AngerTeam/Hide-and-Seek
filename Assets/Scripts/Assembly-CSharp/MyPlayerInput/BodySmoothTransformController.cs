using UnityEngine;

namespace MyPlayerInput
{
	public class BodySmoothTransformController
	{
		private readonly Transform legsTransform_;

		private readonly Transform eyesTransform_;

		public float LegsPitchRotationSpeed { get; set; }

		public float TorsoYawRotationSpeed { get; set; }

		public float LegsPitchRotation { get; set; }

		public float TorsoYawRotation { get; set; }

		public BodySmoothTransformController(Transform legsTransform, Transform eyesTransform)
		{
			eyesTransform_ = eyesTransform;
			legsTransform_ = legsTransform;
			LegsPitchRotationSpeed = 360f;
			TorsoYawRotationSpeed = 360f;
		}

		public void Update()
		{
			Vector3 eulerAngles = legsTransform_.eulerAngles;
			eulerAngles.y = Mathf.MoveTowardsAngle(eulerAngles.y, LegsPitchRotation, Time.deltaTime * LegsPitchRotationSpeed);
			legsTransform_.eulerAngles = eulerAngles;
			Vector3 localEulerAngles = eyesTransform_.localEulerAngles;
			localEulerAngles.x = Mathf.MoveTowardsAngle(localEulerAngles.x, TorsoYawRotation, Time.deltaTime * TorsoYawRotationSpeed);
			eyesTransform_.localEulerAngles = localEulerAngles;
		}

		public void Reset(Vector3 position, Vector3 rotation)
		{
			legsTransform_.position = position;
			legsTransform_.eulerAngles = new Vector3(0f, rotation.y, 0f);
			eyesTransform_.localEulerAngles = new Vector3(rotation.x, 0f, 0f);
		}

		public void SetRotation(Vector3 rotation)
		{
			LegsPitchRotation = rotation.y;
			TorsoYawRotation = rotation.x;
			legsTransform_.eulerAngles = new Vector3(0f, LegsPitchRotation, 0f);
			eyesTransform_.localEulerAngles = new Vector3(TorsoYawRotation, 0f, 0f);
		}
	}
}

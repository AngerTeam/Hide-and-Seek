using UnityEngine;

namespace MyPlayerInput
{
	public class Smooth
	{
		private int totalUpdateCallsCount;

		private int totalFixedUpdateCallsCount;

		private float positionUpdateRateDifference;

		private float rotationUpdateRateDifference;

		private Vector3 eyesTargetDif_;

		private Vector3 eyesTargetPosition_;

		private bool interpolate_;

		private Transform eyesTransform_;

		private Transform cameraTransform_;

		private Transform bodyTransform;

		private int updateCallsCount;

		public Smooth(Transform eyesTransform_, Transform cameraTransform_, Transform bodyTransform)
		{
			this.eyesTransform_ = eyesTransform_;
			this.cameraTransform_ = cameraTransform_;
			this.bodyTransform = bodyTransform;
		}

		internal void Update()
		{
			eyesTargetPosition_ = eyesTransform_.position;
			eyesTargetDif_ = (eyesTargetPosition_ - cameraTransform_.position) * positionUpdateRateDifference;
		}

		internal void UnityFixedUpdate()
		{
			CalculateAvarageUpdateError();
			updateCallsCount = 0;
		}

		private void CalculateAvarageUpdateError()
		{
			totalFixedUpdateCallsCount++;
			totalUpdateCallsCount += updateCallsCount;
			positionUpdateRateDifference = (float)totalFixedUpdateCallsCount / (float)totalUpdateCallsCount;
			interpolate_ = positionUpdateRateDifference < 1f;
			rotationUpdateRateDifference = positionUpdateRateDifference;
			if (rotationUpdateRateDifference > 0.75f)
			{
				rotationUpdateRateDifference = 0.75f;
			}
			if (positionUpdateRateDifference > 0.3f)
			{
				positionUpdateRateDifference = 0.3f;
			}
			if (totalUpdateCallsCount > 1000)
			{
				totalFixedUpdateCallsCount = (int)((float)totalFixedUpdateCallsCount * 0.3f);
				totalUpdateCallsCount = (int)((float)totalUpdateCallsCount * 0.3f);
			}
		}

		public void InterpolacteCamera()
		{
			if (interpolate_)
			{
				float num = Vector3.Distance(cameraTransform_.position, eyesTargetPosition_);
				if (num >= eyesTargetDif_.magnitude)
				{
					cameraTransform_.position += eyesTargetDif_;
				}
				Vector3 vector = new Vector3(eyesTransform_.eulerAngles.x, bodyTransform.eulerAngles.y, 0f);
				while (vector.x - cameraTransform_.eulerAngles.x > 180f)
				{
					vector.x -= 360f;
				}
				if (vector.y - cameraTransform_.eulerAngles.y > 180f)
				{
					vector.y -= 360f;
				}
				if (vector.x - cameraTransform_.eulerAngles.x > 180f)
				{
					vector.x -= 360f;
				}
				if (cameraTransform_.eulerAngles.y - vector.y > 180f)
				{
					vector.y += 360f;
				}
				if (cameraTransform_.eulerAngles.x - vector.x > 180f)
				{
					vector.x = 360f;
				}
				Vector3 vector2 = vector - cameraTransform_.eulerAngles;
				if (vector2.magnitude < 0.5f)
				{
					cameraTransform_.eulerAngles = vector;
				}
				else
				{
					cameraTransform_.eulerAngles += vector2 * rotationUpdateRateDifference;
				}
			}
			else
			{
				cameraTransform_.position = eyesTargetPosition_;
				cameraTransform_.eulerAngles = new Vector3(eyesTransform_.eulerAngles.x, bodyTransform.transform.eulerAngles.y, 0f);
			}
		}

		public void UnityUpdate()
		{
			updateCallsCount++;
		}
	}
}

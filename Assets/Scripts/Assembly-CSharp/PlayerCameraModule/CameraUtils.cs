using UnityEngine;

namespace PlayerCameraModule
{
	public class CameraUtils
	{
		public static Vector3 CalcTargetWithOffset(Transform cameraTransfrom, Vector3 targetPosition, Vector3 localOffset)
		{
			Vector3 forward = cameraTransfrom.forward;
			forward.y = 0f;
			forward.Normalize();
			return targetPosition + cameraTransfrom.right * localOffset.x + Vector3.up * localOffset.y + forward * localOffset.z;
		}

		public static Vector3 CalcTargetOffset(Transform cameraTransfrom, Vector3 targetPosition, Vector3 worldOffset)
		{
			Vector3 vector = cameraTransfrom.InverseTransformDirection(worldOffset - targetPosition);
			vector.y = vector.z;
			vector.z = 0f;
			return targetPosition + vector;
		}

		public static Vector3 ProjectPointOnPlane(Vector3 planeNormal, Vector3 planePoint, Vector3 point)
		{
			float num = Vector3.Dot(planeNormal, point - planePoint);
			num *= -1f;
			Vector3 vector = planeNormal * num;
			return point + vector;
		}
	}
}

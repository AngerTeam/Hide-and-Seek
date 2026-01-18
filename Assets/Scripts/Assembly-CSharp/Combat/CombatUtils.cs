using PlayerModule;
using UnityEngine;

namespace Combat
{
	public class CombatUtils
	{
		private static Ray[] rays1_ = new Ray[1];

		private static Ray[] rays5_ = new Ray[5];

		public static PlayerStatsModel RaycastHasActor(Ray originalRay, float distance, int layerMask, bool singleRay, out RaycastHit raycastHit)
		{
			Ray[] array;
			if (singleRay)
			{
				rays1_[0] = originalRay;
				array = rays1_;
			}
			else
			{
				rays5_[0] = originalRay;
				rays5_[1] = GetTurnedRay(originalRay, -15);
				rays5_[2] = GetTurnedRay(originalRay, 15);
				rays5_[3] = GetTurnedRay(originalRay, -30);
				rays5_[4] = GetTurnedRay(originalRay, 30);
				array = rays5_;
			}
			for (int i = 0; i < array.Length; i++)
			{
				Ray ray = array[i];
				if (CompileConstants.EDITOR)
				{
					Vector3 end = ray.origin + ray.direction * distance;
					Debug.DrawLine(ray.origin, end, Color.green);
				}
				RaycastHit[] array2 = Physics.RaycastAll(ray, distance, layerMask);
				for (int j = 0; j < array2.Length; j++)
				{
					RaycastHit raycastHit2 = array2[j];
					PlayerModelHolder component = raycastHit2.transform.GetComponent<PlayerModelHolder>();
					if (component != null && component.Model != null)
					{
						raycastHit = raycastHit2;
						return component.Model;
					}
				}
			}
			raycastHit = default(RaycastHit);
			return null;
		}

		public static Ray GetTurnedRay(Ray originalRay, int angle)
		{
			Vector3 direction = originalRay.direction;
			Quaternion quaternion = Quaternion.AngleAxis(angle, new Vector3(0f, 1f, 0f));
			Vector3 direction2 = quaternion * direction;
			return new Ray(originalRay.origin, direction2);
		}
	}
}

using UnityEngine;

namespace ArticulViewModule
{
	public class BoxArticulView : ArticulViewBase
	{
		private GameObject renderTarget_;

		public override bool IsBillboard
		{
			get
			{
				return false;
			}
		}

		public override void Render(Transform parent, int articulId)
		{
			base.Container = new GameObject();
			base.Container.transform.SetParent(parent);
			base.Container.transform.localPosition = Vector3.zero;
			base.Container.transform.localRotation = Quaternion.identity;
			renderTarget_ = GameObject.CreatePrimitive(PrimitiveType.Cube);
			renderTarget_.transform.localScale = Vector3.one * 0.5f;
			Object.Destroy(renderTarget_.GetComponent<Collider>());
			base.Instance = HandleHierarchy(renderTarget_, false, isPlayer);
			renderTarget_.transform.localPosition = Vector3.zero;
			renderTarget_.transform.localEulerAngles = Vector3.zero;
		}

		public override void Dispose()
		{
			Object.Destroy(renderTarget_);
		}
	}
}

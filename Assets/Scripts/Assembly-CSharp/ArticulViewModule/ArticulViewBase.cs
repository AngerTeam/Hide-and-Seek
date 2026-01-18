using System;
using Extensions;
using UnityEngine;

namespace ArticulViewModule
{
	public abstract class ArticulViewBase : IDisposable
	{
		public bool isPlayer;

		public int type;

		public string persId;

		public bool inHandAngle;

		public float multypleScale;

		public GameObject Instance { get; protected set; }

		public abstract bool IsBillboard { get; }

		public GameObject Container { get; protected set; }

		public bool Rendered { get; private set; }

		public event Action RenderCompleted;

		public ArticulViewBase()
		{
			multypleScale = 1f;
		}

		public virtual void Dispose()
		{
			if (Container != null)
			{
				UnityEngine.Object.Destroy(Container);
				Container = null;
			}
		}

		public virtual void ActivateBillboard()
		{
		}

		public abstract void Render(Transform container, int articulId);

		protected void ReportRendered()
		{
			Rendered = true;
			this.RenderCompleted.SafeInvoke();
		}

		protected GameObject HandleHierarchy(GameObject instaince, bool madAngle = true, bool isPlayer = false)
		{
			Animator component = instaince.GetComponent<Animator>();
			if (component == null)
			{
				GameObject gameObject = new GameObject("holder");
				gameObject.transform.SetParent(Container.transform, false);
				GameObject gameObject2 = new GameObject("Armature");
				gameObject2.transform.SetParent(gameObject.transform, false);
				GameObject gameObject3 = new GameObject("arm_r");
				gameObject3.transform.SetParent(gameObject2.transform, false);
				GameObject gameObject4 = new GameObject("hand");
				gameObject4.transform.SetParent(gameObject3.transform, false);
				instaince.transform.SetParent(gameObject4.transform, false);
				instaince.transform.localPosition = Vector3.zero;
				if (madAngle)
				{
					instaince.transform.localEulerAngles = new Vector3(90f, 0f, 0f);
				}
				instaince = gameObject;
			}
			else
			{
				instaince.transform.SetParent(Container.transform, false);
				instaince.transform.localPosition = Vector3.zero;
			}
			return instaince;
		}
	}
}

using System.Collections.Generic;
using NguiTools;
using UnityEngine;

namespace CraftyGameEngine.Gui.Fx
{
	public class RayGlow
	{
		private RayGlowHierarchy hierarchy_;

		private List<UISprite> rays;

		public RayGlow()
		{
			NguiManager singlton;
			SingletonManager.Get<NguiManager>(out singlton);
			PrefabsManagerNGUI singlton2;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton2);
			singlton2.Load("RayGlowPrefabsHolder");
			hierarchy_ = singlton2.InstantiateNGUIIn<RayGlowHierarchy>("UIRayGroup", singlton.UiRoot.gameObject);
			UISprite raySprite = hierarchy_.raySprite;
			rays = new List<UISprite>();
			AddRay(raySprite);
			for (int i = 1; i < hierarchy_.raysCount; i++)
			{
				AddRay(Object.Instantiate(raySprite));
			}
		}

		private void AddRay(UISprite Ray)
		{
			Ray.name = string.Format("Ray {0}", rays.Count + 1);
			Ray.transform.SetParent(hierarchy_.transform);
			Ray.transform.localScale = Vector3.one;
			rays.Add(Ray);
		}

		public void SetParent(Transform parent)
		{
			hierarchy_.transform.SetParent(parent);
			hierarchy_.transform.localPosition = Vector3.zero;
		}

		public void RandomizeRays()
		{
			for (int i = 0; i < rays.Count; i++)
			{
				UISprite uISprite = rays[i];
				TweenRotation component = uISprite.GetComponent<TweenRotation>();
				TweenAlpha component2 = uISprite.GetComponent<TweenAlpha>();
				Vector3 vector = new Vector3(0f, 0f, Random.Range(-180, 180));
				int num = Random.Range(0, 2);
				Vector3 to = new Vector3(0f, 0f, vector.z + (float)((num <= 0) ? (-360) : 360));
				uISprite.width = 75 + 25 * Random.Range(0, 4);
				uISprite.height = 300 + 25 * Random.Range(0, 5);
				uISprite.transform.eulerAngles = vector;
				component.from = vector;
				component.to = to;
				component.duration = Random.Range(45, 50);
				int num2 = Random.Range(0, 10);
				int num3 = Random.Range(3, 6);
				component2.style = UITweener.Style.PingPong;
				component2.from = 0.1f;
				component2.to = 1f;
				component2.delay = num2;
				component2.duration = num3;
				Color color = uISprite.color;
				color.a = 0.1f;
				uISprite.color = color;
			}
		}
	}
}

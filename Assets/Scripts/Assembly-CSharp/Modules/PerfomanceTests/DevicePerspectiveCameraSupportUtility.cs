using UnityEngine;

namespace Modules.PerfomanceTests
{
	public class DevicePerspectiveCameraSupportUtility
	{
		public static bool FullTest()
		{
			Camera camera = MakeCamera();
			RenderTexture renderTexture = (RenderTexture.active = camera.targetTexture);
			Texture2D tex = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGB24, false);
			bool flag = true;
			for (int i = 0; i < 10; i++)
			{
				bool flag2 = TestIteration(camera, tex, renderTexture);
				flag = flag && flag2;
			}
			RenderTexture.active = null;
			Object.Destroy(camera.gameObject, 10f);
			return flag;
		}

		private static int RandomRange(int min, int max)
		{
			return Random.Range(min, max);
		}

		private static bool TestIteration(Camera cam, Texture2D tex, RenderTexture rend)
		{
			int num = RandomRange(1, rend.width / 10);
			int num2 = RandomRange(1, rend.height / 10);
			int num3 = rend.width - num - RandomRange(1, rend.width / 10);
			int num4 = rend.height - num2 - RandomRange(1, rend.height / 10);
			Rect pixelRect = new Rect(num, num2, num3, num4);
			cam.pixelRect = pixelRect;
			cam.Render();
			tex.ReadPixels(new Rect(0f, 0f, rend.width, rend.height), 0, 0);
			tex.Apply();
			return tex.GetPixel(rend.width / 5, rend.height / 5).Equals(Color.red);
		}

		private static Camera MakeCamera()
		{
			GameObject gameObject = new GameObject("Test Camera", typeof(Camera));
			Object.DontDestroyOnLoad(gameObject);
			gameObject.transform.position = new Vector3(0f, -500f, 10f);
			Camera component = gameObject.GetComponent<Camera>();
			component.targetTexture = new RenderTexture(128, 128, 24);
			Shader shader = Shader.Find("kaleb/Color");
			Material material = new Material(shader);
			material.SetColor("_Color", Color.red);
			GameObject gameObject2 = GameObject.CreatePrimitive(PrimitiveType.Cube);
			MeshRenderer component2 = gameObject2.GetComponent<MeshRenderer>();
			component2.sharedMaterial = material;
			gameObject2.transform.SetParent(gameObject.transform);
			gameObject2.transform.localPosition = new Vector3(0f, 0f, 1f);
			return component;
		}
	}
}

using System;
using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorSizeBorder : IDisposable
	{
		private GameObject container_;

		public VoxelEditorSizeBorder(int size)
		{
			container_ = new GameObject("borderContainer");
			Material sharedMaterial = new Material(Shader.Find("Legacy Shaders/Self-Illumin/Diffuse"))
			{
				color = new Color(0.56078434f, 0.52156866f, 0f, 1f)
			};
			float num = (float)size / 10f;
			float num2 = (float)size * 0.5f;
			for (int i = 0; i < 4; i++)
			{
				for (int j = 0; j < 10; j++)
				{
					GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
					gameObject.transform.SetParent(container_.transform);
					gameObject.transform.position = new Vector3(0f, (float)j * num, num2);
					gameObject.transform.localScale = new Vector3(size, 1f, 1f);
					gameObject.GetComponent<Renderer>().sharedMaterial = sharedMaterial;
				}
				container_.transform.Rotate(new Vector3(0f, 90f, 0f));
			}
			container_.transform.position = new Vector3(num2, 0f, num2);
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(container_);
		}
	}
}

using System.IO;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils;
using UnityEngine;

namespace CraftyBundles
{
	public class RenderHierarchyUtils
	{
		public static void RestoreMaterials(RenderHierarchy data, Transform transform)
		{
			if (!(transform != null))
			{
				return;
			}
			RestoreHierarchy(data, transform);
			TexturesHolder component = transform.gameObject.GetComponent<TexturesHolder>();
			for (int i = 0; i < data.materials.Length; i++)
			{
				RenderHierarchyMaterial renderHierarchyMaterial = data.materials[i];
				Shader shader = Shader.Find(renderHierarchyMaterial.shaderName);
				renderHierarchyMaterial.material.shader = shader;
				for (int j = 0; j < renderHierarchyMaterial.shaderProperties.Length; j++)
				{
					ShaderProperty shaderProperty = renderHierarchyMaterial.shaderProperties[j];
					switch (shaderProperty.type)
					{
					case 0:
						renderHierarchyMaterial.material.SetColor(shaderProperty.name, ColorUtils.HexToColor(shaderProperty.value));
						break;
					case 1:
					case 2:
					{
						float result2;
						if (float.TryParse(shaderProperty.value, out result2))
						{
							renderHierarchyMaterial.material.SetFloat(shaderProperty.name, result2);
						}
						break;
					}
					case 3:
					{
						int result;
						if (int.TryParse(shaderProperty.value, out result) && result < component.textures.Length)
						{
							renderHierarchyMaterial.material.SetTexture(shaderProperty.name, component.textures[result]);
						}
						break;
					}
					case 4:
					{
						Vector4 vector = Vector3Utils.SafeParse4(shaderProperty.value);
						renderHierarchyMaterial.material.SetVector(shaderProperty.name, vector);
						break;
					}
					}
				}
			}
		}

		public static bool TryInstansiate(FileHolder file, out GameObject instance)
		{
			if (TryInstansiate(file.loadedAssetBundle, out instance))
			{
				return true;
			}
			GameObject gameObject = (GameObject)file.GetBundle();
			if (gameObject == null)
			{
				return false;
			}
			instance = (GameObject)file.Instantiate();
			return instance != null;
		}

		public static bool TryInstansiate(AssetBundle assetBundle, out GameObject result)
		{
			result = null;
			if (assetBundle == null)
			{
				return false;
			}
			TextAsset textAsset = assetBundle.LoadAsset<TextAsset>("renderHiearchyMeta");
			if (textAsset != null)
			{
				string[] allAssetNames = assetBundle.GetAllAssetNames();
				GameObject gameObject = null;
				foreach (string text in allAssetNames)
				{
					if (text.Contains(".prefab"))
					{
						string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(text);
						gameObject = assetBundle.LoadAsset<GameObject>(fileNameWithoutExtension);
						break;
					}
				}
				if (gameObject == null)
				{
					Log.Error("Unable to find prefab in {0}", ArrayUtils.ArrayToString(allAssetNames));
					return false;
				}
				RenderHierarchy data = JsonUtility.FromJson<RenderHierarchy>(textAsset.text);
				result = Object.Instantiate(gameObject);
				RestoreMaterials(data, result.transform);
				return true;
			}
			return false;
		}

		private static void RestoreHierarchy(RenderHierarchy data, Transform transform)
		{
			for (int i = 0; i < data.hierarchy.Length; i++)
			{
				RenderHierarchyNode renderHierarchyNode = data.hierarchy[i];
				if (renderHierarchyNode.parent < 0)
				{
					renderHierarchyNode.transform = transform;
				}
				else
				{
					RenderHierarchyNode renderHierarchyNode2 = data.hierarchy[renderHierarchyNode.parent];
					Transform transform2 = renderHierarchyNode2.transform;
					renderHierarchyNode.transform = transform2.GetChild(renderHierarchyNode.childId);
				}
				if (renderHierarchyNode.materialId == null || renderHierarchyNode.materialId.Length == 0)
				{
					continue;
				}
				renderHierarchyNode.renderer = renderHierarchyNode.transform.GetComponent<Renderer>();
				if (!(renderHierarchyNode.renderer == null))
				{
					for (int j = 0; j < renderHierarchyNode.materialId.Length; j++)
					{
						int num = renderHierarchyNode.materialId[j];
						RenderHierarchyMaterial renderHierarchyMaterial = data.materials[num];
						renderHierarchyMaterial.material = renderHierarchyNode.renderer.sharedMaterials[j];
					}
				}
			}
		}
	}
}

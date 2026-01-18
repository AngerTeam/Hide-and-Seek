using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelSelector : IDisposable
	{
		private VoxelSelection selection_;

		private PrefabsManager prefabsManager_;

		private Material material_;

		public VoxelRegion region;

		public int regionType = 3;

		public bool Holder;

		public bool Access;

		public bool Trigger;

		private bool alternation;

		public bool active { get; private set; }

		public VoxelSelector()
		{
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			prefabsManager_.Load("CraftyVoxelEngineRuntimePrefabsHolder");
			selection_ = prefabsManager_.Instantiate<VoxelSelection>("EditorVoxelSelection");
			Renderer component = selection_.Body.GetComponent<Renderer>();
			if (component != null)
			{
				material_ = component.sharedMaterial;
				component = selection_.BoxA.GetComponent<Renderer>();
				component.sharedMaterial = material_;
				component = selection_.BoxB.GetComponent<Renderer>();
				component.sharedMaterial = material_;
			}
			selection_.gameObject.SetActive(false);
			UpdateSelection();
		}

		public void Dispose()
		{
			UnityEngine.Object.Destroy(selection_);
		}

		public void Hide()
		{
			region.Set();
			active = false;
			selection_.gameObject.SetActive(false);
			UpdateSelection();
		}

		public void SetPosition(VoxelKey key)
		{
			selection_.gameObject.SetActive(true);
			if (active)
			{
				if (alternation)
				{
					region.min = key;
				}
				else
				{
					region.max = key;
				}
				alternation = !alternation;
			}
			else
			{
				region.min = key;
				region.max = key;
				alternation = false;
				active = true;
			}
			UpdateSelection();
		}

		public void SetScale(VoxelKey scale)
		{
			selection_.gameObject.SetActive(true);
			region.Set(region.min, region.min + scale);
			UpdateSelection();
		}

		public void HiLight(bool light)
		{
			material_.SetColor("_Color", VoxelSelectorColors.GetColor(regionType, light));
		}

		public void Push(RaycastHit boxHit)
		{
			int sideByNormal = BoxSide.GetSideByNormal(boxHit.normal);
			ShiftSide(sideByNormal, -1);
			ShiftSide(BoxSide.mirror[sideByNormal], 1);
		}

		public void Pull(RaycastHit boxHit)
		{
			int sideByNormal = BoxSide.GetSideByNormal(boxHit.normal);
			ShiftSide(sideByNormal, 1);
			ShiftSide(BoxSide.mirror[sideByNormal], -1);
		}

		public void Constrict(RaycastHit boxHit)
		{
			int sideByNormal = BoxSide.GetSideByNormal(boxHit.normal);
			ShiftSide(sideByNormal, -1);
		}

		public void Expand(RaycastHit boxHit)
		{
			int sideByNormal = BoxSide.GetSideByNormal(boxHit.normal);
			ShiftSide(sideByNormal, 1);
		}

		public void ShiftSide(int boxSide, int step)
		{
			switch (boxSide)
			{
			case 0:
				if (region.min.x >= region.max.x)
				{
					region.min.x = region.min.x + step;
				}
				else
				{
					region.max.x = region.max.x + step;
				}
				break;
			case 1:
				if (region.min.x <= region.max.x)
				{
					region.min.x = region.min.x - step;
				}
				else
				{
					region.max.x = region.max.x - step;
				}
				break;
			case 2:
				if (region.min.y >= region.max.y)
				{
					region.min.y = region.min.y + step;
				}
				else
				{
					region.max.y = region.max.y + step;
				}
				break;
			case 3:
				if (region.min.y <= region.max.y)
				{
					region.min.y = region.min.y - step;
				}
				else
				{
					region.max.y = region.max.y - step;
				}
				break;
			case 4:
				if (region.min.z >= region.max.z)
				{
					region.min.z = region.min.z + step;
				}
				else
				{
					region.max.z = region.max.z + step;
				}
				break;
			case 5:
				if (region.min.z <= region.max.z)
				{
					region.min.z = region.min.z - step;
				}
				else
				{
					region.max.z = region.max.z - step;
				}
				break;
			}
			UpdateSelection();
		}

		public void UpdateSelection()
		{
			Vector3 vector = Vector3.one * 0.5f;
			selection_.BoxA.transform.position = region.min.ToVector() + vector;
			selection_.BoxB.transform.position = region.max.ToVector() + vector;
			selection_.Body.transform.position = region.center + vector;
			selection_.Body.transform.localScale = region.scale + Vector3.one * 1.1f;
			selection_.Body.transform.rotation = Quaternion.identity;
			selection_.Body.transform.name = region.ToString();
		}
	}
}

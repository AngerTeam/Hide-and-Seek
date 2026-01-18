using ArticulViewModule;
using CraftyVoxelEngine;
using InventoryModule;
using UnityEngine;

namespace PlayerModule
{
	public class VoxelArticulView : ArticulViewBase
	{
		private VoxelEngine voxelEngine_;

		private GameObject renderTarget_;

		private VoxelLoader voxelLoader_;

		public override bool IsBillboard
		{
			get
			{
				return false;
			}
		}

		public VoxelArticulView()
		{
			SingletonManager.TryGet<VoxelEngine>(out voxelEngine_);
			SingletonManager.TryGet<VoxelLoader>(out voxelLoader_);
		}

		public override void Render(Transform parent, int articulId)
		{
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(articulId, out value))
			{
				RenderVoxel(parent, (ushort)value.voxel_id, value.title, multypleScale);
			}
			if (inHandAngle)
			{
				base.Container.transform.localPosition = new Vector3(-0.2f, 0.25f, 0f);
				base.Container.transform.localRotation = Quaternion.Euler(-45f, 0f, -90f);
			}
		}

		public void RenderVoxel(Transform parent, ushort voxelId, string title, float scale = 1f)
		{
			if (voxelEngine_ == null)
			{
				return;
			}
			ushort num = voxelId;
			if (num == 0)
			{
				return;
			}
			base.Container = new GameObject();
			renderTarget_ = new GameObject();
			renderTarget_.name = string.Format("[Voxel {0}]", title);
			base.Instance = HandleHierarchy(renderTarget_, false, isPlayer);
			renderTarget_.transform.localPosition = -Vector3.one * 0.5f;
			if (parent != null)
			{
				float num2 = 0f;
				VoxelData data;
				if (voxelEngine_.Settings.GetData(num, out data))
				{
					num2 = data.ScaleInHand;
				}
				if (num2 == 0f)
				{
					num2 = 1f;
				}
				num2 *= scale;
				base.Container.transform.SetParent(parent);
				base.Container.transform.localPosition = Vector3.zero;
				base.Container.transform.localRotation = Quaternion.identity;
				base.Container.transform.localScale = new Vector3(num2, num2, num2);
			}
			voxelEngine_.voxelActions.RenderVoxel(num, true, AssignMesh);
		}

		private void AssignMesh(DataSerializable data)
		{
			HandleVoxelRendered((MessageVoxelRendered)data);
		}

		private void HandleVoxelRendered(MessageVoxelRendered voxelRendered)
		{
			MeshHolder meshHolder = new MeshHolder(voxelRendered.meshHolder);
			CraftyVoxelEngine.Mesh mesh = meshHolder.GetMesh(0);
			MeshFilter filter = renderTarget_.AddComponent<MeshFilter>();
			MeshRenderer meshRenderer = renderTarget_.AddComponent<MeshRenderer>();
			meshHolder.MakeMesh(filter, mesh);
			meshRenderer.sharedMaterial = voxelLoader_.transMaterial;
			meshHolder.FreeMeshs();
			ReportRendered();
		}
	}
}

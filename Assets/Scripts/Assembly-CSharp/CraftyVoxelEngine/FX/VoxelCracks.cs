using UnityEngine;

namespace CraftyVoxelEngine.FX
{
	public class VoxelCracks
	{
		public const int limit = 5;

		private VoxelEngine voxelEngine_;

		private int count_;

		private GameObject[] objects_;

		private GameObject boxView_;

		private GameObject crossView_;

		private GameObject stairView_;

		private GameObject slabView_;

		private GameObject carpetView_;

		private Material sharedMaterial_;

		public bool Locked;

		public int ChunkIndex = -1;

		public GameObject cracks { get; private set; }

		public Material SharedMaterial
		{
			get
			{
				return sharedMaterial_;
			}
			set
			{
				sharedMaterial_ = value;
				GameObject[] array = objects_;
				foreach (GameObject gameObject in array)
				{
					MeshRenderer component = gameObject.GetComponent<MeshRenderer>();
					component.sharedMaterial = sharedMaterial_;
				}
			}
		}

		public VoxelCracks()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			count_ = 0;
			cracks = new GameObject("Cracks");
			cracks.transform.localScale = Vector3.one * 1.001f;
			Object.DontDestroyOnLoad(cracks);
			objects_ = new GameObject[5];
			boxView_ = MakeVoxel(0, "view-box");
			crossView_ = MakeVoxel(1, "view-cross");
			slabView_ = MakeVoxel(2, "view-slab");
			stairView_ = MakeVoxel(3, "view-stair");
			carpetView_ = MakeVoxel(4, "view-carpet");
			Hide();
		}

		private GameObject MakeVoxel(int index, string name)
		{
			GameObject gameObject = (objects_[count_++] = new GameObject());
			MeshFilter filter = gameObject.AddComponent<MeshFilter>();
			gameObject.AddComponent<MeshRenderer>();
			voxelEngine_.voxelActions.RenderVoxel(index, false, delegate(DataSerializable e)
			{
				HandleVoxelRendered(e, filter);
			});
			gameObject.name = "Voxel view: " + name;
			gameObject.transform.SetParent(cracks.transform);
			gameObject.transform.localPosition = -0.5f * Vector3.one;
			gameObject.transform.localScale = Vector3.one;
			return gameObject;
		}

		private void HandleVoxelRendered(DataSerializable rendered, MeshFilter filter)
		{
			MessageVoxelRendered messageVoxelRendered = rendered as MessageVoxelRendered;
			if (messageVoxelRendered != null)
			{
				MeshHolder meshHolder = new MeshHolder(messageVoxelRendered.meshHolder);
				meshHolder.MakeMesh(filter);
				meshHolder.FreeMeshs();
			}
		}

		public void Hide()
		{
			if (!Locked)
			{
				GameObject[] array = objects_;
				foreach (GameObject gameObject in array)
				{
					gameObject.SetActive(false);
				}
			}
		}

		public void Set(VoxelKey globalKey, int type = 0, byte rotation = 0)
		{
			if (!Locked)
			{
				cracks.transform.position = globalKey.ToVector() + Vector3.one * 0.5f;
				cracks.transform.localRotation = VoxelCore.GetQuaternionByRotation(rotation);
				Hide();
				switch (type)
				{
				case 2:
					crossView_.SetActive(true);
					break;
				case 3:
					stairView_.SetActive(true);
					break;
				case 10:
					slabView_.SetActive(true);
					break;
				case 11:
					carpetView_.SetActive(true);
					break;
				default:
					boxView_.SetActive(true);
					break;
				}
			}
		}
	}
}

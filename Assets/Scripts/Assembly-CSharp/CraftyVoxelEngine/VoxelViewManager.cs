using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelViewManager
	{
		private PrefabsManager prefabsManager_;

		public static bool applyMesh = true;

		public Array3D<ChunkView> chunkViews;

		public Material solidMaterial;

		public Material transMaterial;

		public Vector3 playerPos;

		public float RenderMeshInFrameLimit = 8f;

		public float rendRange = 110f;

		public float viewRange = 60f;

		public GameObject Wrap;

		private MeshBox currentMeshBox_;

		private ChunkView currentView_;

		private Queue<MeshBox> holders_;

		private int meshIterator_;

		public event Action<VoxelKey> ChunkRenderedLibEvent;

		public event Action<VoxelKey> ChunkRenderedUnityEvent;

		public event Action OutOfMeshs;

		public void Init()
		{
			SingletonManager.Get<PrefabsManager>(out prefabsManager_);
			prefabsManager_.Load("CraftyVoxelEngineRuntimePrefabsHolder");
			Wrap = new GameObject("VoxelView");
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(Wrap);
			}
			chunkViews = new Array3D<ChunkView>(16, 16, 16);
			holders_ = new Queue<MeshBox>();
		}

		public ChunkViewHierarchy CreateMeshObject(VoxelKey key, int index)
		{
			ChunkViewHierarchy chunkViewHierarchy = prefabsManager_.Instantiate<ChunkViewHierarchy>("ChunkView");
			chunkViewHierarchy.name = string.Format("Rendered {0} {1}", key, index);
			chunkViewHierarchy.filter.mesh = new UnityEngine.Mesh();
			chunkViewHierarchy.transform.SetParent(Wrap.transform);
			chunkViewHierarchy.transform.position = key.ToVector() * 16f;
			return chunkViewHierarchy;
		}

		public void Clear()
		{
			int length = chunkViews.Length;
			for (int i = 0; i < length; i++)
			{
				ChunkView chunkView = chunkViews[i];
				if (chunkView != null)
				{
					chunkView.Clear();
				}
			}
			if (Wrap != null)
			{
				foreach (Transform item in Wrap.transform)
				{
					UnityEngine.Object.Destroy(item.gameObject);
				}
			}
			foreach (MeshBox item2 in holders_)
			{
				item2.Dispose();
			}
			holders_.Clear();
			if (currentMeshBox_ != null)
			{
				currentMeshBox_.Dispose();
			}
			currentMeshBox_ = null;
		}

		public void ChunkChanged(MessageChunkChanged args)
		{
			switch (args.chunkState)
			{
			case 1:
				ChunkRendered(args);
				break;
			case 2:
				ChunkShowed(args);
				break;
			case 3:
				ChunkHidden(args);
				break;
			case 4:
				ChunkDisposed(args);
				break;
			}
		}

		private void ChunkRendered(MessageChunkChanged args)
		{
			MeshBox item = new MeshBox(args.chunkKey, args.solidHolder, args.transHolder);
			holders_.Enqueue(item);
		}

		private void ChunkShowed(MessageChunkChanged args)
		{
			VoxelKey chunkKey = args.chunkKey;
			ChunkView chunkView = chunkViews.Get(chunkKey.x, chunkKey.y, chunkKey.z);
			if (chunkView != null)
			{
				chunkView.SetActive(true);
			}
		}

		private void ChunkHidden(MessageChunkChanged args)
		{
			VoxelKey chunkKey = args.chunkKey;
			ChunkView view = GetView(chunkKey.x, chunkKey.y, chunkKey.z, false);
			if (view != null)
			{
				view.SetActive(false);
			}
		}

		private void ChunkDisposed(MessageChunkChanged args)
		{
			VoxelKey chunkKey = args.chunkKey;
			ChunkView chunkView = chunkViews.Get(chunkKey.x, chunkKey.y, chunkKey.z);
			if (chunkView != null)
			{
				chunkView.Clear();
			}
		}

		public ChunkView GetView(int x, int y, int z, bool create = true)
		{
			ChunkView chunkView = chunkViews.Get(x, y, z);
			if (chunkView == null && create)
			{
				chunkView = new ChunkView();
				chunkView.ChunkKey = new VoxelKey(x, y, z);
				chunkView.viewManager = this;
				chunkViews.Set(x, y, z, chunkView);
			}
			return chunkView;
		}

		public void Update()
		{
			for (int i = 0; (float)i < RenderMeshInFrameLimit; i++)
			{
				ApplyMesh();
			}
		}

		private void ApplyMesh()
		{
			if (currentMeshBox_ == null)
			{
				if (holders_.Count <= 0)
				{
					return;
				}
				currentMeshBox_ = holders_.Dequeue();
				currentView_ = GetView(currentMeshBox_.chunkKey.x, currentMeshBox_.chunkKey.y, currentMeshBox_.chunkKey.z);
				meshIterator_ = 0;
				this.ChunkRenderedLibEvent.SafeInvoke(currentMeshBox_.chunkKey);
			}
			if (currentMeshBox_ == null)
			{
				return;
			}
			if (meshIterator_ <= currentMeshBox_.Length)
			{
				Mesh mesh = currentMeshBox_[meshIterator_];
				if (mesh != null)
				{
					ChunkViewHierarchy orCreate = currentView_.GetOrCreate(meshIterator_);
					orCreate.render.sharedMaterial = ((meshIterator_ >= currentMeshBox_.SolidLength) ? transMaterial : solidMaterial);
					FlushMesh(orCreate.filter.mesh, mesh);
				}
				meshIterator_++;
				return;
			}
			int count = currentView_.Views.Count;
			while (meshIterator_ < count)
			{
				currentView_.Views[meshIterator_].gameObject.SetActive(false);
				meshIterator_++;
			}
			this.ChunkRenderedUnityEvent.SafeInvoke(currentView_.ChunkKey);
			currentMeshBox_.Dispose();
			currentMeshBox_ = null;
			currentView_ = null;
		}

		private void FlushMesh(UnityEngine.Mesh uMesh, Mesh vMesh)
		{
			uMesh.Clear();
			try
			{
				Vector3[] vertexes = vMesh.vertexes;
				Vector3[] normals = vMesh.normals;
				Vector2[] uvs = vMesh.uvs;
				Color32[] colors = vMesh.colors;
				int[] triangles = vMesh.triangles;
				uMesh.vertices = vertexes;
				uMesh.normals = normals;
				uMesh.uv = uvs;
				uMesh.colors32 = colors;
				uMesh.triangles = triangles;
			}
			catch (Exception ex)
			{
				Log.Temp("FlushMesh exception:\n" + ex);
			}
		}
	}
}

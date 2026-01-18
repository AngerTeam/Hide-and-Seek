using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine.Clouds
{
	public class CloudManager : IDisposable
	{
		public Vector3 Wind;

		private UnityEvent unityEvent_;

		private static PerlinNoise3D noise3D_;

		private Material cloudMaterial_;

		public GameObject CloudParent;

		private Vector3 cloudVoxelSize_ = new Vector3(15f, 5f, 15f);

		private CloudView currentView_;

		private int currentViewIndex_;

		private float height_;

		private int regionScale_;

		private int regionX_ = int.MinValue;

		private int regionZ_ = int.MinValue;

		private List<CloudView> view_;

		public int layer;

		public CloudBuilder Builder { get; private set; }

		public GameObject Player { get; private set; }

		public CloudManager(float height, GameObject player = null, Material cloudMaterial = null, int visibilityDistanceMax = 100, int layer = 0)
		{
			Player = player;
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			cloudMaterial_ = ((!(cloudMaterial == null)) ? cloudMaterial : Resources.Load<Material>("CloudMaterial"));
			regionScale_ = 2 * visibilityDistanceMax / 15;
			height_ = height;
			view_ = new List<CloudView>();
			noise3D_ = PerlinNoise3D.Noise3D;
			Builder = new CloudBuilder(cloudVoxelSize_);
			if (CloudParent == null)
			{
				CloudParent = new GameObject("CloudLayer");
			}
			CloudParent.layer = ((layer <= 0) ? 8 : layer);
			Vector3 position = CloudParent.transform.position;
			position.y = height;
			CloudParent.transform.position = position;
			Wind = new Vector3(-0.2f, 0f, -0.3f);
			unityEvent_.Subscribe(UnityEventType.Update, UpdateClouds);
		}

		public void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UpdateClouds);
			if (CloudParent != null)
			{
				UnityEngine.Object.Destroy(CloudParent);
			}
		}

		private void UpdateClouds()
		{
			Vector3 vector = Vector3.zero;
			if (Player != null)
			{
				vector = Player.transform.position;
			}
			if (CloudParent != null)
			{
				Vector3 position = CloudParent.transform.position;
				position.y = height_;
				CloudParent.transform.position = position + Wind * Time.deltaTime;
				vector.x -= CloudParent.transform.position.x;
				vector.z -= CloudParent.transform.position.z;
				int num = (int)(vector.x / ((float)regionScale_ * cloudVoxelSize_.x));
				int num2 = (int)(vector.z / ((float)regionScale_ * cloudVoxelSize_.z));
				if (num != regionX_ || num2 != regionZ_)
				{
					regionX_ = num;
					regionZ_ = num2;
					GenerateClouds();
				}
			}
		}

		private CloudView AddView()
		{
			CloudView cloudView = new CloudView(cloudMaterial_, CloudParent.transform, Vector3.zero, true);
			cloudView.GameObject.name = string.Format("Clouds ({0})", currentViewIndex_);
			view_.Add(cloudView);
			return cloudView;
		}

		private void GenerateClouds()
		{
			int num = regionScale_ * 3;
			int num2 = regionScale_ * 3;
			bool[,] array = new bool[num, num2];
			for (int i = 0; i < num; i++)
			{
				for (int j = 0; j < num2; j++)
				{
					float num3 = i + (regionX_ - 1) * regionScale_;
					float num4 = j + (regionZ_ - 1) * regionScale_;
					float num5 = (float)noise3D_.Noise(num3 * 0.7f, 1.399999976158142, num4 * 0.6f);
					num5 += (float)noise3D_.Noise(num3 * 0.14f, 1.399999976158142, num4 * 0.12f);
					num5 /= 2f;
					array[i, j] = num5 > 0.12f;
				}
			}
			if (view_.Count == 0)
			{
				AddView();
			}
			currentViewIndex_ = 0;
			currentView_ = view_[currentViewIndex_];
			Builder.MaxVertexesRreached += HandleBuilderMaxVertexesRreached;
			for (int i = 0; i < num; i++)
			{
				for (int j = 0; j < num2; j++)
				{
					bool pX = i < num - 1 && array[i + 1, j];
					bool nX = i > 0 && array[i - 1, j];
					bool pZ = j < num2 - 1 && array[i, j + 1];
					bool nZ = j > 0 && array[i, j - 1];
					Builder.BuildCloudBox(i + (regionX_ - 1) * regionScale_, j + (regionZ_ - 1) * regionScale_, array[i, j], pX, nX, pZ, nZ);
				}
			}
			Builder.MaxVertexesRreached -= HandleBuilderMaxVertexesRreached;
			Builder.meshHolder.FillRestOfMeshWithVoid();
			Builder.SetMesh(currentView_.Mesh);
			currentView_.RefreshMesh();
		}

		private void HandleBuilderMaxVertexesRreached()
		{
			Builder.SetMesh(currentView_.Mesh);
			currentView_.RefreshMesh();
			currentViewIndex_++;
			if (currentViewIndex_ >= view_.Count)
			{
				currentView_ = AddView();
			}
			else
			{
				currentView_ = view_[currentViewIndex_];
			}
		}
	}
}

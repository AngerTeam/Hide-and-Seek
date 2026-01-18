using System;
using System.Collections.Generic;
using CraftyBundles;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyVoxelEngine;
using Extensions;
using MyPlayerInput;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace ShapesModule
{
	public class ShapeManager : Singleton
	{
		private FilesManager filesManager_;

		private MyPlayerStatsModel myPlayerManager_;

		private QueueManager queueManager_;

		private GameObject shapeRoot_;

		private UnityEvent unityEvent_;

		private VoxelEngine voxelEngine_;

		public List<ShapeInstance> Shapes { get; private set; }

		public ShapeInteraction ShapeInteraction { get; private set; }

		public event EventHandler<ShapeEventArgs> OnShapeReady;

		public event Action<ShapeInstance> ShapeEntered;

		public ShapeManager()
		{
			shapeRoot_ = new GameObject("ShapeManager");
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<ShapesContentMap>();
			ShapeInteraction = new ShapeInteraction();
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			myPlayerManager_.MovedShiftDistance -= CheckPoint;
			if (Shapes != null)
			{
				foreach (ShapeInstance shape in Shapes)
				{
					shape.Dispose();
				}
				Shapes.Clear();
				Shapes = null;
			}
			if (shapeRoot_ != null)
			{
				UnityEngine.Object.Destroy(shapeRoot_);
			}
		}

		public void CheckPoint()
		{
			if (Shapes == null || ShapeInteraction == null)
			{
				return;
			}
			Vector3 position = myPlayerManager_.stats.Position;
			position = position.MoveY(MyPlayerInputContentMap.PlayerSettings.bodyHeight * 0.5f);
			ShapeInstance shapeInstance = null;
			for (int i = 0; i < Shapes.Count; i++)
			{
				ShapeInstance shapeInstance2 = Shapes[i];
				if (shapeInstance2 != null && shapeInstance2.CheckCollision(position))
				{
					this.ShapeEntered.SafeInvoke(shapeInstance2);
					ShapeInteraction.TriggerShapeEnter(shapeInstance2);
					shapeInstance = shapeInstance2;
				}
			}
			if (shapeInstance != null)
			{
				ShapeInteraction.TriggerShapeExit(shapeInstance);
			}
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
			SingletonManager.Get<FilesManager>(out filesManager_);
			SingletonManager.Get<QueueManager>(out queueManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.TryGet<VoxelEngine>(out voxelEngine_);
			Shapes = new List<ShapeInstance>();
			myPlayerManager_.MovedShiftDistance += CheckPoint;
		}

		public void InitLoading(int islandTemplateId)
		{
			Shapes.Clear();
			foreach (IslandObjectsEntries value in ShapesContentMap.IslandObjects.Values)
			{
				if (value.template_id == islandTemplateId)
				{
					AddShape(value);
				}
			}
			queueManager_.AddTask(BuildShapes);
		}

		public void InitLoading(List<ShapeInstanceEntries> islandObjects)
		{
			Shapes.Clear();
			foreach (ShapeInstanceEntries islandObject in islandObjects)
			{
				AddShape(islandObject);
			}
			queueManager_.AddTask(BuildShapes);
		}

		private void AddShape(ShapeInstanceEntries islandObjectEntries)
		{
			ShapeInstance shapeInstance = CreateShape();
			shapeInstance.SetId(islandObjectEntries);
			shapeInstance.Transform.position = Vector3Utils.SafeParse(islandObjectEntries.pos);
			shapeInstance.Transform.rotation = Quaternion.Euler(Vector3Utils.SafeParse(islandObjectEntries.rotation));
			ObjectModelsEntries value;
			if (ShapesContentMap.ObjectModels.TryGetValue(islandObjectEntries.ModelId, out value) && !string.IsNullOrEmpty(value.bundle))
			{
				shapeInstance.typeId = islandObjectEntries.type_id;
				shapeInstance.fileHolder = filesManager_.AddLoadBundleTask(value.GetFullBundlePath());
				Shapes.Add(shapeInstance);
			}
		}

		private void BuildShapes()
		{
			foreach (ShapeInstance shape in Shapes)
			{
				RenderHierarchyUtils.TryInstansiate(shape.fileHolder, out shape.shapeObject);
				if (!(shape.shapeObject == null))
				{
					shape.shapeObject.transform.SetParent(shape.Transform);
					shape.shapeObject.transform.localPosition = Vector3.zero;
					shape.shapeObject.transform.localRotation = Quaternion.identity;
					shape.UpdateColliders();
					shape.SetNameAndLayer(shape.fileHolder.loadedAssetBundle.name);
					if (this.OnShapeReady != null)
					{
						this.OnShapeReady(this, new ShapeEventArgs(shape));
					}
				}
			}
			if (voxelEngine_ != null)
			{
				unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
				UnityUpdate();
			}
		}

		private ShapeInstance CreateShape()
		{
			GameObject gameObject = new GameObject("shape:null");
			gameObject.transform.SetParent(shapeRoot_.transform);
			return new ShapeInstance(gameObject);
		}

		private void UnityUpdate()
		{
			if (Shapes == null)
			{
				return;
			}
			for (int i = 0; i < Shapes.Count; i++)
			{
				ShapeInstance shapeInstance = Shapes[i];
				if (shapeInstance == null || shapeInstance.Transform == null)
				{
					break;
				}
				Vector3 position = shapeInstance.Transform.position;
				VoxelKey voxelKey = new VoxelKey(position);
				voxelKey /= 16f;
				ChunkView view = voxelEngine_.ViewManager.GetView(voxelKey.x, voxelKey.y, voxelKey.z);
				shapeInstance.Active = view != null && view.visible;
			}
		}
	}
}

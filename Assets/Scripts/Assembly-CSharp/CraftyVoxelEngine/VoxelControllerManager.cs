using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelControllerManager : PermanentSingleton
	{
		public VoxelController currentController;

		public VoxelInteractionModel voxelInteractionModel_;

		private VoxelCore voxelCore_;

		private VoxelEngine voxelEngine_;

		private VoxelInteraction voxelInteraction_;

		private UnityEvent unityEvent_;

		private ObjectPool<VoxelController> entityPool;

		private Dictionary<VoxelKey, VoxelController> ControllersByKey;

		private List<VoxelController> Controllers;

		private Material cracksMaterial_;

		public float outDuration = 0.5f;

		public VoxelViewManager VoxelViewManager { get; private set; }

		public event Action<VoxelEventArgs> VoxelDestroyed;

		public VoxelControllerManager()
		{
			entityPool = new ObjectPool<VoxelController>();
			ControllersByKey = new Dictionary<VoxelKey, VoxelController>();
			Controllers = new List<VoxelController>();
			currentController = null;
		}

		public void Reset()
		{
			foreach (VoxelController controller in Controllers)
			{
				controller.Hide();
			}
		}

		public override void Init()
		{
			GetSingleton<UnityEvent>(out unityEvent_);
			GetSingleton<VoxelEngine>(out voxelEngine_);
			GetSingleton<VoxelInteraction>(out voxelInteraction_);
			GetSingleton<VoxelInteractionModel>(out voxelInteractionModel_);
			voxelInteraction_.controller.VoxelDestroyed += HandlePopVoxel;
			voxelCore_ = voxelEngine_.core;
			VoxelViewManager = voxelEngine_.ViewManager;
			VoxelViewManager.ChunkRenderedLibEvent += ChunkRendered;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public override void Dispose()
		{
			voxelInteraction_.controller.VoxelDestroyed -= HandlePopVoxel;
			VoxelViewManager.ChunkRenderedLibEvent -= ChunkRendered;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		}

		private void HandlePopVoxel(VoxelEventArgs args)
		{
			VoxelController value;
			if (ControllersByKey.TryGetValue(args.GlobalKey, out value))
			{
				value.Locked = true;
			}
		}

		private void ChunkRendered(VoxelKey chunkKey)
		{
			for (int i = 0; i < Controllers.Count; i++)
			{
				VoxelController voxelController = Controllers[i];
				if (voxelController.chunkKey.Equals(chunkKey))
				{
					voxelController.hideObjects = true;
					voxelController.Locked = false;
				}
			}
		}

		public void SetCracksMaterial(Material material)
		{
			cracksMaterial_ = material;
		}

		public void Update()
		{
			for (int num = Controllers.Count - 1; num >= 0; num--)
			{
				VoxelController voxelController = Controllers[num];
				if (!voxelController.Locked || voxelController.timeOut < Time.fixedTime)
				{
					voxelController.Hide();
					entityPool.Release(voxelController);
					Controllers.RemoveAt(num);
					ControllersByKey.Remove(voxelController.globalKey);
				}
			}
		}

		public void AttachForHide(VoxelKey globalKey, GameObject obj)
		{
			VoxelController value;
			if (ControllersByKey.TryGetValue(globalKey, out value))
			{
				value.ObjectsForHide.Add(obj);
			}
		}

		public void HitVoxel(VoxelKey globalKey, int hit, float duration = 0f, bool useLocal = false)
		{
			if (duration <= 0f)
			{
				duration = outDuration;
			}
			duration *= 2f;
			VoxelController value;
			ControllersByKey.TryGetValue(globalKey, out value);
			if (value == null)
			{
				value = entityPool.Get();
				if (cracksMaterial_ != null)
				{
					value.view.CracksView.SharedMaterial = new Material(cracksMaterial_);
				}
				ControllersByKey.Add(globalKey, value);
				Controllers.Add(value);
			}
			if (value.indestructable)
			{
				currentController = null;
				if (!voxelInteractionModel_.silentLogic)
				{
					Exc.Report(3351);
				}
				return;
			}
			if (value.value == 0)
			{
				if (useLocal)
				{
					Voxel voxel;
					if (!voxelCore_.GetVoxel(globalKey, out voxel) || voxel.Value == 0)
					{
						return;
					}
					VoxelData data;
					if (voxelEngine_.GetVoxelData(voxel.Value, out data))
					{
						value.Init(data, globalKey, voxel.Rotation);
					}
				}
				else
				{
					value.Init(voxelInteraction_.model.data, voxelInteraction_.model.globalKey, voxelInteraction_.model.rotation);
				}
			}
			value.globalKey = globalKey;
			if (currentController != null && currentController != value)
			{
				currentController.Locked = false;
			}
			value.Locked = true;
			value.DoHit(hit);
			value.timeOut = Time.fixedTime + duration;
			if (value.destroyed)
			{
				this.VoxelDestroyed.SafeInvoke(new VoxelEventArgs(globalKey, 0, (ushort)value.value));
				currentController = null;
			}
			else
			{
				currentController = value;
			}
		}
	}
}

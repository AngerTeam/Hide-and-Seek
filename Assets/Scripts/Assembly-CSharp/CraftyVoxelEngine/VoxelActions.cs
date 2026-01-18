using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelActions : VoxelActionsBase
	{
		private MessageRenderVoxel renderVoxel_;

		private MessageReRenderAll reRenderAll_;

		private MessageResetAll resetAll_;

		private MessageSaveMapToFile saveMapToFile_;

		private MessageSetViewDistance setViewDistance_;

		private MessageSetViewPosition setViewPosition_;

		private MessageSetVoxel setVoxel_;

		private MessageStartRender startRender_;

		public VoxelActions(VoxelCore voxelCore, Dictionary<int, Action<DataSerializable>> handlers)
			: base(voxelCore, handlers)
		{
			setVoxel_ = new MessageSetVoxel();
			setViewPosition_ = new MessageSetViewPosition();
			setViewDistance_ = new MessageSetViewDistance();
			startRender_ = new MessageStartRender();
			renderVoxel_ = new MessageRenderVoxel();
			resetAll_ = new MessageResetAll();
			reRenderAll_ = new MessageReRenderAll();
			saveMapToFile_ = new MessageSaveMapToFile();
		}

		public int RenderVoxel(int voxelId, bool textureScale, Action<DataSerializable> callback)
		{
			VoxelActionsBase.buffer_.Reset();
			renderVoxel_.voxelID = voxelId;
			renderVoxel_.textureScale = textureScale;
			renderVoxel_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int ReRenderAll(Action<DataSerializable> callback = null)
		{
			VoxelActionsBase.buffer_.Reset();
			reRenderAll_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int ResetAll(Action<DataSerializable> callback = null)
		{
			VoxelActionsBase.buffer_.Reset();
			resetAll_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int ResetVoxelDiffs(Action<DataSerializable> callback)
		{
			return 0;
		}

		public int SaveMapToFile(Action<DataSerializable> callback = null)
		{
			VoxelActionsBase.buffer_.Reset();
			saveMapToFile_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int SetViewDistance(float rendDistance, float viewDistance, Action<DataSerializable> callback)
		{
			VoxelActionsBase.buffer_.Reset();
			setViewDistance_.rendDistance = rendDistance;
			setViewDistance_.viewDistance = viewDistance;
			setViewDistance_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int SetViewPosition(Vector3 position, Action<DataSerializable> callback = null)
		{
			VoxelActionsBase.buffer_.Reset();
			setViewPosition_.position = position;
			setViewPosition_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int SetVoxel(VoxelKey globalKey, ushort value, byte rotation = 0, bool useHit = false, [Optional] Vector3 point, byte side = 0, bool isPlayer = true, Action<DataSerializable> callback = null)
		{
			VoxelActionsBase.buffer_.Reset();
			setVoxel_.globalKey = globalKey;
			setVoxel_.value = value;
			setVoxel_.rotation = rotation;
			setVoxel_.useHit = useHit;
			setVoxel_.point = point;
			setVoxel_.side = side;
			setVoxel_.isPlayer = isPlayer;
			setVoxel_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}

		public int StartRender(Action<DataSerializable> callback)
		{
			VoxelActionsBase.buffer_.Reset();
			startRender_.Serialize(VoxelActionsBase.buffer_);
			return AddMessage(callback);
		}
	}
}

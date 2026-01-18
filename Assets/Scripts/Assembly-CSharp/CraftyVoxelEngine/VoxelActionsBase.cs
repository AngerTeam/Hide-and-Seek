using System;
using System.Collections.Generic;

namespace CraftyVoxelEngine
{
	public class VoxelActionsBase
	{
		protected VoxelCore core_;

		protected static DataBuffer buffer_ = new DataBuffer(8192);

		protected Dictionary<int, Action<DataSerializable>> handlers;

		public VoxelActionsBase(VoxelCore voxelCore, Dictionary<int, Action<DataSerializable>> handlers)
		{
			core_ = voxelCore;
			this.handlers = handlers;
		}

		protected int AddMessage(Action<DataSerializable> callback)
		{
			int num = core_.AddMessage(buffer_);
			if (callback != null)
			{
				handlers.Add(num, callback);
			}
			return num;
		}
	}
}

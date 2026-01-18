using System;
using System.Collections.Generic;
using Extensions;

namespace CraftyVoxelEngine
{
	public class VoxelEventsBase
	{
		protected VoxelCore core_;

		protected static DataBuffer buffer_ = new DataBuffer(8192);

		protected Dictionary<int, Action<DataSerializable>> handlers;

		public VoxelEventsBase(VoxelCore voxelCore, Dictionary<int, Action<DataSerializable>> handlers)
		{
			core_ = voxelCore;
			this.handlers = handlers;
		}

		public static void HandleMessage<T>(DataBuffer buffer, Action<DataSerializable> handler, Action<T> action) where T : DataSerializable, new()
		{
			T param = new T();
			if (handler != null || action != null)
			{
				param.Deserialize(buffer);
			}
			handler.SafeInvoke(param);
			action.SafeInvoke(param);
		}
	}
}

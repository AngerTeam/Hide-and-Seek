using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelManager : IDisposable
	{
		public IntPtr pointer;

		public static VoxelRaycastHit EmptyRaycastHit = VoxelRaycastHit.EmptyMessage;

		public bool lockRaycast;

		public bool Disposed { get; private set; }

		public VoxelManager(IntPtr pointer)
		{
			this.pointer = pointer;
			Disposed = false;
		}

		[DllImport("VoxelCore")]
		private static extern VoxelRaycastHit RayCast(IntPtr manager, Vector3 origin, Vector3 direction, float limit, bool ignoreNoCollide);

		[DllImport("VoxelCore")]
		private static extern bool RayTest(IntPtr manager, Vector3 start, Vector3 end, bool ignoreNoCollide);

		[DllImport("VoxelCore")]
		private static extern bool HitCast(IntPtr manager, Vector3 position);

		[DllImport("VoxelCore")]
		private static extern CircleHit CircleCast(IntPtr manager, Vector3 position, float radius);

		[DllImport("VoxelCore")]
		private static extern SphereHit SphereCast(IntPtr manager, Vector3 position, float radius);

		[DllImport("VoxelCore")]
		private static extern VoxelRegion GetRegion(IntPtr manager, VoxelKey key);

		[DllImport("VoxelCore")]
		private static extern VoxelRegion GetTrigger(IntPtr manager, VoxelKey key);

		public VoxelRaycastHit RayCast(Vector3 origin, Vector3 direction, float limit, bool ignoreNoCollide)
		{
			if (Disposed)
			{
				return EmptyRaycastHit;
			}
			if (lockRaycast)
			{
				return EmptyRaycastHit;
			}
			return RayCast(pointer, origin, direction, limit, ignoreNoCollide);
		}

		public bool RayTest(Vector3 start, Vector3 end, bool ignoreNoCollide)
		{
			if (Disposed)
			{
				return false;
			}
			if (lockRaycast)
			{
				return false;
			}
			return RayTest(pointer, start, end, ignoreNoCollide);
		}

		public bool HitCast(Vector3 position)
		{
			if (Disposed)
			{
				return false;
			}
			return HitCast(pointer, position);
		}

		public CircleHit CircleCast(Vector3 position, float radius)
		{
			if (Disposed)
			{
				return new CircleHit(false);
			}
			try
			{
				CircleHit result = CircleCast(pointer, position, radius);
				Debug.DrawLine(position, result.Point, Color.green, 5f);
				return result;
			}
			catch
			{
				return new CircleHit(false);
			}
		}

		public SphereHit SphereCast(Vector3 position, float radius)
		{
			if (Disposed)
			{
				return new SphereHit(false);
			}
			return SphereCast(pointer, position, radius);
		}

		public VoxelRegion GetRegion(VoxelKey key)
		{
			if (Disposed)
			{
				return default(VoxelRegion);
			}
			return GetRegion(pointer, key);
		}

		public VoxelRegion GetTrigger(VoxelKey key)
		{
			if (Disposed)
			{
				return default(VoxelRegion);
			}
			return GetTrigger(pointer, key);
		}

		[DllImport("VoxelCore")]
		private static extern void SetSavePath(IntPtr manager, string path, int length);

		public void SetSavePath(string path, int length)
		{
			SetSavePath(pointer, path, length);
		}

		[DllImport("VoxelCore")]
		private static extern VoxelKey GetHighestVoxel(IntPtr manager);

		[DllImport("VoxelCore")]
		private static extern int GetLogicVoxelListSize(IntPtr manager);

		[DllImport("VoxelCore")]
		private static extern void GetLogicVoxelList(IntPtr manager, KeyedVoxel[] array, int length);

		public VoxelKey GetHighestVoxel()
		{
			if (Disposed)
			{
				return default(VoxelKey);
			}
			return GetHighestVoxel(pointer);
		}

		public KeyedVoxel[] GetLogicVoxelList()
		{
			if (Disposed)
			{
				return new KeyedVoxel[0];
			}
			int logicVoxelListSize = GetLogicVoxelListSize(pointer);
			KeyedVoxel[] array = new KeyedVoxel[logicVoxelListSize];
			GetLogicVoxelList(pointer, array, array.Length);
			return array;
		}

		public void Dispose()
		{
			Disposed = true;
		}
	}
}

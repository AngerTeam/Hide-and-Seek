using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelSettings : IDisposable
	{
		private IntPtr pointer_;

		public bool Disposed { get; private set; }

		public int Count
		{
			get
			{
				return GetDataLength(pointer_);
			}
		}

		public VoxelSettings(IntPtr pointer)
		{
			pointer_ = pointer;
			Disposed = false;
		}

		[DllImport("VoxelCore")]
		private static extern void BindDataArray(IntPtr settings, int length);

		[DllImport("VoxelCore")]
		private static extern int GetDataLength(IntPtr settings);

		[DllImport("VoxelCore")]
		private static extern bool GetDataData(IntPtr settings, int index, out VoxelData data);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetRawData(IntPtr settings, int index);

		[DllImport("VoxelCore")]
		private static extern void GetFirstTextureUV(IntPtr settings, int index, int texIndex, out Vector2 vec);

		[DllImport("VoxelCore")]
		private static extern void AddMesh(IntPtr settings, byte[] data, int length, ushort modelId, bool splitBySides);

		[DllImport("VoxelCore")]
		private static extern void SetAtlassSize(IntPtr settings, Vector2 atlasSize);

		[DllImport("VoxelCore")]
		private static extern void SetPowerOfAO(IntPtr settings, float power);

		[DllImport("VoxelCore")]
		private static extern void SetLogicVoxel(IntPtr settings, ushort[] voxels, int lenth);

		[DllImport("VoxelCore")]
		private static extern void SetRenderLogicVoxel(IntPtr settings, bool render);

		[DllImport("VoxelCore")]
		private static extern void SetSpawnProtectionRegion(IntPtr settings, VoxelKey radius);

		private static void SetSeparatetransparent(IntPtr settings, bool separate)
		{
			Log.Warning("SetSeparatetransparent not implemented in current library version!");
		}

		public void BindDataArray(int length)
		{
			if (!Disposed)
			{
				BindDataArray(pointer_, length);
			}
		}

		public bool GetData(int voxelId, out VoxelData data)
		{
			if (Disposed)
			{
				data = default(VoxelData);
				return false;
			}
			return GetDataData(pointer_, voxelId, out data);
		}

		public Vector2 GetFirstTextureUv(int index, int texIndex)
		{
			if (Disposed)
			{
				return default(Vector2);
			}
			Vector2 vec;
			GetFirstTextureUV(pointer_, index, texIndex, out vec);
			return vec;
		}

		public void AddMesh(byte[] data, int length, ushort modelId, bool splitBySides)
		{
			if (!Disposed)
			{
				AddMesh(pointer_, data, length, modelId, splitBySides);
			}
		}

		public void SetAtlassSize(Vector2 atlasSize)
		{
			if (!Disposed)
			{
				SetAtlassSize(pointer_, atlasSize);
			}
		}

		public void SetPowerOfAO(float power)
		{
			if (!Disposed)
			{
				SetPowerOfAO(pointer_, power);
			}
		}

		public void SetLogicVoxel(ushort[] voxels)
		{
			if (!Disposed)
			{
				SetLogicVoxel(pointer_, voxels, voxels.Length);
			}
		}

		public void SetRenderLogicVoxel(bool render)
		{
			if (!Disposed)
			{
				SetRenderLogicVoxel(pointer_, render);
			}
		}

		public void SetSpawnProtectionRegion(VoxelKey radius)
		{
			if (!Disposed)
			{
				SetSpawnProtectionRegion(pointer_, radius);
			}
		}

		public void SetSeparatetransparent(bool separate)
		{
			if (!Disposed)
			{
				SetSeparatetransparent(pointer_, separate);
			}
		}

		public void Dispose()
		{
			Disposed = true;
		}
	}
}

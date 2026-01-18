using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelCore : IDisposable
	{
		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public delegate void MyDelegate(string str);

		public static bool DEBUG;

		private IntPtr pointer;

		public bool isWorking
		{
			get
			{
				return Core_IsWorking(pointer);
			}
		}

		public bool isFinished
		{
			get
			{
				return Core_IsFinished(pointer);
			}
		}

		public bool isRunning
		{
			get
			{
				return Core_IsRunning(pointer);
			}
		}

		public VoxelSettings settings { get; private set; }

		public VoxelManager manager { get; private set; }

		public bool Disposed { get; private set; }

		public VoxelCore()
		{
			pointer = CreateCore();
			settings = new VoxelSettings(GetVoxelSettings(pointer));
			manager = new VoxelManager(GetVoxelManager(pointer));
		}

		static VoxelCore()
		{
			if (DEBUG)
			{
				MyDelegate d = Debug;
				IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(d);
				SetDebugFuntion(functionPointerForDelegate);
			}
		}

		[DllImport("VoxelCore")]
		public static extern void SetDebugFuntion(IntPtr functPointer);

		private static void Debug(string str)
		{
			Log.CPPVE(str);
		}

		[DllImport("VoxelCore")]
		public static extern IntPtr CreateCore();

		[DllImport("VoxelCore")]
		public static extern IntPtr GetVoxelSettings(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern IntPtr GetVoxelManager(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern IntPtr GetRenderer(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern bool GetVoxel(IntPtr that, VoxelKey key, out Voxel voxel);

		[DllImport("VoxelCore")]
		public static extern bool IsWorking(IntPtr that);

		[DllImport("VoxelCore")]
		private static extern int SendMessage_SetVoxelData(IntPtr that, int amf_length, byte[] amf, int json_length, byte[] json, bool noMesh = false);

		[DllImport("VoxelCore")]
		private static extern int SendMessage_SetMeshData(IntPtr that, int obj_length, byte[] obj, int meshID);

		[DllImport("VoxelCore")]
		private static extern int SendMessage_SetMapData(IntPtr that, int map_length, byte[] map);

		[DllImport("VoxelCore")]
		private static extern int SendMessage_SetMultypleVoxels(IntPtr that, int voxels_length, KeyedVoxel[] voxels);

		[DllImport("VoxelCore")]
		public static extern int AddMessage(IntPtr that, byte[] data, int length);

		[DllImport("VoxelCore")]
		public static extern bool Core_IsWorking(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern bool Core_IsFinished(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern bool Core_IsRunning(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern bool ReceiveMessage(IntPtr that, byte[] data, int length);

		[DllImport("VoxelCore")]
		public static extern Quaternion GetQuaternionByRotation(byte rotor);

		[DllImport("VoxelCore")]
		public static extern void StopMainCycle(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern void DestroyCore(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern void ShowRendererStatus(IntPtr that);

		[DllImport("VoxelCore")]
		public static extern void ResetRenderer(IntPtr that);

		public void Dispose()
		{
			Log.Warning("VoxelCore.Dispose()");
			settings.Dispose();
			manager.Dispose();
			if (!Disposed)
			{
				DestroyCore(pointer);
				pointer = IntPtr.Zero;
				Disposed = true;
			}
		}

		public bool GetVoxel(VoxelKey key, out Voxel voxel)
		{
			voxel = default(Voxel);
			if (Disposed)
			{
				return false;
			}
			Voxel voxel2;
			bool voxel3 = GetVoxel(pointer, key, out voxel2);
			voxel = voxel2;
			return voxel3;
		}

		public void SetVoxelData(byte[] amf, byte[] json)
		{
			if (!Disposed)
			{
				SendMessage_SetVoxelData(pointer, amf.Length, amf, json.Length, json);
			}
		}

		public void SetMeshData(int meshId, byte[] data)
		{
			if (!Disposed)
			{
				SendMessage_SetMeshData(pointer, data.Length, data, meshId);
			}
		}

		public void SetMapData(byte[] data)
		{
			if (!Disposed)
			{
				SendMessage_SetMapData(pointer, data.Length, data);
			}
		}

		public void SetMultypleVoxels(KeyedVoxel[] voxels)
		{
			if (!Disposed && voxels != null)
			{
				SendMessage_SetMultypleVoxels(pointer, voxels.Length, voxels);
			}
		}

		public int AddMessage(DataBuffer b)
		{
			if (Disposed)
			{
				return 0;
			}
			return AddMessage(pointer, b.buffer, b.buffer.Length);
		}

		public bool ReceiveMessage(DataBuffer b)
		{
			if (Disposed)
			{
				return false;
			}
			return ReceiveMessage(pointer, b.buffer, b.buffer.Length);
		}

		public void StopMainCycle()
		{
			if (!Disposed)
			{
				StopMainCycle(pointer);
			}
		}

		public void ShowRendererStatus()
		{
			if (!Disposed)
			{
				ShowRendererStatus(pointer);
			}
		}

		public void ResetRenderer()
		{
			if (!Disposed)
			{
				ResetRenderer(pointer);
			}
		}
	}
}

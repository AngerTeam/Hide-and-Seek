using System.Collections.Generic;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelBoxHolder
	{
		private struct VoxelRaw
		{
			public ushort value;

			public byte rotation;

			public VoxelRaw(ushort val, byte rot)
			{
				value = val;
				rotation = rot;
			}
		}

		public const ushort Magic = 30306;

		private VoxelRaw[,,] map;

		private VoxelKey scale_;

		private VoxelEngine voxelEngine_;

		public bool Filled;

		public VoxelKey scale
		{
			get
			{
				return scale_;
			}
		}

		public VoxelBoxHolder(VoxelEngine voxelEngine)
		{
			Filled = false;
			voxelEngine_ = voxelEngine;
		}

		public void Clear()
		{
			Filled = false;
			scale_.Set(0, 0, 0);
			map = null;
		}

		public void GetFrom(VoxelKey offset, VoxelKey Size)
		{
			if (voxelEngine_ == null)
			{
				return;
			}
			scale_ = Size;
			map = new VoxelRaw[scale_.x, scale_.y, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelKey voxelKey = new VoxelKey(i, j, k) + offset;
						Voxel voxel;
						if (voxelEngine_.core.GetVoxel(voxelKey, out voxel))
						{
							map[i, j, k] = new VoxelRaw(voxel.Value, voxel.Rotation);
						}
					}
				}
			}
			Filled = true;
		}

		public void SetTo(VoxelKey offset, bool replaceByEmpty = false)
		{
			if (voxelEngine_ == null || !Filled)
			{
				return;
			}
			List<KeyedVoxel> list = new List<KeyedVoxel>();
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelKey voxelKey = new VoxelKey(i, j, k) + offset;
						VoxelRaw voxelRaw = map[i, j, k];
						if (voxelRaw.value != 0 || !replaceByEmpty)
						{
							list.Add(new KeyedVoxel(voxelKey, voxelRaw.value, voxelRaw.rotation));
						}
					}
				}
			}
			voxelEngine_.core.SetMultypleVoxels(list.ToArray());
		}

		public byte[] Serialize()
		{
			if (!Filled)
			{
				return null;
			}
			int num = scale_.x * scale_.y * scale_.z * 3 + 8;
			byte[] array = new byte[num];
			set(array, 0, 30306);
			set(array, 2, (ushort)scale_.x);
			set(array, 4, (ushort)scale_.y);
			set(array, 6, (ushort)scale_.z);
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						int num2 = key(i, j, k) * 3 + 8;
						set(array, num2, map[i, j, k].value);
						array[num2 + 2] = map[i, j, k].rotation;
					}
				}
			}
			return array;
		}

		public bool Deserialize(byte[] data)
		{
			ushort num = get(data, 0);
			if (num != 30306)
			{
				Log.Warning("Input data not voxel box!");
				return false;
			}
			scale_.x = get(data, 2);
			scale_.y = get(data, 4);
			scale_.z = get(data, 6);
			map = new VoxelRaw[scale_.x, scale_.y, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						int num2 = key(i, j, k) * 3 + 8;
						map[i, j, k].value = get(data, num2);
						map[i, j, k].rotation = data[num2 + 2];
					}
				}
			}
			Filled = true;
			return true;
		}

		private void set(byte[] buf, int key, ushort val)
		{
			buf[key + 1] = (byte)((uint)(val >> 8) & 0xFFu);
			buf[key] = (byte)(val & 0xFFu);
		}

		private ushort get(byte[] buf, int key)
		{
			return (ushort)((buf[key + 1] << 8) | buf[key]);
		}

		private int key(int x, int y, int z)
		{
			return (z * scale_.y + y) * scale_.x + x;
		}

		private void Switch(ref int A, ref int B)
		{
			int num = A;
			A = B;
			B = num;
		}

		public void RotateXplus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.x, scale_.z, scale_.y];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.XN90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[i, scale_.z - k - 1, j] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.y, ref scale_.z);
			map = array;
		}

		public void RotateXminus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.x, scale_.z, scale_.y];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.XP90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[i, k, scale_.y - j - 1] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.y, ref scale_.z);
			map = array;
		}

		public void RotateYplus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.z, scale_.y, scale_.x];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.YN90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[k, j, scale_.x - i - 1] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.x, ref scale_.z);
			map = array;
		}

		public void RotateYminus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.z, scale_.y, scale_.x];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.YP90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[scale_.z - k - 1, j, i] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.x, ref scale_.z);
			map = array;
		}

		public void RotateZplus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.y, scale_.x, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.ZN90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[scale_.y - j - 1, i, k] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.x, ref scale_.y);
			map = array;
		}

		public void RotateZminus90()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.y, scale_.x, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						VoxelData data;
						if (voxelEngine_.GetVoxelData(map[i, j, k].value, out data))
						{
							if (data.CanRotateInHand || data.StairRotation || data.TorchRotation)
							{
								map[i, j, k].rotation = VoxelMath.ZP90[map[i, j, k].rotation];
							}
						}
						else
						{
							map[i, j, k].rotation = map[i, j, k].rotation;
						}
						array[j, scale_.x - i - 1, k] = map[i, j, k];
					}
				}
			}
			Switch(ref scale_.x, ref scale_.y);
			map = array;
		}

		public void MirrorX()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.x, scale_.y, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						array[scale_.x - i - 1, j, k] = map[i, j, k];
					}
				}
			}
			map = array;
		}

		public void MirrorY()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.x, scale_.y, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						array[i, scale_.y - j - 1, k] = map[i, j, k];
					}
				}
			}
			map = array;
		}

		public void MirrorZ()
		{
			VoxelRaw[,,] array = new VoxelRaw[scale_.x, scale_.y, scale_.z];
			for (int i = 0; i < scale_.x; i++)
			{
				for (int j = 0; j < scale_.y; j++)
				{
					for (int k = 0; k < scale_.z; k++)
					{
						array[i, j, scale_.z - k - 1] = map[i, j, k];
					}
				}
			}
			map = array;
		}
	}
}

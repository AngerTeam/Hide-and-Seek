using System;
using UnityEngine;

namespace CraftyVoxelEngine.Clouds
{
	public class CloudBuilder
	{
		public VoxelMesh meshHolder;

		public bool FullMode;

		private Vector3[] normalesBySide_;

		private Vector3 size;

		private float offsetX_;

		private float offsetX2_;

		private float offsetY_;

		private float offsetY2_;

		private float offsetZ_;

		private float offsetZ2_;

		public static int CloudCutOut = 100;

		protected Vector3 LeftBottomBack
		{
			get
			{
				return new Vector3(offsetX_, offsetY_, offsetZ_);
			}
		}

		protected Vector3 LeftBottomFront
		{
			get
			{
				return new Vector3(offsetX_, offsetY_, offsetZ2_);
			}
		}

		protected Vector3 LeftTopBack
		{
			get
			{
				return new Vector3(offsetX_, offsetY2_, offsetZ_);
			}
		}

		protected Vector3 LeftTopFront
		{
			get
			{
				return new Vector3(offsetX_, offsetY2_, offsetZ2_);
			}
		}

		protected Vector3 RightBottomBack
		{
			get
			{
				return new Vector3(offsetX2_, offsetY_, offsetZ_);
			}
		}

		protected Vector3 RightBottomFront
		{
			get
			{
				return new Vector3(offsetX2_, offsetY_, offsetZ2_);
			}
		}

		protected Vector3 RightTopBack
		{
			get
			{
				return new Vector3(offsetX2_, offsetY2_, offsetZ_);
			}
		}

		protected Vector3 RightTopFront
		{
			get
			{
				return new Vector3(offsetX2_, offsetY2_, offsetZ2_);
			}
		}

		public event Action MaxVertexesRreached;

		public CloudBuilder(Vector3 size, bool full = true)
		{
			FullMode = full;
			this.size = size;
			meshHolder = new VoxelMesh();
			meshHolder.SetSize(256);
			normalesBySide_ = new Vector3[6];
			normalesBySide_[3] = Vector3.down;
			normalesBySide_[1] = Vector3.left;
			normalesBySide_[4] = Vector3.forward;
			normalesBySide_[5] = Vector3.back;
			normalesBySide_[0] = Vector3.right;
			normalesBySide_[2] = Vector3.up;
		}

		public void SetMesh(UnityEngine.Mesh mesh)
		{
			meshHolder.FlushToUnity(mesh);
		}

		public void BuildCloudBox(int x, int z, bool cloudValue, bool PX = false, bool NX = false, bool PZ = false, bool NZ = false)
		{
			offsetX_ = (float)x * size.x;
			offsetZ_ = (float)z * size.z;
			offsetX2_ = (float)(x + 1) * size.x;
			offsetZ2_ = (float)(z + 1) * size.z;
			if (!cloudValue)
			{
				return;
			}
			float num = 0.5f * size.y;
			if (FullMode)
			{
				offsetY_ = 0f - num;
				offsetY2_ = num;
				BuildQuad(2);
				BuildQuad(3);
				if (!PX)
				{
					BuildQuad(0);
				}
				if (!NX)
				{
					BuildQuad(1);
				}
				if (!PZ)
				{
					BuildQuad(4);
				}
				if (!NZ)
				{
					BuildQuad(5);
				}
			}
			else
			{
				offsetY_ = 0f;
				offsetY2_ = 0f;
				BuildQuad(2);
				BuildQuad(3);
			}
		}

		protected void BuildQuad(byte side)
		{
			int vectorOffset = meshHolder.visibleQuadCount * 4;
			int intOffset = meshHolder.visibleQuadCount * 6;
			BuildQuad(side, vectorOffset, intOffset, meshHolder.vertices, meshHolder.normals, meshHolder.triangles);
			meshHolder.visibleQuadCount++;
			if (meshHolder.visibleQuadCount >= meshHolder.MaxQuadCount)
			{
				PublishMaxVertexesRreached();
				meshHolder.visibleQuadCount = 0;
			}
		}

		protected void PublishMaxVertexesRreached()
		{
			if (this.MaxVertexesRreached != null)
			{
				this.MaxVertexesRreached();
			}
		}

		private void BuildQuad(byte side, int vectorOffset, int intOffset, Vector3[] vertices, Vector3[] normales, int[] triangles)
		{
			if (vectorOffset < vertices.Length)
			{
				switch (side)
				{
				case 3:
					vertices[vectorOffset] = LeftBottomFront;
					vertices[vectorOffset + 1] = RightBottomFront;
					vertices[vectorOffset + 2] = RightBottomBack;
					vertices[vectorOffset + 3] = LeftBottomBack;
					break;
				case 1:
					vertices[vectorOffset] = LeftTopBack;
					vertices[vectorOffset + 1] = LeftTopFront;
					vertices[vectorOffset + 2] = LeftBottomFront;
					vertices[vectorOffset + 3] = LeftBottomBack;
					break;
				case 4:
					vertices[vectorOffset] = LeftTopFront;
					vertices[vectorOffset + 1] = RightTopFront;
					vertices[vectorOffset + 2] = RightBottomFront;
					vertices[vectorOffset + 3] = LeftBottomFront;
					break;
				case 5:
					vertices[vectorOffset] = RightTopBack;
					vertices[vectorOffset + 1] = LeftTopBack;
					vertices[vectorOffset + 2] = LeftBottomBack;
					vertices[vectorOffset + 3] = RightBottomBack;
					break;
				case 0:
					vertices[vectorOffset] = RightTopFront;
					vertices[vectorOffset + 1] = RightTopBack;
					vertices[vectorOffset + 2] = RightBottomBack;
					vertices[vectorOffset + 3] = RightBottomFront;
					break;
				case 2:
					vertices[vectorOffset] = LeftTopBack;
					vertices[vectorOffset + 1] = RightTopBack;
					vertices[vectorOffset + 2] = RightTopFront;
					vertices[vectorOffset + 3] = LeftTopFront;
					break;
				}
				Vector3 vector = normalesBySide_[side];
				normales[vectorOffset] = vector;
				normales[vectorOffset + 1] = vector;
				normales[vectorOffset + 2] = vector;
				normales[vectorOffset + 3] = vector;
				triangles[intOffset] = 3 + vectorOffset;
				triangles[intOffset + 1] = 1 + vectorOffset;
				triangles[intOffset + 2] = 0 + vectorOffset;
				triangles[intOffset + 3] = 3 + vectorOffset;
				triangles[intOffset + 4] = 2 + vectorOffset;
				triangles[intOffset + 5] = 1 + vectorOffset;
			}
		}
	}
}

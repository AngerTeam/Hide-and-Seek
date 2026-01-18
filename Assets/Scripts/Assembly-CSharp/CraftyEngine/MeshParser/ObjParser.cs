using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

namespace CraftyEngine.MeshParser
{
	public class ObjParser
	{
		private const string O = "o";

		private const string G = "g";

		private const string V = "v";

		private const string VT = "vt";

		private const string VN = "vn";

		private const string F = "f";

		private const string MTL = "mtllib";

		private const string UML = "usemtl";

		public List<Vector3> ver;

		public List<Vector3> nor;

		public List<Vector2> tex;

		public List<Face> fce;

		public bool DEBUG = true;

		public string LoadedFileName;

		private int[] idxs;

		private Face[] first_in_side;

		private RawMesh[] raw;

		private Face lastFace_;

		public List<RawMesh> rawMeshs { get; private set; }

		public ObjParser()
		{
			ver = new List<Vector3>();
			nor = new List<Vector3>();
			tex = new List<Vector2>();
			fce = new List<Face>();
		}

		public void Parse(string data, bool splitBySides = false)
		{
			string[] array = data.Split("\n".ToCharArray());
			LoadedFileName = array[2];
			int num;
			for (int i = 0; i < array.Length; i++)
			{
				string text = array[i];
				num = text.IndexOf("#");
				if (num != -1)
				{
					text = text.Substring(0, num);
				}
				string[] array2 = text.Split(" ".ToCharArray());
				switch (array2[0])
				{
				case "v":
					ver.Add(new Vector3(getFloat(array2[1]), getFloat(array2[2]), getFloat(array2[3])));
					break;
				case "vn":
					nor.Add(new Vector3(getFloat(array2[1]), getFloat(array2[2]), getFloat(array2[3])));
					break;
				case "vt":
					tex.Add(new Vector2(getFloat(array2[1]), getFloat(array2[2])));
					break;
				case "f":
				{
					Face face = new Face();
					for (int j = 1; j < array2.Length; j++)
					{
						string[] array3 = array2[j].Trim().Split("/".ToCharArray());
						FaceIndex item = default(FaceIndex);
						if (array3.Length > 0)
						{
							item.ver = getInt(array3[0]) - 1;
						}
						if (array3.Length > 1)
						{
							item.tex = getInt(array3[1]) - 1;
						}
						if (array3.Length > 2)
						{
							item.nor = getInt(array3[2]) - 1;
						}
						face.indexes.Add(item);
					}
					if (face.indexes.Count > 2)
					{
						if (face.indexes.Count == 3)
						{
							fce.Add(face);
						}
						else if (face.indexes.Count == 4)
						{
							Face face2 = new Face();
							face2.indexes.Add(face.indexes[0]);
							face2.indexes.Add(face.indexes[1]);
							face2.indexes.Add(face.indexes[2]);
							fce.Add(face2);
							Face face3 = new Face();
							face3.indexes.Add(face.indexes[0]);
							face3.indexes.Add(face.indexes[2]);
							face3.indexes.Add(face.indexes[3]);
							fce.Add(face3);
						}
						else if (face.indexes.Count >= 5)
						{
							Log.Warning("OBJ WARNING: face.indexes.Count >= 5 !\n" + array[0] + "\n" + array[2]);
							Face face4 = new Face();
							face4.indexes.Add(face.indexes[0]);
							face4.indexes.Add(face.indexes[1]);
							face4.indexes.Add(face.indexes[2]);
							fce.Add(face4);
							Face face5 = new Face();
							face5.indexes.Add(face.indexes[0]);
							face5.indexes.Add(face.indexes[2]);
							face5.indexes.Add(face.indexes[3]);
							fce.Add(face5);
							Face face6 = new Face();
							face6.indexes.Add(face.indexes[0]);
							face6.indexes.Add(face.indexes[3]);
							face6.indexes.Add(face.indexes[4]);
							fce.Add(face6);
						}
					}
					break;
				}
				}
			}
			rawMeshs = new List<RawMesh>();
			if (splitBySides)
			{
				idxs = new int[7];
				first_in_side = new Face[7];
				raw = new RawMesh[7];
				for (int k = 0; k < 7; k++)
				{
					idxs[k] = 0;
					raw[k] = new RawMesh();
					first_in_side[k] = null;
				}
				float num2 = float.MinValue;
				foreach (Face item3 in fce)
				{
					foreach (FaceIndex index in item3.indexes)
					{
						if (ver[index.ver].x > num2)
						{
							num2 = ver[index.ver].x;
						}
					}
					if (item3.TestX(ver, 0.5f))
					{
						AddFaceToSide(item3, 0);
					}
					else if (item3.TestX(ver, -0.5f))
					{
						AddFaceToSide(item3, 1);
					}
					else if (item3.TestY(ver, 0.5f))
					{
						AddFaceToSide(item3, 2);
					}
					else if (item3.TestY(ver, -0.5f))
					{
						AddFaceToSide(item3, 3);
					}
					else if (item3.TestZ(ver, 0.5f))
					{
						AddFaceToSide(item3, 4);
					}
					else if (item3.TestZ(ver, -0.5f))
					{
						AddFaceToSide(item3, 5);
					}
					else
					{
						AddFaceToSide(item3, 6);
					}
				}
				rawMeshs.AddRange(raw);
				return;
			}
			num = 0;
			RawMesh item2 = new RawMesh();
			foreach (Face item4 in fce)
			{
				foreach (FaceIndex index2 in item4.indexes)
				{
					PushToMesh(item2, index2, num++);
				}
			}
			rawMeshs.Add(item2);
		}

		private void AddFaceToSide(Face face, int side)
		{
			if (face != lastFace_)
			{
				lastFace_ = face;
				if (first_in_side[side] == null)
				{
					first_in_side[side] = face;
				}
				{
					foreach (FaceIndex index in face.indexes)
					{
						PushToMesh(raw[side], index, idxs[side]++);
					}
					return;
				}
			}
			Log.Warning("Trying add face multiple time");
		}

		private void PushToMesh(RawMesh raw, FaceIndex faceIndex, int idx)
		{
			raw.ver.Add(ver[faceIndex.ver]);
			raw.tex.Add(tex[faceIndex.tex]);
			raw.nor.Add(nor[faceIndex.nor]);
			raw.col.Add(Color.white);
			raw.tri.Add(idx);
		}

		private float getFloat(string v)
		{
			return Convert.ToSingle(v.Trim(), new CultureInfo("en-US"));
		}

		private int getInt(string v)
		{
			if (v == null || v.Length == 0)
			{
				return -1;
			}
			return Convert.ToInt32(v.Trim(), new CultureInfo("en-US"));
		}

		private Color getColor(string[] p)
		{
			return new Color(getFloat(p[1]), getFloat(p[2]), getFloat(p[3]));
		}
	}
}

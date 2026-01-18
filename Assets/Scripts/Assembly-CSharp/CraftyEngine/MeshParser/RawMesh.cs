using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.MeshParser
{
	public class RawMesh
	{
		public List<Vector3> ver { get; private set; }

		public List<Vector3> nor { get; private set; }

		public List<Vector2> tex { get; private set; }

		public List<Color32> col { get; private set; }

		public List<int> tri { get; private set; }

		public RawMesh()
		{
			ver = new List<Vector3>();
			nor = new List<Vector3>();
			tex = new List<Vector2>();
			col = new List<Color32>();
			tri = new List<int>();
		}

		public override string ToString()
		{
			return string.Format("RawMesh:\n\tver: {0}\n\tnor: {1}\n\ttex: {2}\n\tcol: {3}\n\ttri: {4}", ver.Count, nor.Count, tex.Count, col.Count, tri.Count / 3);
		}
	}
}

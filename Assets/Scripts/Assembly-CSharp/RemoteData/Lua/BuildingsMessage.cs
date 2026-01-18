using Interlace.Amf;
using UnityEngine;

namespace RemoteData.Lua
{
	public class BuildingsMessage : RemoteMessage
	{
		public string refId;

		public int buildingId;

		public float x;

		public float y;

		public float z;

		public BuildingsMessage(string refId, int buildingId, Vector3 vector)
		{
			this.refId = refId;
			this.buildingId = buildingId;
			x = vector.x;
			y = vector.y;
			z = vector.z;
		}

		public BuildingsMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			refId = Get<string>(source, "ref_id", false);
			buildingId = Get<int>(source, "building_id", false);
			x = Get<float>(source, "x", false);
			y = Get<float>(source, "y", false);
			z = Get<float>(source, "z", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public Vector3 ToVector3()
		{
			return new Vector3(x, y, z);
		}

		public override string ToString()
		{
			return string.Format("BuildingsMessage: refId: {0}; buildingId: {1}; x: {2}; y: {3}; z: {4};", refId, buildingId, x, y, z);
		}
	}
}

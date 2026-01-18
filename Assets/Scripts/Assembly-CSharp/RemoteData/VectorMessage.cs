using Interlace.Amf;
using UnityEngine;

namespace RemoteData
{
	public class VectorMessage : RemoteMessage
	{
		public double x;

		public double y;

		public double z;

		public VectorMessage(Vector3 vector)
		{
			x = vector.x;
			y = vector.y;
			z = vector.z;
		}

		public VectorMessage()
		{
		}

		public override AmfObject Serialize()
		{
			AmfObject amfObject = new AmfObject();
			amfObject.Properties["x"] = x;
			amfObject.Properties["y"] = y;
			amfObject.Properties["z"] = z;
			return amfObject;
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			x = Get<double>(source, "x", false);
			y = Get<double>(source, "y", false);
			z = Get<double>(source, "z", false);
		}

		public Vector3 ToVector3()
		{
			return new Vector3((float)x, (float)y, (float)z);
		}

		public override string ToString()
		{
			return string.Format("VectorMessage: x: {0}; y: {1}; z: {2};", x, y, z);
		}
	}
}

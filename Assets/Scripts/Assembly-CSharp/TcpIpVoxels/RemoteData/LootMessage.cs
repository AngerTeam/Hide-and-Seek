using Interlace.Amf;
using RemoteData;
using UnityEngine;

namespace TcpIpVoxels.RemoteData
{
	public class LootMessage : RemoteMessage
	{
		public int lootId;

		public int artikulId;

		public int count;

		public double x;

		public double y;

		public double z;

		public int tmp;

		public LootMessage(int lootId, int artikulId, int count, int tmp, Vector3 vector)
		{
			this.lootId = lootId;
			this.artikulId = artikulId;
			this.count = count;
			this.tmp = tmp;
			x = vector.x;
			y = vector.y;
			z = vector.z;
		}

		public LootMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			lootId = Get<int>(source, "loot_id", false);
			artikulId = Get<int>(source, "artikul_id", false);
			count = Get<int>(source, "cnt", false);
			x = Get<double>(source, "x", false);
			y = Get<double>(source, "y", false);
			z = Get<double>(source, "z", false);
			tmp = Get<int>(source, "tmp", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public Vector3 ToVector3()
		{
			return new Vector3((float)x, (float)y, (float)z);
		}

		public override string ToString()
		{
			return string.Format("LootMessage: lootId: {0}; artikulId: {1}; count: {2}; x: {3}; y: {4}; z: {5}; tmp: {6};", lootId, artikulId, count, x, y, z, tmp);
		}
	}
}

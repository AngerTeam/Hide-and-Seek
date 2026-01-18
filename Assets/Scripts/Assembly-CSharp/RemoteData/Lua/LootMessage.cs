using Interlace.Amf;
using UnityEngine;

namespace RemoteData.Lua
{
	public class LootMessage : RemoteMessage
	{
		public int lootId;

		public int artikulId;

		public int count;

		public float x;

		public float y;

		public float z;

		public LootMessage(int lootId, int artikulId, int count, Vector3 vector)
		{
			this.lootId = lootId;
			this.artikulId = artikulId;
			this.count = count;
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
			return string.Format("LootMessage: lootId: {0}; artikulId: {1}; count: {2}; x: {3}; y: {4}; z: {5};", lootId, artikulId, count, x, y, z);
		}
	}
}

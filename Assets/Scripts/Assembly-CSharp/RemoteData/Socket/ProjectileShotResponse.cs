using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ProjectileShotResponse : RemoteMessage
	{
		public int clientProjectileId;

		public SlotUpdateMessage[] slotUpdate;

		public ProjectileShotResponse(int clientProjectileId)
		{
			this.clientProjectileId = clientProjectileId;
		}

		public ProjectileShotResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			clientProjectileId = Get<int>(source, "client_projectile_id", false);
			slotUpdate = GetArray<SlotUpdateMessage>(source, "slot_update", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ProjectileShotResponse: clientProjectileId: {0};\n slotUpdate: {1}", clientProjectileId, ArrayUtils.ArrayToString(slotUpdate, "\n\t"));
		}
	}
}

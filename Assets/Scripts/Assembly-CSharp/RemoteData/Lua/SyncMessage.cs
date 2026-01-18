using Interlace.Amf;

namespace RemoteData.Lua
{
	public class SyncMessage : RemoteMessage
	{
		public PlayerSyncMessage player;

		public string deployVersion;

		public SyncMessage(PlayerSyncMessage player, string deployVersion)
		{
			this.player = player;
			this.deployVersion = deployVersion;
		}

		public SyncMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			player = GetMessage<PlayerSyncMessage>(source, "player");
			deployVersion = Get<string>(source, "deploy_version", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SyncMessage: player: {0}; deployVersion: {1};", player, deployVersion);
		}
	}
}

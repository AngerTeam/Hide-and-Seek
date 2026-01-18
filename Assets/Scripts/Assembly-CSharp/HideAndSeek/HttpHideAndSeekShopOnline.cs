using System;
using HttpNetwork;

namespace HideAndSeek
{
	public class HttpHideAndSeekShopOnline : Singleton, IHideAndSeekShopOnline, ISingleton
	{
		private HttpOnlineManager http_;

		public event Action<RemoteMessageEventArgs> BuyHideVoxelReceived;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineManager>(out http_);
		}

		public void SendBuyHideVoxel(int voxelId, int? count)
		{
			BuyHideVoxelLuaCommand buyHideVoxelLuaCommand = new BuyHideVoxelLuaCommand(voxelId);
			buyHideVoxelLuaCommand.count = count;
			http_.Send<BuyHideVoxelResponse>(buyHideVoxelLuaCommand, this.BuyHideVoxelReceived);
		}
	}
}

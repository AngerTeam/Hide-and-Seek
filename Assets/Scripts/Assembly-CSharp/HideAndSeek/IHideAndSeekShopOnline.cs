using System;

namespace HideAndSeek
{
	public interface IHideAndSeekShopOnline : ISingleton
	{
		event Action<RemoteMessageEventArgs> BuyHideVoxelReceived;

		void SendBuyHideVoxel(int voxelId, int? count);
	}
}

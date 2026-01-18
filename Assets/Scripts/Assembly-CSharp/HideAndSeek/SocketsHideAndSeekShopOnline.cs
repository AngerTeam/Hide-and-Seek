using System;
using CraftyNetworkEngine.Sockets;
using Extensions;
using Interlace.Amf;
using RemoteData;

namespace HideAndSeek
{
	public class SocketsHideAndSeekShopOnline : SocketsOnlineManagerApi, IHideAndSeekShopOnline, ISingleton
	{
		public event Action<RemoteMessageEventArgs> BuyHideVoxelReceived;

		public void SendBuyHideVoxel(int voxelId, int? count)
		{
			BuyHideVoxelLuaCommand buyHideVoxelLuaCommand = new BuyHideVoxelLuaCommand(voxelId);
			buyHideVoxelLuaCommand.count = count;
			buyHideVoxelLuaCommand.ResponceRecieved += HandleResponceRecieved;
			Send(buyHideVoxelLuaCommand);
		}

		private void HandleResponceRecieved(AmfObject obj)
		{
			PurchaseMessage message;
			if (RemoteMessage.TryRead<PurchaseMessage>(obj, out message))
			{
				RemoteMessageEventArgs param = new RemoteMessageEventArgs(message);
				this.BuyHideVoxelReceived.SafeInvoke(param);
			}
		}
	}
}

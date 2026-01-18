using System;
using Extensions;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsShopOnline : SocketsOnlineManagerApi, IShopOnline, ISingleton
	{
		public event Action<RemoteMessageEventArgs> BuyArticulReceived;

		public event Action<RemoteMessageEventArgs> AdViewReceived;

		public event Action<RemoteMessageEventArgs> BuySkinReceived;

		public event Action<RemoteMessageEventArgs> SkinUpdated;

		public event Action<RemoteMessageEventArgs> NickUpdated;

		public void SendBuyArtikul(int articulId)
		{
			BuyArtikulCommand buyArtikulCommand = new BuyArtikulCommand(articulId);
			buyArtikulCommand.ResponceRecieved += HandleBuyArtikul;
			Send(buyArtikulCommand);
		}

		private void HandleBuyArtikul(AmfObject obj)
		{
			BuyArtikulResponse message;
			RemoteMessage.TryRead<BuyArtikulResponse>(obj, out message);
			this.BuyArticulReceived.SafeInvoke(new RemoteMessageEventArgs(message));
		}

		public void SendAdView(string chestPos)
		{
			throw new NotImplementedException();
		}

		public void SendBuyEnergy()
		{
			throw new NotImplementedException();
		}

		public void SendBuyPrompts()
		{
			throw new NotImplementedException();
		}

		public void SendBuySkin(int id)
		{
			BuySkinCommand buySkinCommand = new BuySkinCommand(id);
			buySkinCommand.ResponceRecieved += HandleBuySkin;
			Send(buySkinCommand);
		}

		private void HandleBuySkin(AmfObject obj)
		{
			BuySkinResponse message;
			RemoteMessage.TryRead<BuySkinResponse>(obj, out message);
			if (this.BuySkinReceived != null)
			{
				this.BuySkinReceived(new RemoteMessageEventArgs(message));
			}
		}

		public void SendSetSkin(int skinId)
		{
			SetSkinCommand setSkinCommand = new SetSkinCommand(skinId);
			setSkinCommand.ResponceRecieved += HandleSkinUpdate;
			Send(setSkinCommand);
		}

		private void HandleSkinUpdate(AmfObject obj)
		{
			if (this.SkinUpdated != null)
			{
				this.SkinUpdated(new RemoteMessageEventArgs(null));
			}
		}

		public void SendSetNickname(string nickname)
		{
			SetNameCommand setNameCommand = new SetNameCommand(nickname);
			setNameCommand.ResponceRecieved += HandleNickUpdate;
			Send(setNameCommand);
		}

		private void HandleNickUpdate(AmfObject obj)
		{
			if (this.NickUpdated != null)
			{
				this.NickUpdated(new RemoteMessageEventArgs(null));
			}
		}
	}
}

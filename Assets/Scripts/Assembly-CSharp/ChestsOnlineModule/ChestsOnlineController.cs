using System;
using Authorization;
using HttpNetwork;
using RemoteData.Lua;

namespace ChestsOnlineModule
{
	public class ChestsOnlineController : Singleton
	{
		protected HttpOnlineModel httpModel;

		protected HttpOnlineManager http;

		public event Action<RemoteMessageEventArgs> StartChestResponseReceived;

		public event Action<RemoteMessageEventArgs> OpenChestResponseReceived;

		public event Action<RemoteMessageEventArgs> OpenAssassinsChestResponseReceived;

		public event Action<RemoteMessageEventArgs> OpenAdsChestResponseReceived;

		public override void Init()
		{
			SingletonManager.Get<HttpOnlineModel>(out httpModel);
			SingletonManager.Get<HttpOnlineManager>(out http);
		}

		public void SendStartChest(int slotId)
		{
			http.Send<ChestStartResponse>(new ChestStartLuaCommand(slotId), this.StartChestResponseReceived);
		}

		public void SendOpenAssassinsChest()
		{
			http.Send<AssassinChestOpenResponse>(new AssassinChestOpenLuaCommand(), this.OpenAssassinsChestResponseReceived);
		}

		public void SendOpenAdsChest()
		{
			http.Send<AdChestOpenResponse>(new AdChestOpenLuaCommand(), this.OpenAdsChestResponseReceived);
		}

		public void SendOpenChest(int slotId, int money = 0)
		{
			ChestOpenLuaCommand chestOpenLuaCommand = new ChestOpenLuaCommand(slotId);
			if (money > 0)
			{
				chestOpenLuaCommand.money = money;
			}
			http.Send<ChestOpenResponse>(chestOpenLuaCommand, this.OpenChestResponseReceived);
		}
	}
}

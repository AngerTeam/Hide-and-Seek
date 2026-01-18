using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerSyncMessage : PurchaseMessage
	{
		public MainMessage[] main;

		public VectorMessage[] position;

		public VectorMessage[] rotation;

		public CommonMessage common;

		public ChestSlotsMessage[] chestSlots;

		public PvpBattleMessage[] pvpBattle;

		public BattleStatMessage[] pvpStat;

		public PlayerHideMessage[] hidePosition;

		public PlayerSyncMessage(MainMessage[] main, VectorMessage[] position, VectorMessage[] rotation, CommonMessage common, PvpBattleMessage[] pvpBattle, BattleStatMessage[] pvpStat)
		{
			this.main = main;
			this.position = position;
			this.rotation = rotation;
			this.common = common;
			this.pvpBattle = pvpBattle;
			this.pvpStat = pvpStat;
		}

		public PlayerSyncMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			main = GetArray<MainMessage>(source, "main");
			position = GetArray<VectorMessage>(source, "position");
			rotation = GetArray<VectorMessage>(source, "rotation");
			common = GetMessage<CommonMessage>(source, "common");
			chestSlots = GetArray<ChestSlotsMessage>(source, "chest_slots", true);
			pvpBattle = GetArray<PvpBattleMessage>(source, "pvp_battle");
			pvpStat = GetArray<BattleStatMessage>(source, "pvp_stat");
			hidePosition = GetArray<PlayerHideMessage>(source, "hide_position", true);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSyncMessage: common: {0};\n main: {1}\n position: {2}\n rotation: {3}\n chestSlots: {4}\n pvpBattle: {5}\n pvpStat: {6}\n hidePosition: {7}", common, ArrayUtils.ArrayToString(main, "\n\t"), ArrayUtils.ArrayToString(position, "\n\t"), ArrayUtils.ArrayToString(rotation, "\n\t"), ArrayUtils.ArrayToString(chestSlots, "\n\t"), ArrayUtils.ArrayToString(pvpBattle, "\n\t"), ArrayUtils.ArrayToString(pvpStat, "\n\t"), ArrayUtils.ArrayToString(hidePosition, "\n\t")) + base.ToString();
		}
	}
}

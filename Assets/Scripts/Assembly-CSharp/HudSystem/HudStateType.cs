using System;

namespace HudSystem
{
	public class HudStateType
	{
		public const int UNDEFINED = -1;

		[Obsolete]
		public const int LIFE = 64;

		public const int PLAYER_CONTROLLER = 1;

		public const int CRAFT = 2;

		public const int PVP_ACTIONS = 4;

		public const int PVP_DEATHMATCH_SCORE_COUNTERS = 8;

		public const int LOBBY_TOP_BUTTON = 16;

		public const int CRYSTALS = 32;

		public const int XP_BAR = 128;

		public const int PVE_LEVEL_ITEMS = 256;

		public const int PVP_SPAWN_TIMER = 512;

		public const int LOBBY_LEFT_BUTTON = 1024;

		public const int LOBBY_RIGHT_BUTTON = 2048;

		public const int ADS_BUTTON = 4096;

		public const int MENU_BUTTON = 8192;

		public const int PLAYER_NICKNAME = 16384;

		public const int SHOP_BUTTON = 32768;

		public const int PVP_SCORE_DEATHMATCH = 262144;

		public const int PVP_SCORE_TEAMDEATHMATCH = 524288;

		public const int KILLCAM = 1048576;

		public const int PVP_LOBBY_LEFT_BUTTON = 2097152;

		public const int PVP_LOBBY_RIGHT_BUTTON = 4194304;

		public const int MY_PLAYER_HEALTH = 8388608;

		public const int CAST_BAR = 16777216;

		public const int PLAYER_EDITOR = 67108864;

		public const int MIX_LOBBY = 8352;

		public const int MIX_MINIMAL = 41088;

		public const int MIX_CONSTANT = 40962;

		public const int MIX_CRAFT_AND_RUN = 40963;

		public const int MIX_PVP = 25165828;

		public const int MIX_HNS_LOBBY = 27826;

		public const int SET_PVP_DEATHMATCH_PREVIEW = 25206791;

		public const int SET_PVP_DEATHMATCH = 25468943;

		public const int SET_PLAYER_EDITOR = 67117057;

		public const int SET_KILLCAM = 1089536;

		public const int SET_LOADOUT = 40960;

		public const int SET_TUTORIAL_LEVEL = 25436175;

		public const int SET_SEEKER = 25468935;

		public const int SET_HIDDER = 25468931;

		public const int SET_HIDDER_MONSTR = 25468935;

		public const int SET_HIDDEN = 25468930;

		public const int SET_NONE = 0;

		public const int SET_WINDOW_SHOP = 8352;

		public const int SET_WINDOW_CRAFT = 40962;

		public const int SET_FULL_WINDOW = 8352;
	}
}

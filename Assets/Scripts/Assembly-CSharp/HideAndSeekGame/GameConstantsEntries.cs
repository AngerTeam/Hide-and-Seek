using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class GameConstantsEntries : ContentItem
	{
		public int DOOR_LOBBY = 8;

		public int FINISH_LEVEL_TASK = 5;

		public int GOLD_PARTICLES = 54;

		public int GRAVE_STONE_ID = 55;

		public int LOBBY_OBJET_FOR_TEMP_PVE_MESSAGE = 13;

		public int LOCKED_LEVEL_MODEL = 18;

		public string PROJECT_PICTURES_CONTENT_PATH = "content/project_pictures/";

		public int PROMPT_ARROW_MODEL = 50;

		public int RUN_ANIMATIONS_ID = 5;

		public int STAR_ARTIKUL_ID = 265;

		public int STAR_NULL_ARTIKUL_ID = 274;

		public int TROPHY = 4;

		public int UNCOMPLETED_LEVEL_MODEL = 19;

		public int WEAPONE_TYPE_BOW = 3;

		public int LOBBY_SCREEN_SLEEP_TIMEOUT = 3;

		public override void Deserialize()
		{
			DOOR_LOBBY = TryGetInt(HideAndSeekGametKeys.DOOR_LOBBY, 8);
			FINISH_LEVEL_TASK = TryGetInt(HideAndSeekGametKeys.FINISH_LEVEL_TASK, 5);
			GOLD_PARTICLES = TryGetInt(HideAndSeekGametKeys.GOLD_PARTICLES, 54);
			GRAVE_STONE_ID = TryGetInt(HideAndSeekGametKeys.GRAVE_STONE_ID, 55);
			LOBBY_OBJET_FOR_TEMP_PVE_MESSAGE = TryGetInt(HideAndSeekGametKeys.LOBBY_OBJET_FOR_TEMP_PVE_MESSAGE, 13);
			LOCKED_LEVEL_MODEL = TryGetInt(HideAndSeekGametKeys.LOCKED_LEVEL_MODEL, 18);
			PROJECT_PICTURES_CONTENT_PATH = TryGetString(HideAndSeekGametKeys.PROJECT_PICTURES_CONTENT_PATH, "content/project_pictures/");
			PROMPT_ARROW_MODEL = TryGetInt(HideAndSeekGametKeys.PROMPT_ARROW_MODEL, 50);
			RUN_ANIMATIONS_ID = TryGetInt(HideAndSeekGametKeys.RUN_ANIMATIONS_ID, 5);
			STAR_ARTIKUL_ID = TryGetInt(HideAndSeekGametKeys.STAR_ARTIKUL_ID, 265);
			STAR_NULL_ARTIKUL_ID = TryGetInt(HideAndSeekGametKeys.STAR_NULL_ARTIKUL_ID, 274);
			TROPHY = TryGetInt(HideAndSeekGametKeys.TROPHY, 4);
			UNCOMPLETED_LEVEL_MODEL = TryGetInt(HideAndSeekGametKeys.UNCOMPLETED_LEVEL_MODEL, 19);
			WEAPONE_TYPE_BOW = TryGetInt(HideAndSeekGametKeys.WEAPONE_TYPE_BOW, 3);
			LOBBY_SCREEN_SLEEP_TIMEOUT = TryGetInt(HideAndSeekGametKeys.LOBBY_SCREEN_SLEEP_TIMEOUT, 3);
			base.Deserialize();
		}
	}
}

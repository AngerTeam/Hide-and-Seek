using CraftyEngine.Content;

namespace Prompts
{
	public class TutorialEntries : ContentItem
	{
		public int FINISH_LEVEL_TASK = 5;

		public int TUTORIAL_ENEMY_MOB = 1;

		public string TUTORIAL_ENEMY_PLACE = "130.5;132;115";

		public int TUTORIAL_ENEMY_SKIN = 31;

		public int TUTORIAL_INGRIDIENT_ID = 3;

		public int TUTORIAL_LEVEL_ID = 29;

		public int TUTORIAL_RECIPIE_ID = 1;

		public int TUTORIAL_WEAPON = 333;

		public string TUTORIAL_WEAPON_PLACE = "130.5;132;126.5";

		public int TUTORIAL_ENEMY_HEALTH = 100;

		public override void Deserialize()
		{
			FINISH_LEVEL_TASK = TryGetInt(PromptsKeys.FINISH_LEVEL_TASK, 5);
			TUTORIAL_ENEMY_MOB = TryGetInt(PromptsKeys.TUTORIAL_ENEMY_MOB, 1);
			TUTORIAL_ENEMY_PLACE = TryGetString(PromptsKeys.TUTORIAL_ENEMY_PLACE, "130.5;132;115");
			TUTORIAL_ENEMY_SKIN = TryGetInt(PromptsKeys.TUTORIAL_ENEMY_SKIN, 31);
			TUTORIAL_INGRIDIENT_ID = TryGetInt(PromptsKeys.TUTORIAL_INGRIDIENT_ID, 3);
			TUTORIAL_LEVEL_ID = TryGetInt(PromptsKeys.TUTORIAL_LEVEL_ID, 29);
			TUTORIAL_RECIPIE_ID = TryGetInt(PromptsKeys.TUTORIAL_RECIPIE_ID, 1);
			TUTORIAL_WEAPON = TryGetInt(PromptsKeys.TUTORIAL_WEAPON, 333);
			TUTORIAL_WEAPON_PLACE = TryGetString(PromptsKeys.TUTORIAL_WEAPON_PLACE, "130.5;132;126.5");
			TUTORIAL_ENEMY_HEALTH = TryGetInt(PromptsKeys.TUTORIAL_ENEMY_HEALTH, 100);
			base.Deserialize();
		}
	}
}

using CraftyEngine.Content;

namespace ExperienceModule
{
	public class ExpLevelsEntries : ContentItem
	{
		public int id;

		public int exp;

		public int bonus_id;

		public int money1;

		public int money2;

		public int hp_max;

		public int hp;

		public override void Deserialize()
		{
			id = TryGetInt(ExpirienceContentKeys.id);
			intKey = id;
			exp = TryGetInt(ExpirienceContentKeys.exp);
			bonus_id = TryGetInt(ExpirienceContentKeys.bonus_id);
			money1 = TryGetInt(ExpirienceContentKeys.money1);
			money2 = TryGetInt(ExpirienceContentKeys.money2);
			hp_max = TryGetInt(ExpirienceContentKeys.hp_max);
			hp = TryGetInt(ExpirienceContentKeys.hp);
			base.Deserialize();
		}
	}
}

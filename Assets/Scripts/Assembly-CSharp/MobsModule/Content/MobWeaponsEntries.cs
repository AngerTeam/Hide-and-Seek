using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobWeaponsEntries : ContentItem
	{
		public int id;

		public int mob_id;

		public int damage;

		public float range_value;

		public float cooldown;

		public int clip_size;

		public float reload_time;

		public int artikul_id;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			mob_id = TryGetInt(MobsContentKeys.mob_id);
			damage = TryGetInt(MobsContentKeys.damage);
			range_value = TryGetFloat(MobsContentKeys.range_value);
			cooldown = TryGetFloat(MobsContentKeys.cooldown);
			clip_size = TryGetInt(MobsContentKeys.clip_size);
			reload_time = TryGetFloat(MobsContentKeys.reload_time);
			artikul_id = TryGetInt(MobsContentKeys.artikul_id);
			base.Deserialize();
		}
	}
}

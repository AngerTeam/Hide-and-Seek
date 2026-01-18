using CraftyEngine.Content;
using CraftyVoxelEngine.Content;
using InventoryModule;

namespace HideAndSeek
{
	public class HideVoxelsEntries : ContentItem
	{
		public int id;

		public int voxel_id;

		public int level_min;

		public int money_type;

		public int money_cnt;

		public float store_sort;

		public float player_sort;

		public int is_default;

		public ArtikulsEntries artikul;

		public VoxelsEntries voxel;

		public override void Deserialize()
		{
			id = TryGetInt(HideAndSeekContentKeys.id);
			intKey = id;
			voxel_id = TryGetInt(HideAndSeekContentKeys.voxel_id);
			level_min = TryGetInt(HideAndSeekContentKeys.level_min);
			money_type = TryGetInt(HideAndSeekContentKeys.money_type);
			money_cnt = TryGetInt(HideAndSeekContentKeys.money_cnt);
			store_sort = TryGetFloat(HideAndSeekContentKeys.store_sort);
			player_sort = TryGetFloat(HideAndSeekContentKeys.player_sort);
			is_default = TryGetInt(HideAndSeekContentKeys.is_default);
			base.Deserialize();
		}
	}
}

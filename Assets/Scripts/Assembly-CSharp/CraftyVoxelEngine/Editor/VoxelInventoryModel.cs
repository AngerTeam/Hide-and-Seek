using System.Collections.Generic;
using InventoryModule;
using InventoryViewModule;
using PlayerModule.MyPlayer;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelInventoryModel : Singleton
	{
		public class Group
		{
			public List<ArtikulsEntries> artikuls;

			public ArtikulGroupsEntries entry;

			public Group(ArtikulGroupsEntries groupEntry)
			{
				entry = groupEntry;
				artikuls = new List<ArtikulsEntries>();
			}
		}

		private MyPlayerStatsModel playerModel_;

		private SlotController source_;

		private VoxelInteractionModel voxelInteractionModel_;

		public bool enableReplaceSlot;

		public List<Group> Groups { get; private set; }

		public SlotController target { get; private set; }

		public List<SlotModel> BeltSlots { get; private set; }

		public Dictionary<int, List<SlotModel>> Slots { get; private set; }

		public override void OnDataLoaded()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			GameModel gameModel = SingletonManager.Get<GameModel>();
			int count = ((!gameModel.developer) ? 8 : 10);
			bool developer = gameModel.developer;
			Slots = new Dictionary<int, List<SlotModel>>();
			BeltSlots = AddSlotsGroup(100, count, '&');
			Groups = GetVoxels(developer);
			for (int i = 0; i < Groups.Count; i++)
			{
				Group group = Groups[i];
				AddSlotsGroup(group.entry.id, group.artikuls.Count, '(');
				for (int j = 0; j < group.artikuls.Count; j++)
				{
					ArtikulsEntries artikulsEntries = group.artikuls[j];
					ArtikulItem artikulItem = new ArtikulItem(artikulsEntries.id);
					artikulItem.infiniteLogic = true;
					Slots[group.entry.id][j].Insert(artikulItem);
				}
			}
		}

		private List<SlotModel> AddSlotsGroup(int index, int count, char type)
		{
			Slots[index] = new List<SlotModel>();
			for (int i = 0; i < count; i++)
			{
				SlotModel slotModel = new SlotModel();
				slotModel.slotType = type;
				Slots[index].Add(slotModel);
			}
			return Slots[index];
		}

		public void SetCurrentArticul(int artikilId)
		{
			if (target != null)
			{
				target.Model.Insert(artikilId);
				UpdateArtikul();
			}
		}

		public void SetSource(SlotController slot)
		{
			if (source_ != null)
			{
				source_.Split(false);
			}
			source_ = slot;
			if (source_ != null)
			{
				source_.Split(true);
				if (target != null)
				{
					ArtikulItem artikulItem = new ArtikulItem(source_.Model.ArtikulId);
					artikulItem.infiniteLogic = true;
					ArtikulItem newItem = artikulItem;
					target.Model.Insert(newItem);
					UpdateArtikul();
				}
			}
		}

		public void SetTarget(SlotController slot)
		{
			if (target != null)
			{
				target.Split(false);
			}
			target = slot;
			if (target != null)
			{
				target.Split(true);
				UpdateArtikul();
			}
		}

		private List<Group> GetVoxels(bool addHidden)
		{
			ArtikulGroupsEntries artikulGroupsEntries = new ArtikulGroupsEntries();
			artikulGroupsEntries.title = "No group";
			artikulGroupsEntries.sort_val = 2.1474836E+09f;
			Group group = new Group(artikulGroupsEntries);
			List<ArtikulsEntries> list = new List<ArtikulsEntries>();
			List<int> list2 = new List<int>();
			foreach (ArtikulsEntries value3 in InventoryContentMap.Artikuls.Values)
			{
				if (value3.voxel_id > 0 && !list2.Contains(value3.voxel_id))
				{
					list2.Add(value3.voxel_id);
					list.Add(value3);
				}
			}
			list.Sort(Sort);
			Dictionary<int, Group> dictionary = new Dictionary<int, Group>();
			for (int i = 0; i < list.Count; i++)
			{
				ArtikulsEntries artikulsEntries = list[i];
				ArtikulGroupsEntries value = artikulGroupsEntries;
				bool flag;
				if (InventoryContentMap.ArtikulGroups == null)
				{
					flag = true;
				}
				else
				{
					InventoryContentMap.ArtikulGroups.TryGetValue(artikulsEntries.group_id, out value);
					flag = addHidden;
					if (value == null)
					{
						value = artikulGroupsEntries;
					}
					else if (value.use_in_editor == 1)
					{
						flag = true;
					}
				}
				if (flag)
				{
					Group value2;
					if (!dictionary.TryGetValue(value.id, out value2))
					{
						value2 = new Group(value);
						dictionary.Add(value.id, value2);
					}
					List<ArtikulsEntries> artikuls = value2.artikuls;
					artikuls.Add(artikulsEntries);
				}
				else
				{
					group.artikuls.Add(artikulsEntries);
				}
			}
			if (addHidden || dictionary.Count == 0)
			{
				dictionary.Add(0, group);
			}
			List<Group> list3 = new List<Group>();
			foreach (Group value4 in dictionary.Values)
			{
				list3.Add(value4);
			}
			list3.Sort((Group a, Group b) => a.entry.sort_val.CompareTo(b.entry.sort_val));
			return list3;
		}

		private int Sort(ArtikulsEntries x, ArtikulsEntries y)
		{
			if (x.sort_val == y.sort_val)
			{
				return x.id.CompareTo(y.id);
			}
			return x.sort_val.CompareTo(y.sort_val);
		}

		private void UpdateArtikul()
		{
			playerModel_.stats.SelectedArtikul = target.Model.ArtikulId;
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(target.Model.ArtikulId, out value))
			{
				voxelInteractionModel_.buildVoxelId = (ushort)value.voxel_id;
			}
			else
			{
				voxelInteractionModel_.buildVoxelId = 0;
			}
		}
	}
}

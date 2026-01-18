using System;
using System.Collections.Generic;
using CraftyVoxelEngine.Content;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class LogicVoxelManager : Singleton
	{
		private VoxelEngine voxelEngine_;

		private List<int> valid_;

		public VoxelKey hightestKey;

		public ushort[] VoxelIds { get; private set; }

		public Dictionary<VoxelKey, LogicVoxel> VoxelsList { get; private set; }

		public Dictionary<int, LogicVoxelsEntries> EntryByVoxel { get; private set; }

		public event Action<VoxelKey> HightestKeyFounded;

		public event Action<VoxelKey, int, byte> VoxelChanged;

		public LogicVoxelManager()
		{
			VoxelsList = new Dictionary<VoxelKey, LogicVoxel>();
			EntryByVoxel = new Dictionary<int, LogicVoxelsEntries>();
		}

		public override void Init()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			voxelEngine_.voxelEvents.LogicVoxelChanged += ChangeVoxel;
			voxelEngine_.voxelEvents.FileDataReady += UpdateVoxelsFromScannedMap;
		}

		public override void OnDataLoaded()
		{
			List<ushort> list = new List<ushort>();
			if (VoxelContentMap.LogicVoxels == null)
			{
				return;
			}
			foreach (KeyValuePair<int, LogicVoxelsEntries> logicVoxel in VoxelContentMap.LogicVoxels)
			{
				LogicVoxelsEntries value = logicVoxel.Value;
				list.Add((ushort)value.voxel_id);
				EntryByVoxel[value.voxel_id] = value;
			}
			VoxelIds = list.ToArray();
			voxelEngine_.Settings.SetLogicVoxel(VoxelIds);
		}

		public bool GetRandomVoxel(out VoxelKey key, out LogicVoxel lvoxel)
		{
			int count = VoxelsList.Count;
			if (count != 0)
			{
				int num = UnityEngine.Random.Range(0, count);
				VoxelKey[] array = new VoxelKey[count];
				LogicVoxel[] array2 = new LogicVoxel[count];
				VoxelsList.Keys.CopyTo(array, 0);
				VoxelsList.Values.CopyTo(array2, 0);
				key = array[num];
				lvoxel = array2[num];
				return true;
			}
			key = default(VoxelKey);
			lvoxel = new LogicVoxel();
			return false;
		}

		public Dictionary<int, int> CalculateVoxels()
		{
			Dictionary<int, int> dictionary = new Dictionary<int, int>();
			foreach (KeyValuePair<VoxelKey, LogicVoxel> voxels in VoxelsList)
			{
				LogicVoxel value = voxels.Value;
				int value2 = ((!dictionary.TryGetValue(value.value, out value2)) ? 1 : (value2 + 1));
				dictionary[value.value] = value2;
			}
			return dictionary;
		}

		public void SetCurrentValidVoxels(List<int> valid)
		{
			valid_ = valid;
		}

		public bool IsValidForGameMode(int logicVoxel)
		{
			if (valid_ != null)
			{
				for (int i = 0; i < valid_.Count; i++)
				{
					if (valid_[i] == logicVoxel)
					{
						return true;
					}
				}
				return false;
			}
			return true;
		}

		public void UpdateVoxelsFromScannedMap(MessageFileDataReady message)
		{
			hightestKey = voxelEngine_.Manager.GetHighestVoxel();
			KeyedVoxel[] logicVoxelList = voxelEngine_.Manager.GetLogicVoxelList();
			for (int i = 0; i < logicVoxelList.Length; i++)
			{
				KeyedVoxel keyedVoxel = logicVoxelList[i];
				VoxelKey key = keyedVoxel.GetKey();
				LogicVoxel value;
				LogicVoxelsEntries value2;
				if (!IsValidForGameMode(keyedVoxel.Value))
				{
					voxelEngine_.voxelActions.SetVoxel(key, 0);
				}
				else if (VoxelsList.TryGetValue(key, out value))
				{
					value.value = keyedVoxel.Value;
					value.rotation = keyedVoxel.Rotation;
					this.VoxelChanged.SafeInvoke(key, keyedVoxel.Value, keyedVoxel.Rotation);
				}
				else if (EntryByVoxel.TryGetValue(keyedVoxel.Value, out value2))
				{
					value = new LogicVoxel();
					value.value = keyedVoxel.Value;
					value.rotation = keyedVoxel.Rotation;
					value.entry = value2;
					VoxelsList.Add(key, value);
					this.VoxelChanged.SafeInvoke(key, keyedVoxel.Value, keyedVoxel.Rotation);
				}
			}
			this.HightestKeyFounded.SafeInvoke(hightestKey);
		}

		public void ChangeVoxel(MessageLogicVoxelChanged changed)
		{
			if (changed == null)
			{
				return;
			}
			bool flag = IsLogicVoxel(changed.newValue);
			if (!IsValidForGameMode((!flag) ? changed.oldValue : changed.newValue))
			{
				return;
			}
			VoxelKey globalKey = changed.globalKey;
			LogicVoxelsEntries value = null;
			EntryByVoxel.TryGetValue(changed.newValue, out value);
			LogicVoxel value2;
			if (VoxelsList.TryGetValue(globalKey, out value2))
			{
				if (value2.value == changed.oldValue || value2.value == changed.newValue)
				{
					if (flag)
					{
						value2.value = changed.newValue;
						value2.rotation = changed.rotation;
						value2.entry = value;
					}
					else
					{
						VoxelsList.Remove(globalKey);
						this.VoxelChanged.SafeInvoke<VoxelKey, int, byte>(globalKey, 0, 0);
					}
				}
				else
				{
					Log.Error("Wrong logic voxel!");
				}
			}
			else if (flag)
			{
				LogicVoxel logicVoxel = new LogicVoxel();
				logicVoxel.value = changed.newValue;
				logicVoxel.rotation = changed.rotation;
				logicVoxel.entry = value;
				value2 = logicVoxel;
				VoxelsList.Add(globalKey, value2);
				this.VoxelChanged.SafeInvoke(globalKey, changed.newValue, changed.rotation);
			}
		}

		public bool IsLogicVoxel(int id)
		{
			if (VoxelIds != null)
			{
				for (int i = 0; i < VoxelIds.Length; i++)
				{
					if (id == VoxelIds[i])
					{
						return true;
					}
				}
			}
			return false;
		}

		public void Reset()
		{
			VoxelsList.Clear();
		}

		public override void Dispose()
		{
			Reset();
			if (voxelEngine_ != null && voxelEngine_.voxelEvents != null)
			{
				voxelEngine_.voxelEvents.LogicVoxelChanged -= ChangeVoxel;
				voxelEngine_.voxelEvents.FileDataReady -= UpdateVoxelsFromScannedMap;
			}
		}
	}
}

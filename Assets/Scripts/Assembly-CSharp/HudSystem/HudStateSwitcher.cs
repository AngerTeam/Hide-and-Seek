using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using UnityEngine;

namespace HudSystem
{
	public class HudStateSwitcher : Singleton
	{
		private int selectedType_;

		private int[] layers_;

		private int layersCount_ = 5;

		private List<HudStateItem> itemsToRemove_;

		private Dictionary<int, List<HudStateItem>> objects_;

		private FlagListHelper helper_;

		public int SelectedType
		{
			get
			{
				return selectedType_;
			}
		}

		public event Action Changed;

		public override void Dispose()
		{
			if (objects_ != null)
			{
				objects_.Clear();
				objects_ = null;
			}
		}

		public override void Init()
		{
			layers_ = new int[layersCount_];
			for (int i = 0; i < layersCount_; i++)
			{
				layers_[i] = -1;
			}
			selectedType_ = int.MaxValue;
			objects_ = new Dictionary<int, List<HudStateItem>>();
			itemsToRemove_ = new List<HudStateItem>();
			if (CompileConstants.EDITOR)
			{
				helper_ = new FlagListHelper();
				helper_.Parse(typeof(HudStateType));
			}
		}

		public void Register(int type, params HudStateItem[] obj)
		{
			for (int i = 0; i < obj.Length; i++)
			{
				Add(type, obj[i]);
			}
		}

		public void Register(int type, params Behaviour[] obj)
		{
			for (int i = 0; i < obj.Length; i++)
			{
				HudStateItem item = new HudStateItem(obj[i]);
				Add(type, item);
			}
		}

		public void Register(int type, params GameObject[] obj)
		{
			for (int i = 0; i < obj.Length; i++)
			{
				HudStateItem item = new HudStateItem(obj[i]);
				Add(type, item);
			}
		}

		public void Switch()
		{
			Switch(selectedType_);
		}

		public void SwitchLowest(int type)
		{
			SwitchLayer(type, 4);
		}

		public void SwitchLow(int type)
		{
			SwitchLayer(type, 3);
		}

		public void SwitchNormal(int type)
		{
			SwitchLayer(type, 2);
		}

		public void SwitchHigh(int type)
		{
			SwitchLayer(type, 1);
		}

		public void SwitchHighest(int type)
		{
			SwitchLayer(type, 0);
		}

		private void SwitchLayer(int type, int layer)
		{
			if (CompileConstants.EDITOR)
			{
				Log.Info("Switch Hud State {0} for layer {1}", helper_.GetName(type), layer);
			}
			layers_[layer] = type;
			for (int i = 0; i < layersCount_; i++)
			{
				if (layers_[i] >= 0)
				{
					Switch(layers_[i]);
					break;
				}
			}
		}

		private void Switch(int switchType)
		{
			if (selectedType_ == switchType || objects_ == null)
			{
				return;
			}
			if (CompileConstants.EDITOR)
			{
				Log.Info("Switch Hud State {0}", helper_.GetName(switchType));
			}
			selectedType_ = switchType;
			foreach (KeyValuePair<int, List<HudStateItem>> item in objects_)
			{
				int key = item.Key;
				List<HudStateItem> value = item.Value;
				if (EnumUtils.Contains(selectedType_, key))
				{
					continue;
				}
				for (int i = 0; i < value.Count; i++)
				{
					HudStateItem hudStateItem = value[i];
					if (hudStateItem.gameObject == null)
					{
						itemsToRemove_.Add(hudStateItem);
					}
					else
					{
						hudStateItem.gameObject.SetActive(false);
					}
				}
				for (int j = 0; j < itemsToRemove_.Count; j++)
				{
					value.Remove(itemsToRemove_[j]);
				}
				itemsToRemove_.Clear();
			}
			foreach (KeyValuePair<int, List<HudStateItem>> item2 in objects_)
			{
				int key2 = item2.Key;
				List<HudStateItem> value2 = item2.Value;
				if (!EnumUtils.Contains(selectedType_, key2))
				{
					continue;
				}
				for (int k = 0; k < value2.Count; k++)
				{
					HudStateItem hudStateItem2 = value2[k];
					if (hudStateItem2.gameObject == null)
					{
						Log.Info("Removing {0} from hud switcher", hudStateItem2.debugName);
						itemsToRemove_.Add(hudStateItem2);
					}
					else
					{
						hudStateItem2.gameObject.SetActive(true);
						hudStateItem2.ReportActivated(selectedType_);
					}
				}
				for (int l = 0; l < itemsToRemove_.Count; l++)
				{
					value2.Remove(itemsToRemove_[l]);
				}
				itemsToRemove_.Clear();
			}
			try
			{
				if (this.Changed != null)
				{
					this.Changed();
				}
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
		}

		private void Add(int type, HudStateItem item)
		{
			objects_.GetOrSet(type).Add(item);
			bool active = EnumUtils.Contains(selectedType_, type);
			item.gameObject.SetActive(active);
		}
	}
}

using System;
using System.Collections.Generic;
using CraftyVoxelEngine.Content;
using InventoryModule;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorSpawnsValidator
	{
		public const string WARNING_FORMAT = "\n[FF3300]{0}[-]";

		private VoxelEditorModel model_;

		private LogicVoxelManager logicVoxelManager_;

		private string messageExit_;

		private string messageExitRequire_;

		public Func<int, List<int>> GetVoxelsByGameMode;

		public VoxelEditorSpawnsValidator()
		{
			SingletonManager.Get<VoxelEditorModel>(out model_);
			SingletonManager.Get<LogicVoxelManager>(out logicVoxelManager_);
			messageExit_ = Localisations.Get("Editor_ExitConfirm");
			messageExitRequire_ = Localisations.Get("Editor_SaveConfirm_Required");
		}

		public string GetVoxelLocalized(int id)
		{
			VoxelsEntries value;
			ArtikulsEntries value2;
			if (VoxelContentMap.Voxels.TryGetValue(id, out value) && InventoryContentMap.Artikuls.TryGetValue(value.drop_artikul_id, out value2))
			{
				return Localisations.Get(value2.title);
			}
			return id.ToString();
		}

		private bool Validate(Dictionary<int, int> voxelsCounts, List<int> demands)
		{
			for (int i = 0; i < demands.Count; i++)
			{
				int num = Get(voxelsCounts, demands[i]);
				if (num <= 0)
				{
					return true;
				}
			}
			return false;
		}

		private bool Validate(Dictionary<int, int> voxelsCounts, List<int> demands, out string result)
		{
			bool result2 = false;
			result = string.Empty;
			for (int i = 0; i < demands.Count; i++)
			{
				int num = Get(voxelsCounts, demands[i]);
				if (num <= 0)
				{
					result = result + GetVoxelLocalized(demands[i]) + "\n";
					result2 = true;
				}
			}
			return result2;
		}

		private int Get(Dictionary<int, int> dict, int key)
		{
			int value;
			dict.TryGetValue(key, out value);
			return value;
		}

		public string GetExitMessage()
		{
			string result = string.Empty;
			bool flag = false;
			Dictionary<int, int> voxelsCounts = logicVoxelManager_.CalculateVoxels();
			if (GetVoxelsByGameMode != null)
			{
				List<int> list = GetVoxelsByGameMode(model_.modeId);
				if (list != null)
				{
					flag = Validate(voxelsCounts, list, out result);
				}
			}
			model_.ValidSpawns = true;
			if (flag)
			{
				model_.ValidSpawns = false;
				return string.Format("{0}\n{1}\n\n{2}", messageExitRequire_, string.Format("\n[FF3300]{0}[-]", result), messageExit_);
			}
			return messageExit_;
		}

		public void ValidateSpawns()
		{
			bool flag = false;
			Dictionary<int, int> voxelsCounts = logicVoxelManager_.CalculateVoxels();
			if (GetVoxelsByGameMode != null)
			{
				List<int> list = GetVoxelsByGameMode(model_.modeId);
				if (list != null)
				{
					flag = Validate(voxelsCounts, list);
				}
			}
			model_.ValidSpawns = !flag;
		}
	}
}
